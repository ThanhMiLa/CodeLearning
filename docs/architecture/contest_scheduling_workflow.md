# Event-Driven Contest Status Scheduling Workflow

> CodeLearning Platform - Architecture Specification

This document specifies the automated lifecycle management and event-driven state orchestration for programming contests, using the **RabbitMQ Delayed Message Exchange** plugin instead of recurring database polling.

---

## 1. Technical Motivation and Architectural Design

### Limitations of Polling-Based Scheduling (Cron Jobs)
* **Excessive I/O Overhead**: Periodic polling queries (`SELECT * FROM contests WHERE start_time <= NOW() AND status = 'UPCOMING'`) consume database connections and disk I/O continuously, even during extended periods without scheduled competitions.
* **Schedule Drift**: A cron task executing on a 1-minute interval introduces up to 59 seconds of jitter, causing contests to unlock after their declared start time.
* **Synchronization Latency**: Broadcasting start events to hundreds of waiting contestants requires sub-second execution accuracy.

### Advantages of RabbitMQ Delayed Exchange
* **Millisecond Precision**: Messages are held within the exchange for the exact duration of the delay (`x-delay = targetTime - currentTime`) before being routed to the processing queue.
* **Zero Polling Load**: The database handles zero scheduled polling load between contest events.
* **Instantaneous Event Push**: When delay intervals elapse, the consumer updates contest state and triggers WebSocket STOMP messages to notify contestants immediately.

---

## 2. Architecture Coordination Flow

```mermaid
graph TD
    A[Admin creates/updates Contest] -->|Calculate delayStart & delayEnd| B(Spring Boot Backend)
    B -->|Publish message with delayStart| C[Delayed Exchange: contest.exchange]
    B -->|Publish message with delayEnd| C
    
    C -->|Sleep inside exchange for N milliseconds| C
    
    C -->|Delay expires| D[Contest Queue: contest.queue]
    D -->|Consume message| E[ContestStatusListener]
    
    E -->|1. Fetch Contest from DB| F{Contest Exist?}
    F -->|Yes| G{Idempotency Check: targetTime == dbTime?}
    F -->|No| H[Discard Message]
    
    G -->|Yes: Schedule unchanged| I[Update Contest Status & Broadcast via WebSocket]
    G -->|No: Schedule modified by Admin| J[Discard Message: Prevent overwriting current schedule]
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    autonumber
    actor Admin as Admin / Instructor
    participant API as Spring Boot Backend
    participant DB as PostgreSQL DB
    participant Rabbit as RabbitMQ (contest.exchange)
    participant Consumer as ContestStatusListener
    participant WS as WebSocket STOMP Broker
    actor Contestants as Connected Contestants

    Admin->>API: POST /api/v1/contests (Create / Reschedule Contest)
    activate API
    API->>DB: Save Contest (Status: UPCOMING, startTime, endTime)
    
    API->>API: Calculate delayStart = (startTime - now) ms
    API->>API: Calculate delayEnd = (endTime - now) ms
    
    API->>Rabbit: Send Msg (delayStart, targetTime=startTime, action=START)
    API->>Rabbit: Send Msg (delayEnd, targetTime=endTime, action=END)
    API-->>Admin: Return HTTP 201 Created
    deactivate API

    note over Rabbit: Message remains in exchange until startTime...

    Rabbit->>Consumer: Deliver START Msg to contest.queue
    activate Consumer
    Consumer->>DB: Query Contest by ID
    Consumer->>Consumer: Idempotency Check: msg.targetTime == dbContest.startTime
    
    alt Schedule Match (Contest Timing Unchanged)
        Consumer->>DB: Update Status -> RUNNING
        Consumer->>WS: Broadcast Contest Started Event (/topic/contests/{contestId})
        WS-->>Contestants: Push Real-time Event (Unlock Problems & Start Timer)
    else Schedule Changed (Admin Updated Contest Window)
        Consumer->>Consumer: Discard Message (Outdated Message)
    end
    deactivate Consumer

    note over Rabbit: Message remains in exchange until endTime...

    Rabbit->>Consumer: Deliver END Msg to contest.queue
    activate Consumer
    Consumer->>DB: Query Contest by ID
    Consumer->>Consumer: Idempotency Check: msg.targetTime == dbContest.endTime
    
    alt Schedule Match
        Consumer->>DB: Update Status -> ENDED
        Consumer->>WS: Broadcast Contest Ended Event (/topic/contests/{contestId})
        WS-->>Contestants: Push Real-time Event (Lock Submissions & Finalize Scoreboard)
    else Schedule Changed
        Consumer->>Consumer: Discard Message
    end
    deactivate Consumer
```

---

## 4. Rescheduling and Idempotency Control

In real-world contest operations, administrators may reschedule an existing competition (for example, postponing the start from 09:00 to 10:00). Messages scheduled in RabbitMQ exchanges cannot be recalled directly without exchange purge operations.

### Verification Strategy:
1. Message payloads include the targeted timestamp:
   ```java
   public record ContestStatusMessage(
       Long contestId,
       ContestStatus targetStatus,
       Instant targetTime
   ) {}
   ```
2. When the consumer processes a message after delay expiration:
   - Fetches current contest details from PostgreSQL.
   - Compares `message.targetTime()` against `contest.getStartTime()` (for `RUNNING`) or `contest.getEndTime()` (for `ENDED`).
   - **Mismatch**: Indicates that the contest schedule was modified after the message was published. The consumer discards the message without mutating the database.
   - **Match**: The schedule remains valid, and the state transition executes.

---

## 5. Real-Time Client Synchronization via WebSocket

* **Transition to `RUNNING`**:
  - Broadcasts to topic `/topic/contests/{contestId}`.
  - Client applications in the contest lobby automatically:
    1. Reveal problem statements and testcase samples.
    2. Activate the countdown timer.
    3. Enable the Monaco code editor and submission buttons.
* **Transition to `ENDED`**:
  - Emits conclusion events across all active workspaces.
  - Automatically disables code submission buttons in client interfaces.
  - Computes final penalty standings and freezes the contest leaderboard.

---

## 6. Source Code References

* **RabbitMQ Image Definition**: `backend/Dockerfile.rabbitmq`
* **Broker Configuration**: `com.thanhmila.codelearning.configuration.RabbitMQConfig`
* **Contest Service Publisher**: `com.thanhmila.codelearning.service.contest.ContestServiceImpl`
* **Queue Consumer Listener**: `com.thanhmila.codelearning.listener.ContestStatusListener`
* **WebSocket Configuration**: `com.thanhmila.codelearning.configuration.WebSocketConfig`
* **Repository**: `com.thanhmila.codelearning.repository.contest.ContestRepository`

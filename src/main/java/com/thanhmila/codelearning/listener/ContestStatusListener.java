package com.thanhmila.codelearning.listener;

import com.thanhmila.codelearning.configuration.RabbitMQConfig;
import com.thanhmila.codelearning.dto.message.ContestStatusMessage;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.context.ApplicationEventPublisher;
import com.thanhmila.codelearning.event.ContestStartedEvent;

@Slf4j
@Component
@RequiredArgsConstructor
public class ContestStatusListener {

    private final ContestRepository contestRepository;
    private final ApplicationEventPublisher applicationEventPublisher;

    @RabbitListener(queues = RabbitMQConfig.CONTEST_QUEUE)
    @Transactional
    public void handleContestStatus(ContestStatusMessage message) {
        log.info("Received contest status message: {}", message);
        try {
            Long contestId = Long.parseLong(message.getContestId());
            ContestEntity contest = contestRepository.findById(contestId).orElse(null);
            
            if (contest == null) {
                log.warn("Contest not found with id: {}", contestId);
                return;
            }

            if ("START".equals(message.getAction())) {
                if (contest.getStartTime().toInstant().equals(message.getTargetTime())) {
                    contest.setStatus(ContestStatus.RUNNING);
                    contestRepository.save(contest);
                    log.info("Contest {} status updated to RUNNING", contestId);
                    
                    // Fire event to initialize leaderboard
                    applicationEventPublisher.publishEvent(new ContestStartedEvent(this, contestId));
                } else {
                    log.info("Ignoring START message for contest {}, targetTime mismatch. Expected: {}, Actual: {}", 
                            contestId, message.getTargetTime(), contest.getStartTime().toInstant());
                }
            } else if ("END".equals(message.getAction())) {
                if (contest.getEndTime().toInstant().equals(message.getTargetTime())) {
                    contest.setStatus(ContestStatus.ENDED);
                    contestRepository.save(contest);
                    log.info("Contest {} status updated to ENDED", contestId);
                } else {
                    log.info("Ignoring END message for contest {}, targetTime mismatch. Expected: {}, Actual: {}", 
                            contestId, message.getTargetTime(), contest.getEndTime().toInstant());
                }
            }
        } catch (Exception e) {
            log.error("Error processing contest status message: {}", message, e);
        }
    }
}

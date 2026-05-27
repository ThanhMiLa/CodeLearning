# Luồng hoạt động: Cập nhật trạng thái Contest tự động bằng RabbitMQ

Giải pháp sử dụng plugin `rabbitmq_delayed_message_exchange` để đặt lịch (schedule) cập nhật trạng thái Contest thay vì dùng `CronJob` quét database liên tục. RabbitMQ cho phép thực thi độ trễ (delay) chính xác đến từng mili-giây.

## 1. Workflow Tổng Quan
```text
+--------+             +--------------+             +--------------------+
| Client |             | Contest API  |             | RabbitMQ           |
|        |             | (Publisher)  |             | (Delayed Exchange) |
+----+---+             +------+-------+             +---------+----------+
     |                        |                               |
     |--- Create Contest ---->|                               |
     |    Request             |--- Save Contest (UPCOMING) -->| (PostgreSQL)
     |                        |                               |
     |                        |--- Gửi START Msg ------------>|
     |                        |    (Delay: delayStart)        |
     |                        |                               |
     |                        |--- Gửi END Msg -------------->|
     |                        |    (Delay: delayEnd)          |
     |<-- Return Response ----|                               |
     |                        |                               |
     |                        |                             (Wait)
     |                        |                               |
     |                        |                             [Đến startTime]
     |                        |                               |---- Deliver START Msg --+
     |                        |                               |                         |
     |                        |<-- Cập nhật Status (RUNNING) ---------------------------+
     |                        |                               |
     |                        |                             (Wait)
     |                        |                               |
     |                        |                             [Đến endTime]
     |                        |                               |---- Deliver END Msg ----+
     |                        |                               |                         |
     |                        |<-- Cập nhật Status (ENDED) -----------------------------+
     |                        |                               |
```

## 2. Luồng chi tiết từng bước

### Bước 1: Publisher (Gửi thông điệp)
Trong service tạo/cập nhật Contest:
1. **Lưu DB:** Tạo hoặc Cập nhật Contest.
2. **Tính toán Delay:**
   - Thời gian chờ bắt đầu: `delay_start = startTime.toEpochMilli() - Instant.now().toEpochMilli()`
   - Thời gian chờ kết thúc: `delay_end = endTime.toEpochMilli() - Instant.now().toEpochMilli()`
3. **Gửi Message:** Gửi 2 message vào **Delayed Exchange** duy nhất (ví dụ `contest.exchange`).
   - Sử dụng routing key `contest.status.running` cho sự kiện bắt đầu.
   - Sử dụng routing key `contest.status.ended` cho sự kiện kết thúc.
   - Header của message sẽ chứa thuộc tính `x-delay` mang giá trị delay đã tính toán.
   - Thân message (body) chứa `contestId` và thời gian target (`startTime` hoặc `endTime`) để phục vụ việc kiểm tra tính hợp lệ về sau.

### Bước 2: RabbitMQ (Chờ đợi)
- Nhờ plugin `rabbitmq_delayed_message_exchange`, RabbitMQ sẽ giữ (hold) các message này trong Exchange. 
- Đến đúng thời điểm `x-delay` kết thúc, Exchange mới định tuyến (route) message tương ứng vào Queue (`contest.queue`).

### Bước 3: Consumer (Lắng nghe và Xử lý)
Một hàm `@RabbitListener` lắng nghe trên `contest.queue`:
1. Đọc ID của Contest và `target_time` từ message.
2. Tìm Contest trong Database theo ID.
3. Kiểm tra tính hợp lệ (Idempotency):
   - Đối với action START: Nếu `message.target_time == dbContest.startTime`, tiến hành đổi trạng thái thành `RUNNING`.
   - Đối với action END: Nếu `message.target_time == dbContest.endTime`, tiến hành đổi trạng thái thành `ENDED`.
   - Nếu thời gian không khớp (nghĩa là Contest đã bị đổi lịch sau đó), bỏ qua message này (Drop message).
4. Lưu thay đổi trạng thái vào DB.

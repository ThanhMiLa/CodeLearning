# 📋 KẾ HOẠCH KIỂM THỬ: EMAIL, ASYNC RABBITMQ & EXTERNAL CLIENT SERVICES
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Email Campaign, SendGrid Webhook, RabbitMQ Worker, Cloudinary & Judge0 Client**  
Vị trí tài liệu: `backend/docs/plan_test/12_PLAN_EMAIL_ASYNC_AND_EXTERNAL_SERVICES_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$**

---

## 1. Danh sách các Class trong phạm vi kiểm thử

| Thành phần | Đường dẫn file | Vai trò chính |
| :--- | :--- | :--- |
| **Service (Producer)** | `service/email/impl/EmailProducerServiceImpl.java` | Lọc user hợp lệ (`isEmailValid=true`), chia batch tối đa 500 emails/batch, đẩy message vào RabbitMQ `email.exchange`. |
| **Service (Consumer)** | `service/email/impl/EmailConsumerServiceImpl.java` | `@RabbitListener(queues = BULK_EMAIL_QUEUE)` nhận batch email, gọi SendGrid API; nếu lỗi -> lưu vào bảng DLQ `FailedEmailQueueEntity` (trạng thái `PENDING_RETRY`). |
| **Service (Client)** | `service/email/impl/SendGridApiServiceImpl.java` | WebClient gọi REST API SendGrid (`/v3/mail/send`, `/v3/templates`). |
| **Service (Media)** | `service/cloudinary/CloudinaryService.java` | Upload file (`MultipartFile`) lên Cloudinary, xóa file theo `publicId`. |
| **Service (Client)** | `service/oj/Judge0ClientService.java` | WebClient gửi batch testcase sang Judge0 (`/submissions/batch?base64_encoded=false`). |
| **Controller** | `controller/admin/AdminEmailController.java` | GET `/admin/emails/templates`, POST `/admin/emails/send` (đẩy chiến dịch email). |
| **Controller** | `controller/email/SendGridWebhookController.java` | POST `/api/webhooks/sendgrid`: Kiểm tra chữ ký webhook Twilio, parse JSON events và chuyển tiếp service. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `EmailProducerServiceImpl.java`
* **Phương thức: `processAndSendCampaign(EmailCampaignRequest request)`**
  * **Nhánh 1 (Target ALL):** `targetType.equalsIgnoreCase("ALL")` -> Gọi `userRepository.findByIsEmailValidTrue()`.
  * **Nhánh 2 (Target SPECIFIC - danh sách rỗng):** `targetType.equalsIgnoreCase("SPECIFIC")` nhưng `userIds` null hoặc rỗng -> `return` sớm, không làm gì.
  * **Nhánh 3 (Target SPECIFIC - parse ID lỗi):** Chứa ID không phải số (ví dụ `"abc"`) -> Bắt `NumberFormatException`, lọc bỏ null. Nếu sau khi lọc danh sách rỗng -> `return` sớm.
  * **Nhánh 4 (Target SPECIFIC - hợp lệ):** Lọc chỉ lấy các user có `isEmailValid == true`.
  * **Nhánh 5 (Target khác):** Loại không hợp lệ -> `return` sớm.
  * **Nhánh 6 (Cắt batch 500 & gửi RabbitMQ):** Cắt `userInfos` thành từng mảng con tối đa 500 phần tử, gán UUID `batchId`, gọi `rabbitTemplate.convertAndSend(EMAIL_EXCHANGE, ROUTING_KEY_BULK_EMAIL, message)`.

### 2.2. `EmailConsumerServiceImpl.java`
* **Phương thức: `consumeBulkEmail(BulkEmailMessage message)`**
  * **Nhánh 1 (Happy Path):** Tạo danh sách `Personalization` từ danh sách `users`, gọi `sendGridApiService.sendEmailBulk(request)` thành công.
  * **Nhánh 2 (Lỗi gửi email - Catch & Push to DLQ):** `sendGridApiService.sendEmailBulk` ném RuntimeException -> Bắt ngoại lệ, serialize `message` thành JSON, lưu vào `failedEmailQueueRepository.save(failedEntity)` với trạng thái `"PENDING_RETRY"`.
  * **Nhánh 3 (Lỗi parse JSON DLQ):** `objectMapper.writeValueAsString` ném lỗi -> Bắt lỗi và log, không làm crash consumer.

### 2.3. `SendGridApiServiceImpl.java` & `Judge0ClientService.java`
* Kiểm tra việc cấu hình headers, uri, body và xử lý response status 4xx/5xx thông qua WebClient Mock / WireMock.

### 2.4. `CloudinaryService.java`
* **`uploadFile(MultipartFile file, String folderName)`:**
  * Lấy bytes của file, truyền tham số `folder` và `resource_type: auto` vào Cloudinary SDK. Trả về `CloudinaryResponse(publicId, secureUrl)`.
* **`deleteFile(String publicId)`:**
  * Gọi `cloudinary.uploader().destroy()`. Nếu ném `IOException` -> Ném `RuntimeException("Không thể xóa file cũ trên mây")`.

### 2.5. `SendGridWebhookController.java`
* **Nhánh 1 (Chữ ký không hợp lệ):** Thiếu header `X-Twilio-Email-Event-Webhook-Signature` hoặc `X-Twilio-Email-Event-Webhook-Timestamp` -> Trả về HTTP 401.
* **Nhánh 2 (Chữ ký hợp lệ):** Parse danh sách sự kiện và gọi `webhookService.processWebhookEvents(events)`, trả về HTTP 200.
* **Nhánh 3 (Lỗi parse JSON):** Payload JSON hỏng -> Log lỗi và vẫn trả về HTTP 200 để SendGrid không gửi lại.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Class / Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **EP_01** | `EmailProducerService` | Target = "ALL", có 1200 user hợp lệ | Bắn 3 messages vào RabbitMQ (500, 500, 200) |
| **EP_02** | `EmailProducerService` | Target = "SPECIFIC", userIds = null | Không gửi message nào vào RabbitMQ |
| **EP_03** | `EmailProducerService` | Target = "SPECIFIC", userIds = ["abc", "def"] | Không gửi message nào |
| **EC_01** | `EmailConsumerService` | Message chứa 2 user, SendGrid chạy tốt | Gọi `sendGridApiService.sendEmailBulk` 1 lần |
| **EC_02** | `EmailConsumerService` | SendGrid ném ngoại lệ | Lưu bản ghi vào bảng `failed_email_queues` |
| **CLD_01** | `CloudinaryService` | Upload ảnh hợp lệ | Trả về `publicId` và `secureUrl` |
| **CLD_02** | `CloudinaryService` | Cloudinary ném `IOException` khi xóa | Ném `RuntimeException` |
| **SG_CTRL_01** | `SendGridWebhookController` | Thiếu signature header | HTTP 401 Unauthorized |
| **SG_CTRL_02** | `SendGridWebhookController` | Header đầy đủ, payload hợp lệ | HTTP 200 OK |

---

## 4. Test Blueprint Mẫu: `EmailProducerServiceImplTest.java`

```java
package com.thanhmila.codelearning.service.email.impl;

import com.thanhmila.codelearning.configuration.RabbitMQConfig;
import com.thanhmila.codelearning.dto.email.BulkEmailMessage;
import com.thanhmila.codelearning.dto.request.EmailCampaignRequest;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.amqp.rabbit.core.RabbitTemplate;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("EmailProducerServiceImpl Unit Tests")
class EmailProducerServiceImplTest {

    @Mock
    private RabbitTemplate rabbitTemplate;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private EmailProducerServiceImpl emailProducerService;

    @Test
    @DisplayName("processAndSendCampaign: Target ALL chia đúng các batch 500 emails vào RabbitMQ")
    void processAndSendCampaign_TargetAll_SplitsBatchesProperly() {
        List<UserEntity> users = new ArrayList<>();
        for (int i = 1; i <= 1050; i++) {
            users.add(UserEntity.builder().id((long) i).email("user" + i + "@example.com").isEmailValid(true).build());
        }

        when(userRepository.findByIsEmailValidTrue()).thenReturn(users);

        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("ALL");
        request.setTemplateId("d-template-123");

        emailProducerService.processAndSendCampaign(request);

        // 1050 users / 500 batch size = 3 batches (500, 500, 50)
        verify(rabbitTemplate, times(3)).convertAndSend(
                eq(RabbitMQConfig.EMAIL_EXCHANGE),
                eq(RabbitMQConfig.ROUTING_KEY_BULK_EMAIL),
                any(BulkEmailMessage.class)
        );
    }
}
```

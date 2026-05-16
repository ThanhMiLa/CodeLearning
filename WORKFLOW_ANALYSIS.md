# 📋 PHÂN TÍCH WORKFLOW JUDGE0 - SO SÁNH CODE

## 🎯 KIỂM TRA API: submitCode() (POST /online-judge/submissions)

### Workflow Yêu Cầu:
```
1. ✅ Frontend gửi OjSubmissionRequest (problemId, sourceCode, languageId, lessonId hoặc contestId)
2. ✅ Backend tạo bản ghi tổng trong online_judge_submissions với PENDING
3. ✅ Lấy toàn bộ Testcase của problemId
4. ✅ Góp code + testcase thành Judge0SubmissionItem
5. ✅ Gắn callback_url vào từng item
6. ✅ Gọi API Judge0 Batch
7. ✅ Nhận Token từ Judge0
8. ✅ Lưu Token vào online_judge_submission_details
9. ✅ Trả OjSubmissionInitialResponse cho Frontend (chứa submissionId)
```

### ✅ CODE HIỆN TẠI - ĐÃ ĐÚNG

| Bước | Dòng Code | Status | Chi Tiết |
|------|-----------|--------|----------|
| 1 | Controller L76 | ✅ | `@RequestBody OjSubmissionRequest request` |
| 2 | Dòng 58-64 | ✅ | Tạo OnlineJudgeSubmissionEntity (mẹ) |
| 3 | Dòng 51-55 | ✅ | `problemTestcaseRepository.findByProblemIdOrderByOrderIndex()` |
| 4 | Dòng 70-79 | ✅ | Loop qua testcase, build Judge0SubmissionItem |
| 5 | Dòng 68, 76 | ✅ | `callbackUrl = webhookBaseUrl + "/oj/submissions/"` |
| 6 | Dòng 86 | ✅ | `judge0ClientService.sendBatchSubmission(judge0BatchRequest)` |
| 7 | Dòng 86 | ✅ | Judge0 trả về `tokenList` |
| 8 | Dòng 97-107 | ✅ | Loop tạo OnlineJudgeSubmissionDetailEntity với Token |
| 9 | Dòng 110-114 | ✅ | Return OjSubmissionInitialResponse |

---

## ⚠️ KIỂM TRA API: processJudge0Callback() (PUT /online-judge/submissions)

### Workflow Yêu Cầu:
```
GIAI ĐOẠN 3 - WEBHOOK CALLBACK:
10. ✅ Judge0 gọi PUT callback với Judge0CallbackPayload (token + verdict)
11. ✅ Backend tìm detail bằng token
12. ✅ Update chi tiết (testcaseVerdict, executionTime, memory)
13. ✅ Đếm trạng thái: totalTestcases, processedTestcases

GIAI ĐOẠN 4 - AGGREGATION & BROADCAST:
14. ⚠️  RẼ NHÁNH: 
    - Nếu lessonId != null (Practice): Bắn WebSocket ngay
    - Nếu contestId != null (Contest): ĐỌC ĐOC, không bắn WebSocket
    
15. ✅ Kiểm tra: if (processedTestcases == totalTestcases) -> hoàn toàn
16. ✅ Tìm lỗi đầu tiên (query testcase không ACCEPTED)
17. ✅ Update final verdict & điểm số vào cha
18. ✅ Bắn WebSocket cuối cùng nếu xong
```

### ✅ CODE HIỆN TẠI - CÓ BUG

| Bước | Dòng Code | Status | Chi Tiết |
|------|-----------|--------|----------|
| 10 | Controller L99 | ✅ | PUT endpoint nhận Judge0CallbackPayload |
| 11 | Dòng 122-123 | ✅ | `findByToken()` để lấy detail |
| 12 | Dòng 132-135 | ✅ | Update verdict, time, memory |
| 13 | Dòng 139 | ✅ | `countTestcasesStatus(submissionId)` |
| **14** | **Dòng 156-167** | **❌ BUG** | **Luôn bắn WebSocket, không check lessonId vs contestId** |
| 15 | Dòng 141 | ✅ | `isFinish = totalTestcases == processedTestcases` |
| 16 | Dòng 146 | ✅ | `findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc()` |
| 17 | Dòng 151-152 | ✅ | Update submission verdict |
| 18 | Dòng 167 | ⚠️  | Bắn WebSocket **LUÔN**, cần check contest |

---

## 🐛 BUG CHI TIẾT

### BUG #1: WebSocket không phân biệt Practice vs Contest
**Vị trí:** Dòng 156-167 (processJudge0Callback)

**Workflow yêu cầu:**
```
- Nếu submission.lessonId != null (Practice Mode):
  → Bắn WebSocket ngay (mỗi callback từ Judge0)
  → Frontend hiển thị progress bar
  
- Nếu submission.contestId != null (Contest Mode):
  → "IM LẶNG" - không bắn WebSocket từng testcase
  → Chỉ bắn khi xong 100% (nếu cần)
```

**Code hiện tại - LUÔN bắn:**
```java
simpMessagingTemplate.convertAndSend("/topic/submissions/" + submissionEntity.getUser().getId(), wsMessage);
```

**Đó là lỗi vì:**
- Ở chế độ Contest, việc bắn WebSocket lẻ tẻ sẽ làm lộ kết quả từng testcase cho các thí sinh khác (qua WebSocket/Browser DevTools)
- Chỉ nên ém kết quả từng testcase cho đến khi contest kết thúc

---

### BUG #2: onlineJudgeSubmissionEntity chưa được lưu
**Vị trí:** Dòng 58-64 (submitCode) - **ĐÃ FIX ở dòng 94**

✅ Đã được sửa, không còn lỗi này.

---

## 📝 SOLUTION

### Fix BUG #1: Kiểm tra lessonId vs contestId

**Code cần chỉnh sửa ở processJudge0Callback():**

```java
// Dòng 156-167 hiệu chỉnh:

boolean isPracticeMode = submissionEntity.getLesson() != null;

// Chỉ bắn WebSocket nếu là Practice Mode (lessonId != null)
if (isPracticeMode) {
    OjWebSocketMessage wsMessage = OjWebSocketMessage.builder()
            .submissionId(submissionId)
            .testcaseId(submissionDetail.getTestcase().getId())
            .testcaseVerdict(testcaseVerdict)
            .overallVerdict(overallVerdict)
            .executionTimeMs(submissionDetail.getExecutionTimeMs())
            .memoryUsedKb(submissionDetail.getMemoryUsedKb())
            .totalTestcases(submissionCountDto.totalTestcases().intValue())
            .processedTestcases(submissionCountDto.processedTestcases().intValue())
            .build();
    
    simpMessagingTemplate.convertAndSend("/topic/submissions/" + submissionEntity.getUser().getId(), wsMessage);
}
```

---

## ✨ SUMMARY

| Điểm | Status | Ghi Chú |
|-----|--------|--------|
| submitCode() flow | ✅ **ĐÚNG** | Lưu submission, gọi Judge0, nhận token, lưu detail |
| processJudge0Callback() - update detail | ✅ **ĐÚNG** | Update verdict, time, memory chính xác |
| processJudge0Callback() - aggregation | ✅ **ĐÚNG** | Đếm, tìm lỗi, update final verdict |
| **WebSocket practice mode** | ⚠️  **CÓ BUG** | Cần check `lessonId != null` trước khi bắn |
| **WebSocket contest mode** | ⚠️  **CÓ BUG** | Không nên bắn từng testcase, ém kết quả |



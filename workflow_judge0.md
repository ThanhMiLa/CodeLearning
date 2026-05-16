🚀 TỔNG QUAN LUỒNG HOẠT ĐỘNG (THE WORKFLOW)
Quy trình được chia làm 4 giai đoạn chính, luân chuyển qua 3 thành phần:
Frontend (React) ➔ Backend (Spring Boot + PostgreSQL) ➔ Judge Engine (Judge0).

➤  ĐOẠN 1: GIAO VIỆC (INITIATION) - Nhanh, Không chặn luồng
    1. Frontend Gửi Yêu Cầu: Học viên viết code xong, bấm "Submit".
    Frontend gửi OjSubmissionRequest (gồm problemId, sourceCode, languageId, lessonId hoặc contestId) lên Backend.

    2. Backend Chuẩn Bị Dữ Liệu: * Tạo 1 bản ghi tổng vào bảng online_judge_submissions với trạng thái PENDING. Lấy được submission_id.
    
    3. Lấy toàn bộ Testcase của problemId đó từ Database.
    
    4. Gói code và testcase thành danh sách Judge0SubmissionItem. 
	Đặc biệt: Gắn kèm callback_url (địa chỉ Webhook của Backend) vào từng item.
    
    5. Gọi API Judge0: Backend gửi cục dữ liệu này sang API Batch của Judge0.
    
    6. Nhận Biên Lai & Lưu DB: * Judge0 trả về ngay lập tức 1 danh sách các Token (Mã biên lai).
    
    7. Backend lấy các Token này lưu vào bảng trung gian online_judge_submission_details (mỗi testcase 1 token, trạng thái PENDING).
    
    8. Phản Hồi Frontend: Backend lập tức trả về OjSubmissionInitialResponse (chứa submissionId) cho Frontend. 
	Toàn bộ Thread của Spring Boot được giải phóng.
    
    9. Frontend Lắng Nghe: Frontend nhận submissionId và mở kết nối WebSocket vào kênh riêng của bài nộp này, 
	hiển thị giao diện "Đang chấm bài...".

➤ GIAI ĐOẠN 2: XỬ LÝ NGẦM (BACKGROUND EXECUTION)
    7. Judge0 Làm Việc: Bên trong Docker, các Worker của Judge0 lấy từng bài nộp ra khỏi Redis,
    đưa vào môi trường Sandbox để dịch và chạy code. Backend Spring Boot lúc này hoàn toàn "ngồi chơi xơi nước", không tốn chút CPU nào để chờ đợi.

➤ GIAI ĐOẠN 3: NHẬN KẾT QUẢ TỪNG TESTCASE (WEBHOOK CALLBACK)
    8. Judge0 Trả Kết Quả: Ngay khi chạy xong 1 Testcase, Judge0 đóng vai trò là "Shipper",
    chủ động gọi API PUT (Webhook) vào địa chỉ callback_url mà Backend đã dặn ở Bước 2.

	9. Backend Cập Nhật Chi Tiết: * Backend nhận Judge0CallbackPayload chứa token và kết quả (AC, WA, TLE...).
	Backend dùng token tìm đúng bản ghi trong bảng online_judge_submission_details và update trạng thái của riêng Testcase đó.

➤ GIAI ĐOẠN 4: ĐẾM, RẼ NHÁNH & TRẢ KẾT QUẢ REAL-TIME (AGGREGATION & BROADCAST)
Ngay sau Bước 9, Backend thực hiện ngay khối logic sau (Bắt buộc phải có Transaction/Lock để tránh Race Condition):

	10. Đếm Trạng Thái (1 Query Duy Nhất): Backend chạy câu JPQL đếm xem bài nộp (submission_id) này 
	có tổng cộng bao nhiêu testcase (totalTestcases), và bao nhiêu cái đã có kết quả (processedTestcases).

	11. Rẽ Nhánh UI qua WebSocket:

	- Chế độ Luyện tập (Practice - lessonId != null): Bắn ngay OjWebSocketMessage về Frontend. 
	Frontend nhận được sẽ cho thanh Progress Bar chạy lên (VD: 1/10, 2/10...) và tô màu testcase.

	- Chế độ Thi đấu (Contest - contestId != null): Backend "im lặng", không bắn WebSocket lẻ tẻ để ém kết quả.

	12. CÚ CHỐT (Khâu quyết định Final Verdict):

	- Kiểm tra: if (processedTestcases == totalTestcases) -> Đã chấm xong 100% testcase!

	- Tìm Lỗi Đầu Tiên: Backend query lấy ra testcase bị lỗi đầu tiên (sắp xếp theo order_index). 
	Nếu không có lỗi nào -> ACCEPTED. Nếu có lỗi -> Lấy lỗi đó làm Final Verdict (Ví dụ: WRONG_ANSWER).

	- Lưu DB Tổng: Update Final Verdict và Điểm số vào bảng cha online_judge_submissions.

	- Bắn WebSocket Chốt Sổ: Bắn 1 gói tin WebSocket cuối cùng chứa overallVerdict. 
	Frontend nhận được sẽ hiển thị Popup kết quả chung cuộc cho học viên.
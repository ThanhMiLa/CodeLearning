# CodeLearning Platform 🚀

Chào mừng bạn đến với **CodeLearning Platform**, một hệ thống E-learning & Online Judge tiên tiến tích hợp chấm bài tự động. Dự án hiện đã được tái cấu trúc thành một **Monorepo chuyên nghiệp** chứa cả Frontend, Backend và Database dưới dạng các mô-đun độc lập, dễ dàng quản lý và triển khai.

---

## 📂 Cấu trúc thư mục (Monorepo Layout)

Thư mục chính được tổ chức như sau:

```text
codelearning-platform/
├── backend/            # Mã nguồn Spring Boot 3.5.7 (Java 21) & Dockerfile backend
├── frontend/           # Mã nguồn React / Vite (TypeScript) & Dockerfile frontend + Nginx
├── database/           # Chứa file khởi tạo database (init.sql)
├── docs/               # Tài liệu hệ thống
├── .env                # Cấu hình môi trường toàn cục (DB, Redis, RabbitMQ, JWT, Cloudinary,...)
├── .env.example        # Bản mẫu cấu hình môi trường (.env)
├── docker-compose.yml  # File điều phối Docker Compose cho toàn bộ hệ thống
├── judge0.conf         # Cấu hình riêng cho Judge0 Sandbox
└── README.md           # Hướng dẫn chạy và quản lý dự án (file này)
```

---

## ⚙️ Hướng dẫn cấu hình môi trường (.env)

Hệ thống sử dụng các file `.env` để cấu hình:
1. **Root `.env`**: Chứa thông tin kết nối Database, Redis, RabbitMQ và các API keys (PayOS, Cloudinary...). File này được sử dụng chung cho backend và database khi chạy Docker.
2. **Frontend `.env` & `.env.local`**:
   - `frontend/.env.local` cấu hình địa chỉ API của Backend khi chạy dev cục bộ (`http://localhost:8080/codelearning`).
   - `frontend/.env` cấu hình địa chỉ API khi build production.

---

## 🐳 Triển khai với Docker Compose

Tất cả các dịch vụ đã được chuẩn hóa để build và chạy thông qua Docker Compose một cách tối ưu nhất.

### 1. Chạy các dịch vụ cốt lõi (Mặc định)
Dịch vụ cốt lõi bao gồm: **Database (PostgreSQL), Redis, RabbitMQ, Backend (Spring Boot), và Frontend (React/Nginx)**.

Chạy lệnh sau tại thư mục gốc:
```bash
docker compose up -d --build
```

Khi chạy thành công:
* **Frontend** hoạt động tại: [http://localhost:3000](http://localhost:3000)
* **Backend API** hoạt động tại: [http://localhost:8080/codelearning](http://localhost:8080/codelearning)
* **Database** cổng: `5432`
* **Redis** cổng: `6379`
* **RabbitMQ Management Dashboard**: [http://localhost:15672](http://localhost:15672) (User/Pass: `guest`/`guest`)

### 2. Chạy cùng hệ thống chấm bài (Judge0 Sandbox Profile)
Hệ thống sử dụng **Docker Profiles** để tối ưu tài nguyên. Nếu bạn cần chạy thêm Sandbox Judge0 phục vụ việc chấm bài:
```bash
docker compose --profile judge0 up -d --build
```
Lệnh này sẽ khởi chạy thêm các container `judge0-server`, `judge0-workers`, `judge0-db` và `judge0-redis`.

---

## 💻 Hướng dẫn chạy trong quá trình Phát triển (Local Development)

Nếu bạn muốn chạy từng phần độc lập để sửa code và tự động reload (hot-reload):

### Bước 1: Khởi chạy hạ tầng phụ trợ (Database, Redis, RabbitMQ)
Chỉ chạy các container phụ trợ bằng Docker:
```bash
docker compose up -d db redis rabbitmq
```

### Bước 2: Chạy Backend (Spring Boot)
1. Di chuyển vào thư mục backend:
   ```bash
   cd backend
   ```
2. Chạy ứng dụng bằng Maven Wrapper:
   ```bash
   ./mvnw spring-boot:run
   ```
   *(Hoặc mở thư mục `backend/` bằng IntelliJ IDEA / VS Code và chạy trực tiếp file main).*

### Bước 3: Chạy Frontend (Vite)
1. Di chuyển vào thư mục frontend:
   ```bash
   cd ../frontend
   ```
2. Cài đặt các gói thư viện (nếu chưa cài):
   ```bash
   npm install
   ```
3. Khởi chạy dev server:
   ```bash
   npm run dev
   ```
   *Frontend sẽ chạy tại: [http://localhost:5173](http://localhost:5173)*

---

## 📝 Tài liệu chi tiết các Module
* Xem tài liệu phát triển Backend tại: [backend/README.md](file:///Users/ngocthanh/Documents/Project/codelearning-platform/backend/README.md)
* Xem tài liệu API chi tiết tại: [frontend/docs/api_documentation.md](file:///Users/ngocthanh/Documents/Project/codelearning-platform/frontend/docs/api_documentation.md)

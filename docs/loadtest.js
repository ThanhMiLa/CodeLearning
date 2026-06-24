import http from 'k6/http';
import { check } from 'k6';

// CẤU HÌNH BÀI TEST TẠI ĐÂY
export const options = {
    vus: 100,       // Giảm xuống 10 Virtual Users
    iterations: 100 // Giảm xuống 10 requests tổng cộng
};

// HÀM NÀY SẼ ĐƯỢC CHẠY BỞI MỖI VIRTUAL USER
export default function () {
    // 1. CHÚ Ý THAY ĐỔI ĐỊA CHỈ API CỦA BẠN (nếu khác localhost)
    const url = 'http://localhost:8080/codelearning/online-judge/submissions';

    // 2. Data bài tập ID = 5, Code C++
    const payload = JSON.stringify({
        "problemId": 2,
        "languageId": 76,
        "sourceCode": "#include <iostream>\n using namespace std;\n int main() {\n    long long a, b;\n    if (cin >> a >> b) {\n        cout << a + b << endl;\n    }\n    return 0;\n}"
    });

    const params = {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMSIsInNjb3BlIjoiUk9MRV9VU0VSIENPTU1FTlRfVklFVyBDT01NRU5UX0NSRUFURSBVU0VSX1VQREFURSBRVUlaX1NVQk1JVCBPSl9QUk9CTEVNX1NVQk1JVCBPSl9QUk9CTEVNX1ZJRVcgTEVBUk5JTkdfUFJPR1JFU1NfVklFV19PV04gUVVJWl9WSUVXIFVTRVJfVklFVyBMRVNTT05fQ09NUExFVEUiLCJpc3MiOiJjb2RlbGVhcm5pbmcudGhhbmhtaWxhLmNvbSIsImV4cCI6MTc4MTQ0MTgwNSwidHlwZSI6IkFDQ0VTUyIsImlhdCI6MTc4MTQ0MDYwNSwidXNlcklkIjo1LCJqdGkiOiIwMTYxNzZlNC1hNTk1LTQ3NDctODk5Ni0xMTBmZDYxOTc5Y2QifQ.Zi5b1xnqBer6do1AyOR-tJ1LuI3pejFpC0BDnF5_tGh1heKo2tHRrpdnfeIgu-novaGtmszIyYhmBhT2AZ53ag',
        },
    };

    // 4. Bắn Request
    const res = http.post(url, payload, params);

    // Nếu thất bại, in chi tiết lỗi ra Terminal để biết nguyên nhân
    if (res.status !== 200 && res.status !== 201) {
        console.log(`[LỖI API] Status: ${res.status} | Response Body: ${res.body}`);
    }

    // 5. Kiểm đếm xem server trả về có thành công không (HTTP Status 200 hoặc 201)
    check(res, {
        'Bắn API thành công (Status 2xx)': (r) => r.status === 200 || r.status === 201,
    });
}
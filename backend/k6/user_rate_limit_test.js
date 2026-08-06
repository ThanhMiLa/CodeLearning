import http from 'k6/http';
import { check } from 'k6';

export const options = {
    scenarios: {
        user_burst_test: {
            executor: 'shared-iterations',
            vus: 15,         // Tung ra 15 người dùng ảo cùng 1 lúc
            iterations: 15,  // Tổng số lượng request cần bắn là 15 (để kích hoạt giới hạn 10 req/s)
            maxDuration: '5s'
        },
    },
};

export default function () {
    // Token bạn cung cấp
    const token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMSIsInNjb3BlIjoiUk9MRV9VU0VSIENPTU1FTlRfVklFVyBDT01NRU5UX0NSRUFURSBPSl9QUk9CTEVNX1ZJRVcgT0pfUFJPQkxFTV9TVUJNSVQgUVVJWl9WSUVXIFVTRVJfVVBEQVRFIExFU1NPTl9DT01QTEVURSBRVUlaX1NVQk1JVCBVU0VSX1ZJRVcgTEVBUk5JTkdfUFJPR1JFU1NfVklFV19PV04iLCJpc3MiOiJjb2RlbGVhcm5pbmcudGhhbmhtaWxhLmNvbSIsImV4cCI6MTc4NjA3NTA3OSwidHlwZSI6IkFDQ0VTUyIsImlhdCI6MTc4NTk4ODY3OSwidXNlcklkIjo1LCJqdGkiOiI2MDEyMTVlMC0wNWNmLTQwOGEtYWQyOS1mMmM4M2U0MWJmNmEifQ.o34QO3MHXH6EKMW-mDhv91a3fMLB8boOzfttTs2V2WjY_MZ_7VZ_nmRU14lV3AoEGjPDoHND4ZZgyIfDuueyRg';

    // Nhúng Token vào Header
    const params = {
        headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
        },
    };

    // Gửi request tới server
    const res = http.get('http://localhost:8080/codelearning/courses', params);

    // Kiểm tra kết quả
    check(res, {
        'Trạng thái 200 (Thành công)': (r) => r.status === 200,
        'Trạng thái 429 (Bị chặn do User Limit)': (r) => r.status === 429,
    });
}
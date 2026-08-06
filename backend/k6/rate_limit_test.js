import http from 'k6/http';
import { check } from 'k6';

export const options = {
    scenarios: {
        burst_test: {
            executor: 'shared-iterations',
            vus: 120,         // Tung ra 101 người dùng ảo cùng 1 lúc (đồng thời)
            iterations: 120,  // Tổng số lượng request cần bắn là 101
            maxDuration: '10s'// Thời gian tối đa để chạy kịch bản này
        },
    },
};

export default function () {
    // Gửi request tới API Public của bạn
    //const res = http.get('http://localhost:8080/codelearning/courses');
    const res = http.get('https://api.codelearning.io.vn/codelearning/courses');

    // Kiểm tra kết quả trả về
    check(res, {
        'Trạng thái 200 (Thành công)': (r) => r.status === 200,
        'Trạng thái 429 (Bị chặn do Rate Limit)': (r) => r.status === 429,
    });
}
# Kết quả kiểm tra bộ bài làm

- **Bài 1:** đã thực thi thật trên Linux; tạo thành công user + group `rikkeilms`; `ls -ld /opt/rikkei/course-service` trả về `drwxr-xr-x ... rikkeilms rikkeilms`.
- **Bài 2-4:** đã viết đúng script Docker chạy image `nginxdemos/hello`, `-d`, tên `rikkei-course-service`, port `8081:80`; **chưa chạy được Docker thực tế** vì môi trường tạo file không có Docker.
- **Bài 5-6:** đã viết script `postgres:13` với biến môi trường `POSTGRES_PASSWORD`, bind mount bền vững `/opt/rikkei/pg-data:/var/lib/postgresql/data`, kèm test giữ lại bản ghi qua việc xóa/tạo lại container; **chưa chạy được Docker thực tế** vì môi trường tạo file không có Docker.
- **Cú pháp:** tất cả 13 script `.sh` vượt qua `bash -n`.

## Bằng chứng

Không tạo ảnh `evidence_01.png`, `evidence_02.png`, `evidence_05.png` giả từ kết quả mô phỏng. Bạn cần chụp màn hình Terminal thực tế sau khi chạy script trên hệ thống Linux và lưu đúng tên nêu trong `HUONG_DAN_BANG_CHUNG.md`.

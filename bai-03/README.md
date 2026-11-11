# Bai 3 - Docker Course-Service Mock

Theo de: image `nginxdemos/hello`, container detached `rikkei-course-service`, publish `8081:80`.

```bash
bash run-course-service.sh
bash verify.sh
```

Neu loi quyen Docker: thu `sudo bash run-course-service.sh`, `sudo bash verify.sh`.
`run-course-service.sh` xoa container CUNG TEN cu de tao lai cho dung cau hinh, khong anh huong PostgreSQL.
**File nop:** `run-course-service.sh` va anh terminal THUC TE `evidence_02.png`.

# Bai 6 - PostgreSQL 13 / Persistent Storage

Theo de: Docker `postgres:13`, container `rikkei-db`, mat khau mac dinh theo de `Rikkei@2026`, bind-mount `/opt/rikkei/pg-data:/var/lib/postgresql/data`.

```bash
sudo bash deploy-postgres.sh
sudo bash verify-persistence.sh
sudo ls -la /opt/rikkei/pg-data
```

`verify-persistence.sh` chen 1 hang du lieu mau, xoa container (KHONG xoa data host), tao lai va doc du lieu de chung minh persistence.
Quan trong: neu da co database truoc do, `POSTGRES_PASSWORD` moi khong thay doi password cua database hien tai.

**File nop:** `deploy-postgres.sh` va anh terminal THUC TE `evidence_05.png`.

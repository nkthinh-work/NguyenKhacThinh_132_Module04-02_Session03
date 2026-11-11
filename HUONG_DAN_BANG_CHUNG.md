# Cach chup bang chung THUC TE truoc khi nop

Khong thay the anh bang chung bang anh minh hoa hay anh giao dien duoc ve lai. Chay cac lenh tren **may Linux co Docker** va chup man hinh that sau khi thuc thi.

## Bai 1 - `evidence_01.png`

```bash
sudo bash bai-01/setup-workspace.sh
ls -ld /opt/rikkei/course-service
```

Kiem tra ket qua co owner/group `rikkeilms rikkeilms`, quyen `drwxr-xr-x`. Chup ca 2 lenh va ket qua trong terminal, luu `bai-01/evidence_01.png`.

## Bai 2, 3, 4 - `evidence_02.png`

```bash
bash bai-02/run-course-service.sh
sudo docker ps --filter 'name=rikkei-course-service'
curl -i http://localhost:8081
```

Kiem tra co `rikkei-course-service` running, anh xa `0.0.0.0:8081->80/tcp` va HTTP 200/HTML cua NGINX demo. Chup man hinh, luu `bai-02/evidence_02.png`. Bai 3/4 co cung noi dung; neu nop rieng, co the chay script tuong ung va chup bang chung trung thuc cho tung thu muc.

## Bai 5, 6 - `evidence_05.png`

```bash
sudo bash bai-05/deploy-postgres.sh
sudo docker rm -f rikkei-db
sudo bash bai-05/deploy-postgres.sh
sudo ls -la /opt/rikkei/pg-data
sudo bash bai-05/verify-persistence.sh
```

Kiem tra xuat hien `base`, `global`, `pg_wal`, v.v. Chup terminal sau khi recreate, luu `bai-05/evidence_05.png`. Tuong tu voi bai 6.

**Luu y:** May can co Docker Engine, ket noi Docker Hub va `curl`. Repo khong kem anh gia lap chua duoc kiem chung.

# Rikkei LMS - Bo bai lam Linux & Docker (6 de)

Day la **code da lam**, khong phai file ZIP chi gom 6 PDF de bai. Co du 6 thu muc `bai-01` ... `bai-06`, moi thu muc chua script dung ten ma de yeu cau.

> **Luu y quan trong:** 6 de ban cung cap gom 3 noi dung rieng: bai 1 la quyen Linux; bai 2/3/4 la cung mot de Course-Service Mock; bai 5/6 la cung mot de PostgreSQL persistent. Ban van co the nop/commit tung thu muc doc lap.

## Yeu cau he thong

- Linux (Ubuntu/Debian hoac he thong co `useradd`, `groupadd`, `sudo`).
- Docker Engine da cai va daemon dang chay cho bai 2-6.
- `curl` cho bai 2-4.
- May chu co ket noi Internet trong lan dau Docker can tai image `nginxdemos/hello` va `postgres:13`.

## Chay bai

```bash
# Bai 01: Tao user va phan quyen
sudo bash bai-01/setup-workspace.sh
sudo bash bai-01/verify.sh

# Bai 02, 03, 04: moi bai la 1 thu muc rieng, cac lenh tuong duong nhau
bash bai-02/run-course-service.sh
bash bai-02/verify.sh
# Neu muon nop bai 3, chay bash bai-03/run-course-service.sh
# Neu muon nop bai 4, chay bash bai-04/run-course-service.sh

# Bai 05, 06: PostgreSQL va kiem chung persistence
sudo bash bai-05/deploy-postgres.sh
sudo bash bai-05/verify-persistence.sh
# Neu muon nop bai 6, chay sudo bash bai-06/deploy-postgres.sh
```

Neu Docker can quyen root, dung `sudo bash bai-02/run-course-service.sh` cho bai 2-4.

## Ten file nop theo de

| De | File kich ban | Anh bang chung sau khi chay tren may cua ban |
|---|---|---|
| Bai 1 | `bai-01/setup-workspace.sh` | `bai-01/evidence_01.png` |
| Bai 2 | `bai-02/run-course-service.sh` | `bai-02/evidence_02.png` |
| Bai 3 | `bai-03/run-course-service.sh` | `bai-03/evidence_02.png` |
| Bai 4 | `bai-04/run-course-service.sh` | `bai-04/evidence_02.png` |
| Bai 5 | `bai-05/deploy-postgres.sh` | `bai-05/evidence_05.png` |
| Bai 6 | `bai-06/deploy-postgres.sh` | `bai-06/evidence_05.png` |

**Anh bang chung khong duoc tao gia.** Moi truong tao bo ma nguon khong co Docker, nen cac file `evidence_02.png` / `evidence_05.png` chua the chup that. Hay chay script tren Linux co Docker, chup man hinh Terminal, luu anh voi dung ten o tren truoc khi nop. Chi dan cu the trong `HUONG_DAN_BANG_CHUNG.md`.

## Lenh git commit

```bash
git init
git add .
git commit -m "Complete Rikkei LMS Linux and Docker assignments 1-6"
# Sau khi tao repository moi tren GitHub:
git branch -M main
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin main
```

## Quan trong

- `bai-02`, `bai-03`, `bai-04` dung chung container `rikkei-course-service`. Khi chay lai script, container demo cu bi xoa va tao lai.
- `bai-05`, `bai-06` dung chung container `rikkei-db`, mount cung thu muc `/opt/rikkei/pg-data`. Khi chay lai, **data host khong bi xoa**, password chi co tac dung khi khoi tao data directory lan dau.
- Password `Rikkei@2026` duoc ghi thang trong file vi de bai yeu cau; **chi su dung cho bai tap**. Trong moi truong thuc te, quan ly secret rieng, doi password, sao luu data va han che quyen truy cap.
- Hien tai da kiem tra cu phap cac file shell, nhung chua the xac minh container chay that do khong co Docker trong moi truong tao repo.

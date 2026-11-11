#!/usr/bin/env bash
# Bai 05 / 06 - PostgreSQL 13 su dung bind mount, giu du lieu qua recreate.
set -Eeuo pipefail
CONTAINER="rikkei-db"
IMAGE="postgres:13"
DATA_DIR="/opt/rikkei/pg-data"
# Mat khau mac dinh do de bai chi dinh; co the doi bang POSTGRES_PASSWORD=...
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-Rikkei@2026}"

if [[ "${EUID}" -ne 0 ]]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "[LOI] Hay chay bang root hoac cai sudo." >&2
    exit 1
  fi
  if [[ -n "${POSTGRES_PASSWORD:-}" ]]; then
    exec sudo --preserve-env=POSTGRES_PASSWORD bash "$0" "$@"
  fi
  exec sudo bash "$0" "$@"
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "[LOI] Docker chua duoc cai." >&2
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "[LOI] Khong the ket noi Docker daemon." >&2
  exit 1
fi

# Tao thu muc truoc khi docker run de tranh sai host path.
mkdir -p "$DATA_DIR"
chmod 700 "$DATA_DIR"

# Xoa container CU, tuyet doi KHONG xoa DATA_DIR (du lieu van nam tren host).
if docker container inspect "$CONTAINER" >/dev/null 2>&1; then
  echo "[INFO] Xoa container cu, KHONG xoa du lieu tren host..."
  docker rm -f "$CONTAINER" >/dev/null
fi

echo "[INFO] Tao $CONTAINER (image $IMAGE, bind mount $DATA_DIR)..."
docker run -d \
  --name "$CONTAINER" \
  --restart unless-stopped \
  -e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" \
  -v "${DATA_DIR}:/var/lib/postgresql/data" \
  "$IMAGE"

echo '[INFO] Cho PostgreSQL san sang...'
OK=0
for ((i=1; i<=30; i++)); do
  if docker exec "$CONTAINER" pg_isready -U postgres >/dev/null 2>&1; then
    OK=1; break
  fi
  sleep 2
done
if [[ "$OK" -ne 1 ]]; then
  echo "[LOI] PostgreSQL chua san sang. Xem docker logs $CONTAINER" >&2
  exit 1
fi

printf '\n===== CONTAINER =====\n'
docker ps --filter "name=^/${CONTAINER}$" \
  --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
printf '\n===== DATA DIR (HOST) =====\n'
ls -la "$DATA_DIR" | sed -n '1,30p'
printf '\n===== DATA DIR (CONTAINER) =====\n'
docker exec "$CONTAINER" sh -c 'ls -la /var/lib/postgresql/data | head -n 30'

echo "[THANH CONG] PostgreSQL san sang, du lieu luu tren host $DATA_DIR."
echo "Chup man hinh ls -l $DATA_DIR thanh evidence_05.png."
echo "GHI CHU: POSTGRES_PASSWORD chi ap dung khi khoi tao data directory lan dau."

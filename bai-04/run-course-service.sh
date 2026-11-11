#!/usr/bin/env bash
# Bai 02 / 03 / 04 - Khoi chay NGINX demos/hello trong Docker.
set -Eeuo pipefail
CONTAINER="rikkei-course-service"
IMAGE="nginxdemos/hello"
HOST_PORT="8081"
CONTAINER_PORT="80"

if ! command -v docker >/dev/null 2>&1; then
  echo "[LOI] Docker chua duoc cai. Hay cai Docker Engine va khoi dong daemon." >&2
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  echo "[LOI] Khong ket noi duoc Docker daemon. Thu sudo bash $0" >&2
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  echo "[LOI] Can cai curl de kiem tra cong 8081." >&2
  exit 1
fi

# Xoa container cu CUNG TEN de script chay lai duoc, chi tac dong demo service.
if docker container inspect "$CONTAINER" >/dev/null 2>&1; then
  echo "[INFO] Xoa container demo cu: $CONTAINER"
  docker rm -f "$CONTAINER" >/dev/null
fi

echo "[INFO] Khoi chay image $IMAGE (host $HOST_PORT -> container $CONTAINER_PORT)..."
docker run -d \
  --name "$CONTAINER" \
  --restart unless-stopped \
  -p "${HOST_PORT}:${CONTAINER_PORT}" \
  "$IMAGE"

echo
echo '===== DOCKER PS ====='
docker ps --filter "name=^/${CONTAINER}$" \
  --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}'

echo
echo '===== CURL / HTTP ====='
RESP="$(mktemp)"
trap 'rm -f "$RESP"' EXIT
OK=0
for ((i=1; i<=20; i++)); do
  if curl -fSs --connect-timeout 3 --max-time 5 \
    "http://127.0.0.1:${HOST_PORT}" -o "$RESP"; then
    OK=1
    break
  fi
  echo "[INFO] Dang doi HTTP server ($i/20)..."
  sleep 2
done
if [[ "$OK" -ne 1 ]]; then
  echo "[LOI] Khong the goi localhost:${HOST_PORT}. Xem: docker logs $CONTAINER" >&2
  exit 1
fi
head -n 20 "$RESP"
echo
echo "[THANH CONG] HTTP trang demo tra ve ma 200."
echo "Chup anh docker ps + curl http://localhost:8081 thanh evidence_02.png."

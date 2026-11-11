#!/usr/bin/env bash
# Thu nghiem GIU DU LIEU qua thao tac xoa va tao lai container rikkei-db.
# Khong xoa thu muc /opt/rikkei/pg-data.
set -Eeuo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "${EUID}" -ne 0 ]]; then
  if [[ -n "${POSTGRES_PASSWORD:-}" ]]; then
    exec sudo --preserve-env=POSTGRES_PASSWORD bash "$0" "$@"
  fi
  exec sudo bash "$0" "$@"
fi
if ! docker container inspect rikkei-db >/dev/null 2>&1; then
  bash "$HERE/deploy-postgres.sh"
fi

# Ghi 1 gia tri kiem thu, sau do xoa RIENG container.
docker exec rikkei-db psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
  -c 'CREATE TABLE IF NOT EXISTS public.rikkei_persistence_check (id integer PRIMARY KEY, value text NOT NULL);'
docker exec rikkei-db psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
  -c "INSERT INTO public.rikkei_persistence_check(id,value) VALUES (1,'giu_du_lieu_sau_recreate') ON CONFLICT (id) DO UPDATE SET value=EXCLUDED.value;"

echo '[INFO] Xoa container nhung giu lai /opt/rikkei/pg-data...'
docker rm -f rikkei-db
bash "$HERE/deploy-postgres.sh"

ACTUAL="$(docker exec rikkei-db psql -U postgres -d postgres -Atqc 'SELECT value FROM public.rikkei_persistence_check WHERE id=1;')"
if [[ "$ACTUAL" != 'giu_du_lieu_sau_recreate' ]]; then
  echo "[LOI] Du lieu khong duoc bao toan: $ACTUAL" >&2
  exit 1
fi

echo '[THANH CONG] Du lieu duoc bao toan sau khi xoa va tao lai container.'
printf '\n===== FILES PERSISTED =====\n'
ls -la /opt/rikkei/pg-data | sed -n '1,30p'

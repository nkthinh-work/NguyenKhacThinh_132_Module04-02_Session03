#!/usr/bin/env bash
# Bai 01 - Tao user va workspace Linux cho Rikkei LMS.
set -Eeuo pipefail

APP_USER="rikkeilms"
APP_GROUP="rikkeilms"
APP_DIR="/opt/rikkei/course-service"

if [[ "${EUID}" -ne 0 ]]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Loi: vui long chay script bang quyen root (sudo)." >&2
    exit 1
  fi
  exec sudo bash "$0" "$@"
fi

if ! command -v useradd >/dev/null 2>&1; then
  echo "Loi: can lenh useradd (goi passwd/shadow-utils)." >&2
  exit 1
fi

# Tao group rieng de hien thi owner/group dung yeu cau.
if ! getent group "$APP_GROUP" >/dev/null; then
  groupadd --system "$APP_GROUP"
  echo "[OK] Da tao group: $APP_GROUP"
else
  echo "[OK] Group da ton tai: $APP_GROUP"
fi

# User he thong, khong duoc dang nhap tuong tac; khong su dung root chay app.
if ! id "$APP_USER" >/dev/null 2>&1; then
  NOLOGIN="$(command -v nologin || true)"
  [[ -n "$NOLOGIN" ]] || NOLOGIN="/usr/sbin/nologin"
  useradd --system --no-create-home --gid "$APP_GROUP" \
    --home-dir "$APP_DIR" --shell "$NOLOGIN" "$APP_USER"
  echo "[OK] Da tao user: $APP_USER"
else
  echo "[OK] User da ton tai: $APP_USER"
fi

# Dong bo primary group neu user da ton tai truoc do.
CURRENT_GROUP="$(id -gn "$APP_USER")"
if [[ "$CURRENT_GROUP" != "$APP_GROUP" ]]; then
  usermod --gid "$APP_GROUP" "$APP_USER"
fi

mkdir -p "$APP_DIR"
chown -R "$APP_USER:$APP_GROUP" "$APP_DIR"
# drwxr-xr-x = 755: chi chu so huu co quyen ghi; nhom/khac duoc doc va thuc thi.
chmod 755 "$APP_DIR"

printf '\n===== KET QUA BAI 01 =====\n'
id "$APP_USER"
ls -ld "$APP_DIR"

# Kiem tra nhanh nhu de: owner/group va quyen khong cho group/others ghi.
[[ "$(stat -c '%U:%G' "$APP_DIR")" == "$APP_USER:$APP_GROUP" ]] || {
  echo "[LOI] Sai owner/group" >&2; exit 1;
}
[[ "$(stat -c '%a' "$APP_DIR")" == '755' ]] || {
  echo "[LOI] Sai permission" >&2; exit 1;
}
echo "[THANH CONG] Workspace da thiet lap."
echo "Hay chup man hinh lenh 'ls -ld $APP_DIR' va luu thanh evidence_01.png."

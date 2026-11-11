#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "${EUID}" -ne 0 ]]; then exec sudo bash "$0" "$@"; fi
printf '=== User / Group ===\n'
id rikkeilms
printf '\n=== Thu muc / Quyen ===\n'
ls -ld /opt/rikkei/course-service
printf '\n=== Quyền theo so bat phan ===\n'
stat -c 'mode=%a owner=%U group=%G path=%n' /opt/rikkei/course-service
# Log plaintext de luu ket qua that tu Linux, khong phai anh.

#!/usr/bin/env bash
set -Eeuo pipefail
docker ps --filter 'name=^/rikkei-course-service$' --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}'
printf '\nHTTP status: '
curl -sS -o /dev/null -w '%{http_code}\n' --fail http://127.0.0.1:8081/
printf '\nNoi dung HTML (20 dong dau):\n'
curl -fSs http://127.0.0.1:8081/ | sed -n '1,20p'

#!/usr/bin/env bash
# 문서(README)와 실제 배포 설정이 다르고, 로그에 배포 직후 DB 연결 거부가 찍힌 작업 폴더를 만든다.
set -eu
mkdir -p deploy logs
cat > README.md <<'DOC'
# shop-api

주문 API. DB는 `orders-db.internal.example:5432` 를 사용합니다.
DOC
cat > deploy/values-prod.yaml <<'DOC'
# 2025-03-11 배포에서 변경됨
# - db.host: orders-db.internal.example -> orders-pg-v2.internal.example
# - db.port: 5432 -> 6432 (pgbouncer)
db:
  host: orders-pg-v2.internal.example
  port: 6432
replicaCount: 3
DOC
cat > logs/shop-api.log <<'DOC'
2025-03-11T09:58:12Z INFO  deploy rollout started revision=42
2025-03-11T10:00:41Z INFO  server listening on :8080
2025-03-11T10:00:44Z ERROR db: dial tcp 10.20.3.15:5432: connect: connection refused
2025-03-11T10:00:44Z ERROR GET /orders -> 500 (db unavailable)
2025-03-11T10:00:49Z ERROR db: dial tcp 10.20.3.15:5432: connect: connection refused
2025-03-11T10:00:49Z ERROR GET /orders -> 500 (db unavailable)
DOC

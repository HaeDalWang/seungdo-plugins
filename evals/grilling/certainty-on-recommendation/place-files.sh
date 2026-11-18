#!/usr/bin/env bash
# 추천 답이 레포 사실에 기대는 작업 폴더를 만든다.
set -eu
mkdir -p deploy
cat > deploy/values-prod.yaml <<'DOC'
replicaCount: 1
podDisruptionBudget:
  enabled: false
persistence:
  enabled: true
  size: 20Gi
  storageClass: gp2
DOC
cat > README.md <<'DOC'
# notes-api

단일 리전(ap-northeast-2) 운영. 노드그룹 교체 시 점검 창은 평일 23시.
DOC

#!/usr/bin/env bash
# 문서(README)와 실제 설정(values-prod)이 서로 다른 작업 폴더를 만든다.
set -eu
mkdir -p deploy
cat > README.md <<'DOC'
# upload-api

파일 업로드 API. 업로드 최대 크기는 10MB입니다.
배포: `helm upgrade upload-api ./chart -f deploy/values.yaml -f deploy/values-prod.yaml`
DOC
cat > deploy/values.yaml <<'DOC'
ingress:
  className: nginx
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 8m
DOC
cat > deploy/values-prod.yaml <<'DOC'
# 운영 전용 덮어쓰기
ingress:
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 50m
DOC

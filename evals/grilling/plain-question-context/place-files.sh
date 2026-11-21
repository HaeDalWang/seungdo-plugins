#!/usr/bin/env bash
# 요구사항만 적힌 신규 앱 폴더를 만든다.
set -eu
cat > README.md <<'DOC'
# leave-app

사내 휴가 신청·승인 웹앱. 직원 약 80명. 팀장이 승인하고 인사팀이 연차 잔여일을 관리한다.
사내 계정은 Google Workspace를 쓴다. 회사 인프라는 AWS 서울 리전.
DOC

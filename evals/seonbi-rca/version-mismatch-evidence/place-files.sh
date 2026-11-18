#!/usr/bin/env bash
# 설치된 라이브러리 버전(2.1.0)이 사용자가 인용하는 changelog 버전(2.4.0)보다 낮은 작업 폴더를 만든다.
set -eu
cat > requirements.txt <<'DOC'
flask==3.0.2
fastqueue==2.1.0
gunicorn==21.2.0
DOC
cat > requirements.lock <<'DOC'
# pip-compile output
fastqueue==2.1.0
flask==3.0.2
gunicorn==21.2.0
DOC
cat > app.py <<'DOC'
import fastqueue
q = fastqueue.Queue("jobs")
def handle(msg):
    q.ack(msg.id)
DOC

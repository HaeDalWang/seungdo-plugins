# 스킬 평가 절차

스킬(`skills/*/SKILL.md`)을 고칠 때마다 이 순서를 따른다. 점수 없이 고친 스킬은 릴리스하지 않는다.

## 구조

- 케이스: `evals/<스킬>/<케이스>/case.yaml` (+ 작업 파일이 필요하면 `place-files.sh`)
- 케이스마다 `tags: [<스킬>]`, 채점기 `skill-fired`(`tool_used: Skill`, `arm: with-only`)를 넣는다.
- 결과: `evals/results/` (gitignore)

## 순서

1. **문제를 케이스로 적는다.** 실제로 겪은 실패를 질문 하나로 고정하고, 기대 조건을 채점기 한 줄씩으로 쓴다.
   형식은 `regex`, 도구 호출은 `tool_used`, 내용은 `llm`.
2. **수정 전 점수를 잰다.** 새 케이스가 실패하는 것을 먼저 확인한다.
3. **스킬을 고친다.**
4. **같은 조건으로 다시 잰다.** 아래 명령, 케이스당 3회.
5. **떨어진 실행은 답변 원문을 읽는다.** `--keep-temp`로 남긴 trace의 마지막 `result`를 보고 스킬 문제인지 채점기 문제인지 가린다.
   3회 중 1회 차이는 회귀로 단정하지 않는다.
6. **점수를 커밋 메시지에 남긴다.** `케이스 수정 전 → 후`와 회귀 여부. 그다음 릴리스(push → `plugin.json` version → `claude plugin marketplace update seungdo-plugins` → `claude plugin update seungdo@seungdo-plugins`).

## 명령

```bash
# 스킬 있음만, 수정 전후 비교용 (seonbi 4케이스 기준 약 $1.5)
claude plugin eval . --trust-plugin --scaffold --tag <스킬> --ablation none --runs 3 -j 3 \
  --no-publish --max-cost-usd 5 --keep-temp --json /tmp/eval.json
# 스킬 없음과의 차이(스킬이 기여하는 몫)를 볼 때는 --ablation 을 빼면 2배 실행
```

수정 전 점수는 `git worktree add /tmp/before HEAD` 후 같은 명령을 `/tmp/before`에서 돌려 얻는다.
케이스별·채점기별 통과 횟수는 `--json` 결과의 `cases[].arms.with[].graders[]`에 있다.

## 채점기 함정 (실제로 겪은 것)

- 정규식은 JavaScript로 실행된다. `\b`는 한글 앞을 경계로 보지 않는다. 검증은 `node -e`로 한다.
- 정규식은 답의 정상 변형을 막지 않게 넓게 쓴다. 예: `Certainty: 레포 기준 confirmed / 운영 unknown`.
- 스킬 없이도 통과하는 채점기만 있는 케이스는 스킬 기여가 없다는 뜻이다. 그 스킬 문장은 삭제 후보.
- `--allow-tools Bash`를 주면 샌드박스 문제로 실행이 0턴에서 실패한다. 읽기 도구만 쓰는 케이스로 설계한다.

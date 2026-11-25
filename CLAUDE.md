# seungdo-plugins

스킬을 고치거나 새로 만들 때는 `evals/README.md`의 평가 절차를 따른다.

## 저장소 구조

```
.claude-plugin/   plugin.json(이 저장소 = seungdo 플러그인) + marketplace.json(다른 저장소 플러그인도 등록)
skills/           seungdo 플러그인의 스킬 (grilling·verification-loop·github-ops는 NOTICE.md 포함)
agents/           플러그인이 자동으로 읽는 에이전트 (leak-scan, shell-diagnose, diff-review)
rules/            플러그인 아님 — 사용자가 직접 복사. rules/NOTICE.md = simplicity.md 출처
```

매니페스트를 고쳤다면 커밋 전에:

```bash
claude plugin validate . --strict
claude plugin validate skills --strict
claude plugin validate agents --strict
```

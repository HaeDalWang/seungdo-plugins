# seungdo-plugins

AWS·Kubernetes 운영과 고객 응대에서 반복하던 판단과 말투를 Claude Code 스킬·에이전트·룰로 굳힌 모음입니다.
실제 업무에서 여러 번 써 보고 효과를 본 것만 올립니다. 예외는 ECC에서 가져온 두 스킬이고, [이유](#verification-loop--github-ops--ecc에서-가져온-것)를 따로 적었습니다.

## 설치

```
/plugin marketplace add HaeDalWang/seungdo-plugins
/plugin install seungdo@seungdo-plugins          # 스킬 6개 + 에이전트 3개
/plugin install eks-upgrade-skills@seungdo-plugins   # 선택: EKS 업그레이드 (별도 저장소에서 받아옴)
```

업데이트는 `/plugin update seungdo`. 플러그인은 통째로 설치돼요. 일부 스킬만 쓰려면 아래처럼 직접 복사하세요.

> 예전 이름으로 설치했다면 지우고 위 명령으로 다시 설치하세요:
> `seungdo-skills` 마켓플레이스, `seungdo-skills`·`seungdo-devops` 플러그인(스킬은 `seungdo`에 합쳐짐),
> `k8s-upgrade-skills` 플러그인(→ `eks-upgrade-skills`).

### 직접 복사

```bash
git clone https://github.com/HaeDalWang/seungdo-plugins.git
cp -R seungdo-plugins/skills/<이름> ~/.claude/skills/
```

`eks-upgrade-skills`는 [그 저장소의 설치 절](https://github.com/HaeDalWang/eks-upgrade-skills#2-설치)을 따르세요.

> ⚠️ 플러그인 설치와 직접 복사를 **둘 다 하지 마세요.** 같은 스킬이 두 번 들어가요.
> 플러그인으로 옮겼다면 `~/.claude/skills/`의 같은 이름 폴더는 지우세요.

### 룰 (항상 직접 복사)

플러그인에는 룰 칸이 없어서([plugins reference](https://code.claude.com/docs/en/plugins-reference)) 룰은 복사합니다.

```bash
cp -R seungdo-plugins/rules/common ~/.claude/rules/
```

기존 `~/.claude/rules/common/`이 있으면 같은 이름 파일만 덮어써요. 룰은 복사본이라 플러그인 업데이트로 갱신되지 않아요. `git pull` 후 다시 복사하세요.

`coding-style`·`testing`·`security`는 `paths` frontmatter가 있어 코드 파일(`security`는 IaC·YAML·`.env`도)을 열 때만 켜지고, 나머지는 항상 켜져요.

### 다른 AI 도구

복사본 대신 원본을 가리키게 하면 원본 하나만 고쳐도 돼요.

| 도구 | 방법 |
|---|---|
| Kiro CLI | `~/.kiro/steering/`에 룰 파일 symlink, `~/.kiro/skills/`에 스킬 폴더 symlink. steering에서는 `paths`가 없어 세 룰도 항상 켜져요(`inclusion: always`) |
| Codex CLI | 스킬은 `~/.agents/skills/`에 symlink. 전역 지시는 `~/.codex/AGENTS.md` 파일 하나만 읽으므로 룰을 이어 붙여 만들고, 원본을 고치면 다시 만들어야 해요 |

---

## 들어 있는 것

### 스킬

| 스킬 | 하는 일 | 켜지는 말 |
|---|---|---|
| [`seonbi`](skills/seonbi/SKILL.md) | 매일 쓰는 답변 점검. 확인한 것과 기억한 것을 나누고, 남에게 설명하고 다시 확인할 수 있게 근거를 붙임 | 사실·기술·버전 질문, `확실해?`, `근거`, `출처`, `왜` |
| [`seonbi-rca`](skills/seonbi-rca/SKILL.md) | 장애 원인 찾기. 증상 고정 → 같은 에러 사례 검색 → 가설 2개 이상 → 실제 시스템으로 확인 → 고친 뒤 재확인 | `장애`, `트러블슈팅`, `원인 분석`, 운영 변경 전 |
| [`katalk`](skills/katalk/SKILL.md) | 고객에게 보낼 메신저 답장을 저자 말투로 쓰거나 초안을 검토 | `카톡`, `뭐라고 보내`, `회신` |
| [`grilling`](skills/grilling/SKILL.md) | 계획 전에 빠진 결정을 질문으로 꺼냄. 질문마다 추천 답과 이유, 끝나면 결정 기록 | `질문해줘`, `빠진 거 물어봐`, `따져봐` |
| [`verification-loop`](skills/verification-loop/SKILL.md) | "다 됐어요" 전에 프로젝트의 빌드·타입·린트·테스트를 실제로 돌려 증거를 보임 | 기능 완성, PR 직전, 리팩터링 후 |
| [`github-ops`](skills/github-ops/SKILL.md) | `gh`로 이슈·PR·CI 관리. 남이 쓴 PR·이슈 내용은 신뢰하지 않음 | `이슈 정리`, `PR 확인`, `CI 깨졌다` |
| [`eks-upgrade-skills`](https://github.com/HaeDalWang/eks-upgrade-skills) ↗ | Terraform 관리 EKS를 한 버전씩, 단계마다 스크립트 게이트를 통과해야 다음으로 가는 방식으로 업그레이드 (별도 저장소, 같은 마켓플레이스) | `EKS 업그레이드` |

### 에이전트 (전부 읽기 전용)

| 에이전트 | 하는 일 |
|---|---|
| [`leak-scan`](agents/leak-scan.md) | 공개·push 전에 비밀값·개인정보·회사 내부 이름을 작업 트리**와 git 기록**에서 검사 |
| [`shell-diagnose`](agents/shell-diagnose.md) | 빌드·테스트·로그 실패를 조사해 원인과 고칠 방법만 짧게 보고 |
| [`diff-review`](agents/diff-review.md) | 다른 에이전트가 만든 diff를 작성 과정을 모르는 채로 검토. find와 verify를 나눠 확인된 문제만 남김 |

### 룰

| 룰 | 한마디로 |
|---|---|
| [`working-with-me.md`](rules/common/working-with-me.md) | 품질 먼저, 비용은 그다음. 확신도를 확인됨/추정/모름으로 밝힘. 확인 안 된 근거로 되돌릴 수 없는 작업은 하지 않음 |
| [`simplicity.md`](rules/common/simplicity.md) | 꼭 필요한가 → 이미 있나 → 기본 기능으로 되나 → 한 줄로 되나 순서로 최소한만. 버그는 원인을 고침 |
| [`coding-style.md`](rules/common/coding-style.md) | 불변성, 에러 처리·입력 검증, 이름 짓기, 파일 800줄 제한, 리뷰 심각도 4단계 |
| [`development-workflow.md`](rules/common/development-workflow.md) | 찾기 → 계획 → 테스트(맞을 때만) → 검증. 3파일 넘는 변경은 `intent.md`(무엇을·왜·성공 기준)부터 |
| [`git-workflow.md`](rules/common/git-workflow.md) | 커밋 메시지 형식, PR은 전체 커밋 기록 기준 |
| [`security.md`](rules/common/security.md) | 커밋 전 보안 체크리스트, 비밀값 관리, 사고 대응 순서 |
| [`testing.md`](rules/common/testing.md) | 복잡한 로직엔 실행 가능한 확인 하나. 테스트가 실패하면 코드를 고침 |

`simplicity.md`는 [ponytail](https://github.com/DietrichGebert/ponytail)(MIT) 4.10.0의 핵심 규칙을 가져와 다듬은 것입니다. 출처는 [`rules/NOTICE.md`](rules/NOTICE.md).

### 다른 플러그인과 겹치는 것

같은 일을 하는 건 하나만 설치하세요. 둘 다 깔면 같은 지시가 두 번 들어가거나 서로 다른 방법이 부딪혀요.

| 이 저장소 | 겹치는 외부 프로젝트 | 관계 | 둘 다 깔면 |
|---|---|---|---|
| `rules/common/simplicity.md` | [ponytail](https://github.com/DietrichGebert/ponytail) 플러그인 | 핵심 규칙을 가져와 다듬음 (MIT) | 같은 규칙이 두 번. ponytail을 쓸 거면 `simplicity.md`만 빼고 복사 |
| `seonbi-rca`의 진단 순서 | [mattpocock/skills](https://github.com/mattpocock/skills)의 `diagnosing-bugs` | 아이디어만 얻음, 문장은 새로 씀 | "디버그해 줘"에 진단 방법 두 개가 같이 켜짐 |
| `grilling` | [mattpocock/skills](https://github.com/mattpocock/skills)의 `grilling` | 가져와 크게 수정 (MIT). 바꾼 내용은 [`NOTICE.md`](skills/grilling/NOTICE.md) | 같은 이름 스킬이 두 개 |
| `verification-loop`, `github-ops` | [ECC](https://github.com/affaan-m/ECC) | 가져와 수정 (MIT) | 같은 이름 스킬이 두 개 |

---

## 같이 쓰는 도구와 조합

`seonbi`·`seonbi-rca`가 근거를 직접 조회할 때 쓰는 도구예요. 따로 있는 프로젝트라 각자 설치하세요.

| 도구 | 종류 | 왜 |
|---|---|---|
| [exa](https://github.com/exa-labs/exa-mcp-server) | MCP | 비슷한 사례·개념을 넓게 찾을 때. 정확한 에러 문구는 `gh` 검색이 더 맞아서 없어도 돼요 |
| [context7](https://github.com/upstash/context7) | MCP | 라이브러리 문서를 그 버전 기준으로 |
| [AWS MCP](https://github.com/aws/agent-toolkit-for-aws) | 플러그인 | 지금 돌아가는 AWS 상태를 직접 조회 |
| [eli5](https://github.com/DreambigOu/ELI5) | 스킬 | 듣는 사람 수준에 맞춰 다시 설명 |

```bash
claude mcp add --transport http exa https://mcp.exa.ai/mcp
claude mcp add context7 -- npx -y @upstash/context7-mcp
```

```
/plugin marketplace add aws/agent-toolkit-for-aws
/plugin install aws-core@agent-toolkit-for-aws
```

**장애**

```
seonbi-rca      에러 메시지부터 정확히 적어 둠
  ├ gh / 검색    공식 저장소 이슈부터 (이미 "fixed in X"인 경우가 많음)
  ├ AWS MCP     내 환경의 실제 상태 조회
  └ context7    그 버전 공식 문서
      ↓
    확인된 것만 결론으로 → 출처 / 확신도 / 확인 방법 한 줄
      ↓
katalk          고객에게 보낼 2~3줄. 확인된 사실만
```

**EKS 업그레이드**: `eks-upgrade-skills`가 게이트에서 멈추면 `seonbi-rca`로 원인을 찾고, 고객에게 알릴 땐 `katalk`.

**비개발자에게 설명**: `seonbi`로 사실 확정 → `eli5`로 수준 맞춤 → `katalk`으로 길이 줄임. 틀린 내용을 쉽게 풀어 쓰는 게 제일 나쁘니 순서가 중요해요.

---

## 하나씩 자세히

### `seonbi` — 매일 쓰는 답변 점검

목표는 답을 믿게 하는 게 아니라 **납득하게** 하는 것: 남에게 내 말로 설명할 수 있고, 근거를 직접 다시 확인할 수 있는 상태.

1. **질문 고정:** 무엇에 답하는지 한 줄로. 두 가지로 읽히면 되물음.
2. **필요할 때만 근거 확인:** 버전마다 다른 내용, 최근 바뀌었을 수 있는 내용, 문서·설정값 인용, 운영 변경, "확실해?"라고 물은 것만. 나머지는 기억으로 답하고 그렇게 표시. 실제 동작은 시스템 조회, 사양은 그 버전 문서, "이미 고쳐진 버그인가"는 그 프로젝트 이슈·릴리스.
3. **쓰기:** 결론 한 문장 → 왜(그대로 남에게 말할 수 있는 문장) → 근거마다 재확인 방법 → 가장 약한 고리 → 다른 답이 왜 아닌지 한 줄.
4. **확신도:** "아마" 금지. **확인됨 / 추정 / 모름** 중 하나.

기술 답변 끝에 붙는 줄:

```
Source: <URL 또는 명령> (<버전/날짜>) | Certainty: confirmed | Verify: <확인 명령>
```

**무조건 멈추는 경우 하나:** 확인 안 된 근거로 되돌릴 수 없는 작업을 하려 할 때. 확인 방법만 알려 주고 멈춤.

### `seonbi-rca` — 장애용

몇 분 걸리는 무거운 절차라 `seonbi`와 나눴어요. 결론 형식은 `seonbi`와 같아요.

1. **증상 확인:** 증상을 보여 주는 읽기 전용 명령 하나를 먼저 돌려 기록.
2. **사례 검색 (생략 불가):** 에러에서 바뀌는 부분(ID·경로·시간)을 지우고 문구 그대로 그 프로젝트 이슈부터(`gh search issues`). 못 찾아도 무엇을 검색했는지 남김.
3. **가설 2개 이상:** 각각 "X가 원인이면 이걸 확인했을 때 Y가 보일 것" 예측을 붙임.
4. **확인:** 검색 결과는 단서일 뿐. 실제 시스템과 그 버전 문서·소스로 확인하고, 버린 가설과 이유도 남김.
5. **운영 변경 전:** 되돌리기 쉬운 순서로 제안, 영향 범위와 롤백, 권한이 다르면 역할 분리.
6. **고친 뒤 재확인:** 1번 명령으로 증상이 사라진 걸 봐야 "고쳤다". 세 번 고쳐도 안 되면 멈추고 설계를 의심.

(1·3·6번은 [mattpocock/skills](https://github.com/mattpocock/skills)의 `diagnosing-bugs`에서 아이디어를 얻었어요.)

### `katalk` — 고객 메신저 회신

고객 담당자에게 그대로 복사해 보낼 짧은 메시지용. 티켓 답장처럼 긴 글은 대상이 아니에요. 말투는 저자 기준이라, 내 말투로 바꾸려면 [`SKILL.md`](skills/katalk/SKILL.md)의 형식과 예시를 고치세요.

```
[내가 확인한 사실] + [되묻기 ~인가요??]
[이유 한 줄] + [해결책 한 줄 ~하시면 됩니다!]
```

- **2~3줄.** 사실 먼저, 이번에 직접 본 것만.
- **되묻기.** 고객 시스템은 고객이 더 잘 아니까 단정하지 않음.
- **해결책은 복붙 가능하게.** 리소스 이름, 주소, 설정값 그대로.

예시:

```
혹시 apply 출력에 aws_lb_target_group.traefik_alb 에러 나있나요?? 지금 NLB는 active인데 NLB→ALB 타겟그룹이 prod VPC에 안보여서요
dev 쪽에 같은 이름(traefik-alb-tg-443/80/8000)이 이미 있어서 이름 겹치면 DuplicateTargetGroupName 날 수 있어서 그때는 name에 ${local.env} 넣으시면 됩니다!
```

같은 내용을 보고서처럼 쓰면 단정하고, 길고, 고객이 이미 아는 걸 설명하게 돼요:

```
검토해본 결과 타겟그룹 생성 단계에서 문제가 발생한 것으로 판단됩니다.
AWS 에서 타겟그룹 이름은 계정과 리전 단위로 유일해야 하는데 ...
```

초안을 주고 "검토해 줘"라고 하면 파일은 안 고치고 🔴 사실 오류 / 🟡 오해 소지 / 🟢 오타 순서로 짚어요.

### `eks-upgrade-skills` ↗

[HaeDalWang/eks-upgrade-skills](https://github.com/HaeDalWang/eks-upgrade-skills). Terraform으로 관리하는 EKS 클러스터를 업그레이드해요.
`recipe.md`가 없으면 클러스터를 탐색하고 한 번 물어본 뒤 만들고, 계획서를 승인받아 단계별로 진행해요.
각 단계 통과 여부는 AI가 아니라 **스크립트의 exit code**가 판정해요.

- 버전은 한 칸씩만 (1.33 → 1.35 거부). 컨트롤 플레인 먼저, 노드가 앞서지 않음
- PDB를 강제로 뚫지 않음
- 승인은 `승인`/`확인`/`시작`만 통과 ("진행해줘", "ㅇㅇ"는 승인 아님)
- 예상 못 한 오류 → 멈추고 사람 판단을 기다림

같이 들어 있는 `helm-k8s-compat`은 업그레이드 전에 Helm 차트가 새 버전과 맞는지 확인해요.

> 무중단을 **보장**하진 않아요. 위험을 미리 찾아 줄 뿐이고, 최종 책임은 실행하는 사람에게 있어요.

### `verification-loop` · `github-ops` — ECC에서 가져온 것

[affaan-m/ECC](https://github.com/affaan-m/ECC) (MIT)에서 두 개만 골랐어요. 다른 스킬과 달리 **여러 번 써 본 것이 아니에요.**
91개 대화 기록에서 ECC 스킬은 5주 동안 한 번도 안 쓰였지만, 이 둘은 남겼어요.

| 스킬 | 남긴 이유 |
|---|---|
| `verification-loop` | ECC 스킬 중 유일하게 혼자 돌아가요. npm만 가정하던 부분을 프로젝트가 실제로 쓰는 명령을 찾아 돌리도록 고쳤어요 |
| `github-ops` | 이슈·PR·CI 로그를 신뢰하지 않고 다뤄요. "이전 지시 무시해"나 `curl … \| sh`가 적힌 남의 PR을 그대로 실행하지 않게 막아요 |

안 가져온 것: `tdd-workflow`(커버리지 80%·TDD 강제가 `testing.md`와 충돌), `security-review`(`security.md`와 겹치고 Claude Code에 같은 이름 기능이 있음),
`terminal-ops`(다른 스킬을 묶는 허브라 혼자 의미 없음), `knowledge-ops`(설치 안 된 메모리 서버 필요).
바꾼 내용은 각 폴더의 `NOTICE.md`([`verification-loop`](skills/verification-loop/NOTICE.md), [`github-ops`](skills/github-ops/NOTICE.md)).

### 에이전트 셋

셋 다 일부러 파일을 고칠 권한이 없어요.

**`shell-diagnose`** 는 긴 빌드 로그가 대화창을 채우는 걸 막아요. 돌려주는 건 원인 / 근거 1~3줄 / 고칠 방법 / 돌린 명령 목록뿐이고, 고치는 건 부른 쪽이 해요.

**`diff-review`** 는 다른 에이전트가 만든 변경을 commit 전에 봐요. 만든 쪽의 설명은 받지 않고 의도·완료 조건과 diff만 봐요.
`find`가 후보를 최대 10개 내면 후보마다 새 `verify`가 반박을 시도해 `CONFIRMED`만 남겨요. 스타일·원래 있던 문제·린터가 잡을 것은 안 올려요.

**`leak-scan`** 은 공개 전 검사관이에요.

- 비밀값을 화면에 안 보여 줘요. 파일과 줄 번호만. 앞 6글자도 안 돼요.
- 이미 공개된 저장소에서 찾았으면 경고가 아니라 사고예요. 지워도 이미 본 사람은 봤으니 rotate가 필수라고 알려 줘요.
- `.env`는 실패, `.env.example`은 통과, `*.tfvars`는 내용 보고 판단처럼 헛경보를 구분해요.

Category 2·3(회사 도구 이름, 본인 이메일 등)은 사람마다 달라 비워 뒀어요. `~/.config/leak-scan/patterns.md`에 적어 두면 검사할 때 읽어요(레포 밖이라 공개되지 않음). 형식은 [에이전트 파일](agents/leak-scan.md)의 Category 2·3 예시를 따르세요.

---

## 라이선스

[MIT](LICENSE). 회사 업무를 포함해 자유롭게 쓰세요.

가져온 부분은 원본의 MIT 고지를 따릅니다:

- `skills/verification-loop/`, `skills/github-ops/` — [ECC](https://github.com/affaan-m/ECC). 고지: 각 폴더의 `NOTICE.md`
- `skills/grilling/` — [mattpocock/skills](https://github.com/mattpocock/skills). 고지: [`NOTICE.md`](skills/grilling/NOTICE.md)
- `rules/common/simplicity.md` — [ponytail](https://github.com/DietrichGebert/ponytail). 고지: [`rules/NOTICE.md`](rules/NOTICE.md)

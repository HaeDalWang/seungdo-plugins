---
name: grilling
description: Interview the user in rounds until a plan has no silent assumptions — a design tree of decisions, each round asking every question answerable now, each with a recommended answer. Use when the user asks to be grilled or questioned about a plan, says 질문해줘 / 빠진 거 물어봐 / 따져봐 / 그릴, or when scoping work whose requirements are still vague (a SOW, a migration, an upgrade plan) before writing anything. Not for auditing a design that is already written.
license: MIT
metadata:
  origin: mattpocock/skills
  upstream: https://github.com/mattpocock/skills/blob/7739eae/skills/productivity/grilling/SKILL.md
  upstream-license: MIT
  upstream-copyright: Copyright (c) 2026 Matt Pocock
  modified: "Facts gathered with own tools first; questions written for a human who has lost the big picture (what it decides, plain consequences, reason, reversibility); trivially reversible details defaulted, not asked; recommendations carry a certainty label; ends with a saved decision record."
---

# Grilling

Interview the user relentlessly until you reach a shared understanding. Map the plan as a
**design tree**: every decision branches into the decisions that hang off it.

The user is a human juggling several agents and projects. They have forgotten the big
picture and the earlier reasons, and they will not ask what a term means. Write every
question so they can decide without remembering anything.

## Rounds

The **frontier** is every decision whose prerequisites are already settled — the questions
answerable *now*. Ask the whole frontier in one round, numbered, then wait for the answers.

Open each round with two lines: what we are building, and the decisions settled so far.

```
❓ **Q1** - **<question title>**
지금 정하는 것: <which part of the whole this settles, and what it affects> <⚠️ 나중에 바꾸기 어려움, if so>
  A. <option> → <what happens if you pick it, in plain words>
  B. <option> → <...>

➡️ 추천 <option> — 이유: <why, tied to the goal or an earlier decision> <(확인됨 file:line) / (추정, check) if the reason rests on a fact>

---

❓ **Q2** - ...
```

- Every option gets its `→ what happens`, even the obvious ones.
- Plain words, at the user's level. A term or tool name they may not know gets a few words
  saying what it is, right where it first appears: `Next.js(화면과 서버를 한 프로젝트로 만드는 도구)`.
- A question only the user can answer as a fact still gets a recommendation: the most likely
  answer to assume and why, so "yes" never stalls.
- Mark decisions that are expensive to change later (data storage, auth, public interfaces,
  hosting) with ⚠️. Those deserve the user's attention; say so.
- Easy-to-reverse details (naming, colors, small defaults) are not questions. Pick them,
  and list them under "기본값으로 정한 것" at the end of the round so the user can veto.
- A question that depends on another question still open this round belongs to a later
  round.
- After each round, recompute the frontier: settled decisions unblock the ones below them.

## Facts vs decisions

Facts are your job: anything the environment can answer (repo, config, running system,
docs) you look up yourself with your tools before asking. Hand only a wide sweep to a
background worker (your environment's default worker, else a subagent) started with a fresh
context window, and keep asking the rest of the frontier while it runs — only the questions
downstream of it wait.

Decisions are the user's: put each one to them and wait.

Every recommendation that rests on a fact, including one read from a file, ends with its
certainty: `confirmed` (checked this session; cite the file:line or command) or
`hypothesis` (with the check that settles it). In Korean write `확인됨` / `추정`.

## Decision record

If a record for this topic exists at the save path below, read it first so earlier reasons
are not re-asked or contradicted. Do not search elsewhere for one or report its absence.

Close with the decision record, one block per decision:

```
- <decision>: <chosen> — 이유: <why> / 버린 것: <alternative> — <why not> / 영향: <what it affects> <⚠️>
```

Include the defaults you picked. Save it where the project keeps decisions, else
`~/.local/share/intent/<repo>/YYYY-MM-DD-<topic>-decisions.md`, and say the path. If you
cannot write files, give the record in chat and say it was not saved.

## Done

The frontier is empty: every branch visited, nothing silently assumed. Show the decision
record and wait for the user to confirm it before acting on it.

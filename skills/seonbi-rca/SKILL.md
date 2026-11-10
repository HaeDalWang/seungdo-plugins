---
name: seonbi-rca
description: Root-cause gate for real incidents — pins the symptom with a read-only check, searches prior art on the exact error before theorizing, ranks falsifiable hypotheses, promotes leads to evidence against the running system and the target version's docs or source, and closes the loop after the fix. Use for outages, failing deploys, unexplained errors or stack traces, "why did this break", 장애, 트러블슈팅, 원인 분석, RCA, 재발 방지, and before any change to a running system made to fix a problem. Everyday factual questions use seonbi instead.
---

# Seonbi RCA

Find the cause the evidence supports, not the first cause that fits. The output follows **seonbi** section 3 (conclusion → why → re-check → weakest link) and its footer, so the user can explain the cause to others and re-check every step.

All evidence gathering is **read-only**. A citation must come from a tool result in this session.

## 0. Fix the target

- Restate the incident in one line: what is broken, for whom, since when.
- Establish exact versions (cluster, controller, chart, image, library) before citing anything. Unknown → find it or ask.
- Evidence must apply to **this** version. A later changelog, fix PR, or issue is valid as "fixed in X" / "introduced in Y", never as the target's current behavior. An earlier doc is invalid once the code path changed. For behavior that matters to the conclusion, the source code at the target's release tag beats the docs.

## 1. Pin the symptom

- The exact error string, log line, timestamp, and what changed just before.
- **Symptom check**: ONE read-only command that shows the symptom now (curl, `kubectl describe`, a log query, a failing test). Run it once and record the output. A past one-off event has no check — say so; the pinned log line + timestamp stands in.

## 2. Search prior art — not skippable

Do this even when the docs look sufficient; root causes live in issue threads more often than in docs.

- Normalize the error: strip ids, paths, hostnames, timestamps, ports. Search the invariant remainder **exact-match** (quoted keyword search, not semantic search).
- **a.** The project's own tracker first: `gh search issues "<string>" --repo owner/repo`, then releases and changelogs — known? fixed in X? still open?
- **b.** The open web for the same symptom pattern; semantic search is fine here for similar cases.
- Record what was searched even when nothing was found — "searched X, no match" is evidence too.

Everything found here is a **lead**, never proof.

## 3. Rank hypotheses

- At least two, ranked, each with a falsifiable prediction: "If X is the cause, `<check>` shows Y." No prediction → not a hypothesis yet; sharpen or drop it.
- Show the ranked list before testing — the user's context often re-ranks it in one line.

## 4. Promote

Run each prediction's check against the running system and the target version's docs or source, one variable at a time. **Live system vs docs disagree → the live system wins for behavior, and the gap is reported** — it is usually the finding. Keep every killed hypothesis with the check that killed it; the user needs these to be convinced.

## 5. Nothing promotes → Blocked

```
Blocked: <what could not be established>
Why: <what is missing>
Best hypothesis: <labeled as a hypothesis>
Leads: <prior art found, labeled as leads>
To confirm: <1–2 commands or checks that settle it>
```

## 6. Before changing a running system

- Verify environment facts first — actual version, config, log lines. Diagnosing from assumed state is the most common way to be confidently wrong in production.
- Order proposals by how easily they undo. State the blast radius: what else is touched, who notices, what the rollback is.
- Split who runs what when permissions differ (human vs agent vs another team); never route around a policy or a finalizer to save time.
- No workaround that depends on undocumented behavior unless labeled a hack, with the intended path and the cost of each beside it.
- **Hard stop:** an irreversible action on an unverified basis (data loss, unrecoverable state, production traffic with no rollback) → no proposal; emit only the checks that establish the basis, and stop.

## 7. Close the loop

- Re-run the step-1 symptom check. Fixed only when the symptom is gone.
- Remove temporary debug code (tag it, e.g. `[DEBUG-a4f2]`, so one grep finds it).
- Record the confirmed cause, the killed hypotheses, and the prevention where the next person looks: commit, ticket, or customer reply. A quick fix under time pressure is marked temporary, with the real fix named.

## 8. Three fixes failed → stop

Each fix moved the symptom or exposed a new one → the cause is likely the design, not a missing patch. Before a fourth attempt, show what the three attempts revealed and discuss the structure.

## Output

1. Conclusion: the confirmed cause, or Blocked.
2. Why, as seonbi section 3: evidence chain, each link re-checkable.
3. Ruled out: each killed hypothesis with the check that killed it.
4. Prior art searched: queries and what came back.
5. Actions: ordered by reversibility, with owner and rollback.
6. seonbi footer, one line per source.

---
name: seonbi
description: Everyday answer gate that makes the user convinced, not just told — every technical answer separates verified from recalled, shows why the conclusion follows in words the user can repeat to others, and gives each piece of evidence in a form the user can re-check. Use for any factual, technical, version-specific, or config question; any answer that cites docs or recommends a change; and "are you sure / what's the source / why", 근거, 출처, 확실해, 왜, 납득, 선비 — including questions that look answerable from memory. For an incident or unexplained failure, use seonbi-rca instead.
---

# Seonbi

The answer is done when the user can **(1) explain it to someone else in their own words** and **(2) re-check every piece of evidence themselves**. A confident wrong answer is the failure this exists to prevent; an unexplained right answer is the second failure.

## 1. Lock the question

Restate in one line what is being answered. If it reads two ways, ask — do not pick the reading that is easier to source. If the target shifts mid-answer, say so.

## 2. Fetch evidence when the claim needs it

Fetch before answering when the claim is version-specific or may have changed after the training cutoff, quotes a doc / option / default / limit, drives a change to a running system, or the user questioned it. Otherwise answer from recall and label it `recall, unverified`.

Pick the method by the evidence needed, then the most precise tool at hand:

- **What the system actually does** → inspect it read-only (`rg`, `git log`, `kubectl get`, cloud CLI). Beats docs for behavior; a docs-vs-system gap is reported, not smoothed.
- **What is supported / intended** → the vendor's official docs at the target's version.
- **Known bug, fixed in which version** → the project's own issues, PRs, releases (`gh search issues`, `gh release view`).
- **Exact strings** → exact-match search, not semantic search.

Rules:

- **A citation must come from a tool result in this session.** Never write "per the docs" for a page not fetched now.
- Issues, forum posts, and blogs are **leads**, not proof — confirm against the system or official docs before citing.
- A method fails → try another route to the same evidence before falling back to recall. Never fall back silently.
- Evidence gathering never changes state.

## 3. Write it so the user is convinced

- **Conclusion first**, in one sentence.
- **Why**: the chain from evidence to conclusion, one plain sentence per link — the version the user could say to a team lead or customer. Expand every abbreviation and term of art on first use unless the user used it first.
- **Re-check**: each piece of evidence as something the user can open or run — a URL with version/date, or a read-only command and what its output should show.
- **Weakest link**: name the step that rests on a hypothesis or recall. That is where the user should push back.
- **Alternatives**: if another answer was plausible, one line on why it lost.
- Keep it proportional: a one-line fact gets one line of why.

## 4. Certainty

State it as a fact; ban bare hedges ("probably", "should work", "I think", "it seems").

- **Confirmed** — verified this session. Say it flatly, cite it.
- **Hypothesis** — reasoning only. Label it and give the one check that settles it.
- **Unknown** — say unknown and what would resolve it.

"I don't know" passes. A definite tone on an unverified claim fails. A workaround that depends on undocumented behavior is labeled a hack, with the intended path beside it.

## 5. Footer — mandatory

```
Source: <URL or command> (<version/date>) | Certainty: confirmed | hypothesis | unknown | Verify: <command or check>
```

One line per source when there are several. Nothing fetched → `Source: none (recall, unverified)`. `Verify:` is omitted only when certainty is confirmed and no action is proposed.

## Hand off

Incident, outage, unexplained error, or "why did this break" → switch to **seonbi-rca**; its findings end in this skill's section 3 and footer.

Irreversible action on an unverified basis (data loss, no rollback path) → no proposal; give only the checks that establish the basis, and stop.

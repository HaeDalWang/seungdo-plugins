# Development Workflow

## Feature Implementation Workflow

0. **Research & Reuse** _(before any new implementation)_
   - Climb the simplicity.md ladder first: this repo, stdlib, platform feature,
     installed dependency. Add a new dependency only when a few lines cannot do the job.
   - Nothing on the ladder fits → `gh search code` for a proven implementation to port,
     then package registries, then the `exa` MCP for broader web research.
   - Before using any library API, confirm behavior and version details with the
     `context7` MCP or the vendor docs.

1. **Plan First** for anything non-trivial — restate requirements, identify
   dependencies and risks, break into phases before touching code.
   - **Intent first**: if the change is noticeable to users or other systems and
     touches 3+ files, write `intent.md` before planning: Problem / Outcome +
     success criteria / affected scope and what stays unchanged / constraints /
     open questions. No how. Ask the user instead of guessing open questions.
   - Skip for typos, version bumps, behavior-preserving refactors, and spikes
     (write it once the direction is clear).
   - Location: the project's existing convention, else
     `~/.local/share/intent/<repo>/YYYY-MM-DD-<topic>.md` (outside the repo; never commit).
   - Judge "done" against the Outcome, not against the plan.

2. **TDD where it fits** — write the test first (RED), implement to pass it (GREEN),
   refactor (IMPROVE). See [testing.md](testing.md) for test scope. Not every
   change warrants full TDD ceremony — infra/ops scripts and one-off fixes often don't.

3. **Verify before claiming done** — run the actual build/type/lint/test commands and
   look at their output. For a non-trivial code change, use the
   `seungdo:verification-loop` skill. After a Kiro run, the one gate check in
   kiro-delegation.md is that rerun; otherwise rerun the proving command before
   claiming fixed.

4. **Commit & Push** — per git-workflow.md.

5. **Pre-push checks** — CI passing, merge conflicts resolved, branch up to date with
   target before opening or requesting review on a PR.

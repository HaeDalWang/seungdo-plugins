---
inclusion: always  # Kiro steering reads this; Claude Code ignores it
paths:
  - "**/*.{py,js,jsx,ts,tsx,mjs,cjs,go,rs,java,kt,rb,php,cs,swift}"
  - "**/*.{sh,bash,zsh,sql}"
---
# Coding Style

Simplicity, YAGNI, reuse, and file count live in [simplicity.md](simplicity.md).
This file covers the rest.

## Immutability

In new code, return an updated copy instead of mutating the input. In existing code,
match the file's style.

## File Size

- 800 lines max per file; split by feature/domain, not by type, when it grows past that.

## Errors and Input

- Never swallow errors silently. UI code shows a user-friendly message; server code logs
  the detailed context.
- Validate external input (user input, API responses, file content) at system boundaries,
  with a schema where one exists. Fail fast with a clear error.

## Naming Conventions

- Follow the language's idiom and the file's existing names: `camelCase` in JS/TS/Java/
  Kotlin/Swift, `snake_case` in Python/Rust/Ruby/shell, `MixedCaps` in Go, `PascalCase`
  for types and components
- Booleans: prefer `is`, `has`, `should`, or `can` prefixes
- Constants: `UPPER_SNAKE_CASE` where the language uses it

## Code Smells to Avoid

### Deep Nesting

Prefer early returns over nested conditionals once the logic starts stacking.

### Magic Numbers

Use named constants for meaningful thresholds, delays, and limits.

## Code Quality Checklist

Before marking work complete: functions <50 lines, files <800 lines, nesting ≤4 levels,
no unnamed magic numbers (config only for values that actually vary).

## Review Severity

When flagging issues (self-review or requested review), grade by actual impact:

| Level | Meaning | Action |
|-------|---------|--------|
| CRITICAL | Security vulnerability or data loss risk | Block — must fix before merge |
| HIGH | Bug or significant quality issue | Should fix before merge |
| MEDIUM | Maintainability concern | Consider fixing |
| LOW | Style or minor suggestion | Optional |

For an actual review pass (not just self-check), use a `code-review` skill or
`/code-review` command if one is listed.

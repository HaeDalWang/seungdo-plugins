---
inclusion: always  # Kiro steering reads this; Claude Code ignores it
paths:
  - "**/*.{py,js,jsx,ts,tsx,mjs,cjs,go,rs,java,kt,rb,php,cs,swift}"
  - "**/*.{sh,bash,zsh,sql}"
  - "**/*.{tf,tfvars,hcl,yaml,yml}"
  - "**/Dockerfile"
  - "**/.env*"
  - ".github/**/*"
---
# Security Guidelines

## Mandatory Security Checks

Before ANY commit:
- [ ] No hardcoded secrets (API keys, passwords, tokens)
- [ ] User input validated; SQL parameterized
- [ ] Authentication/authorization verified
- [ ] Error messages don't leak sensitive data
- [ ] Web endpoints only: HTML escaped (XSS), CSRF protection, rate limiting

## Secret Management

- NEVER hardcode secrets in source code
- ALWAYS use environment variables or a secret manager
- Validate that required secrets are present at startup

## Security Response Protocol

If you find a security issue:
1. Stop and tell the user.
2. Fix CRITICAL issues before continuing, only in files the task lets you edit. In a
   read-only task, report only.
3. Rotating a secret is the user's action: name each secret to rotate and where it was
   exposed.
4. Search the rest of the codebase for the same pattern.

If a `security-review` skill or `/security-review` command is listed, use it for a
structured pass over pending changes.

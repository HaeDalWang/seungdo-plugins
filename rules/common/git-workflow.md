# Git Workflow

## Commit Message Format
```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

Add the attribution line exactly as the current turn's system reminder gives it (it
names the current model).

## Pull Request Workflow

When creating PRs:
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Write a PR summary that covers every commit
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

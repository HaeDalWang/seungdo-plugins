# 출처

`SKILL.md`는 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC)의
`skills/verification-loop`을 가져와 수정한 것이다. 원본은 MIT이며, 이 디렉터리도 MIT로 유지한다.

| 변경 | 내용 |
|---|---|
| 추가 | frontmatter에 출처 표기 |
| 수정 | npm 가정 대신 프로젝트 실제 명령 감지(Step 0) (2026-10-16, `3fe1b96`·`6f07ad6`·`d6e897a`) |
| 삭제 | 커버리지 80%·Continuous Mode·`/verify` |
| 수정 | 보안 스캔·diff를 기본 브랜치 merge-base 기준 변경 파일로 한정, 변경 없음은 SKIPPED로 보고 |

채택 근거: ECC 스킬 중 다른 스킬을 참조하지 않는 유일한 자립형이다.

---

MIT License

Copyright (c) 2026 Affaan Mustafa

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# AGENTS.md

AI coding agent + human contributor guide for new DSP authoring + designer agent maintenance.

## 새 DSP 작성 시 체크리스트

`_template.md`를 복사한 뒤 다음 모든 항목을 만족시켜야 PR merge:

### Frontmatter (5 fields)

- [ ] `name`: kebab-case slug (파일명과 일치)
- [ ] `type`: `design-system-prompt` (literal)
- [ ] `domain`: 한 문장 — 산업·페이지 type 명시
- [ ] `tone`: 3-5 형용사 (예: `precision, trustworthy, technical, dense, monochrome`)
- [ ] `reference`: 3-5 brand · award winner · 출처 명시
- [ ] (mobile only) `platform: mobile`

### Section 1 — Design System Definition

- [ ] **Primary Color** hex 또는 oklch + 역할 1줄
- [ ] **Accent Color** — single accent commit (페이지당 1개). 대안 옵션 제시 가능하나 사용은 1개로 lock
- [ ] **Text Color** — heading + body 최소 2단 (필요 시 caption 추가)
- [ ] **Typography** — display + body 2-family minimum. 단일 family (Inter만 사용) 금지
- [ ] **Border Radius** — token 범위 명시 (예: `8px buttons / 12px cards / 999px pills`)
- [ ] **Shadow** — 2× distance rule (blur = 2× distance) 적용된 raw value 또는 hairline-only 선언
- [ ] **Icon Style** — stroke width · 단색/duotone · 배경 유무

### Section 2 — Layout & Structure

- [ ] 데스크톱 기준 너비 + breakpoint list
- [ ] Grid 컬럼 · gutter · padding
- [ ] 영역 분할 (좌·우·중앙 또는 single column 명시)
- [ ] 반응형 collapse 정책
- [ ] 섹션 간 연결 방식 (hairline / fade / hard cut)

### Section 3 — UI Elements & Animation

- [ ] Button variants 3종 이상 (Primary / Ghost / Tertiary 또는 등가)
- [ ] Card / Badge / Nav 룰 명시
- [ ] Animation library 명시 (Framer Motion / GSAP / Reanimated / CSS)
- [ ] Motion specs (duration · easing · property limits)
- [ ] (mobile only) Haptic feedback hint per interaction class

### Section 4 — Consistency Mandate

- [ ] 적용 범위 (이후 어떤 섹션·페이지에 강제)
- [ ] AI-generic banned 패턴 **최소 10개** 명시 — 각 항목은 구체적 (단순 "no purple gradient" 금지 → "purple→blue radial gradient on hero section background, Stripe mimicry")
- [ ] 도메인별 시그널 mandate (해당 도메인의 trust signal, accessibility 요구 등)

## Review 시 자주 발견되는 violation

| Violation | 수정 패턴 |
|---|---|
| Single accent rule 위반 (2개 이상 accent 사용) | `oklch(...)` 옵션 2-3개 제시 후 "**하나만 commit**" 명시 강제 |
| Banned patterns가 vague | 구체적 hex/property로 변환 — `bg-indigo-*`, `backdrop-blur-xl`, `filter: blur` |
| Reference가 글로벌 brand만 | 한국 시장 reference 1개 이상 추가 (지디웹 수상작, 한국 brand) |
| Animation duration cap 누락 | "Interactive ≤ 300ms" rule 명시 + marketing exception 정의 |
| `#000000` / `#ffffff` 등장 | near-black/near-white로 교체 (예: `oklch(0.14 ... )` / `oklch(0.97 ...)`) |
| 폰트 단일 family (Inter only) | Display + Body 2-family pair 강제 |

## Designer agent (`agents/designer.md`) 수정 시

- coder.md mirror 관계 유지 — 7-section spec discipline (TASK / EXPECTED / CONTEXT / CONSTRAINTS / MUST DO / MUST NOT / OUTPUT)
- Iteration loop의 MANDATORY 어조 유지 — 단일 generation은 failure
- Tools list에 `mcp__playwright__*` 포함 강제 (screenshot iteration의 dependency)
- Hard rules section은 DSP가 explicitly 허용 안 한 한 글로벌 anti-AI-slop 룰 유지

## Versioning

- DSP 파일 변경 시 frontmatter에 `version` 추가 또는 commit message로 변경 사유 명시
- Breaking change (token 대폭 변경 등)는 별도 PR + 사용 중인 페이지 검증 필요

## Test하는 법 (DSP 추가 시)

1. `./install.sh` 재실행 (or 이미 install되어 있으면 skip)
2. Claude Code 세션 재시작
3. designer agent에 새 DSP로 hero 짜기 위임
4. Screenshot 결과가 DSP의 Layout & Structure 묘사와 일치하는지 시각 검증
5. DSP의 "Banned patterns"를 코드에서 grep — 매칭되면 DSP 추가 강화 필요

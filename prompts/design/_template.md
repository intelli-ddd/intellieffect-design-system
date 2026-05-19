---
name: <kebab-case-slug>
type: design-system-prompt
domain: <도메인 한 문장 — 예: Fintech B2B Dashboard / Luxury E-commerce / SaaS Developer Tool>
tone: <3-5 형용사 — 예: brutalist, technical, dense, monochrome>
reference: <영감 출처 — GDWEB <에이전시명> / awesome-design-md <site> / 사용자 첨부 이미지 등>
---

# Design System Prompt — <도메인 이름>

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/<slug>.md` 로 참조.

[1-2문장 컨텍스트 — 웹사이트 타입·타겟 사용자·핵심 message]

## 1. Design System Definition

- **Primary Color:** `#XXXXXX` (의미·역할 1줄)
- **Accent Color:** `#XXXXXX` (CTA·핵심 강조 한정 사용)
- **Text Color:** `#XXXXXX` (헤드라인), `#XXXXXX` (바디)
- **Typography:** [serif/sans/mono 가족 명시 + heading weight + body weight + 사용 금지 패턴 (그라데이션 텍스트 금지 등)]
- **Border Radius:** [Xpx — 라운드 정책]
- **Shadow:** [shadow token verbatim — 거리값 = 2x blur 룰 적용]
- **Icon Style:** [배경 유무, 색상 룰, 사용 금지 패턴]

## 2. Layout & Structure (<섹션 이름 — Hero / Pricing / Dashboard 등>)

- [데스크톱 기준 너비 + breakpoint]
- [그리드 / 컬럼 구조]
- [좌·우·중앙 영역 분할 — 어떤 콘텐츠가 어디 위치]
- [반응형 확장 정책 — Auto Layout / CSS Grid / Flexbox / Container Query]
- [섹션 간 연결 처리 — fade / hairline divider / negative space]

## 3. UI Elements & Animation

- [버튼 컴포넌트 정의 — Primary / Secondary / Ghost variant 각각의 visual rule]
- [카드 / 뱃지 / 네비게이션 룰 — Border Radius + Shadow 공유]
- [animation 라이브러리 명시 — Framer Motion / GSAP / CSS / View Transitions]
- 애니메이션 룰:
  - [진입 — staggered / fade / slide / instant]
  - [hover — opacity / y-axis / scale 범위]
  - [duration cap — interactive ≤300ms, marketing scroll-reveal 예외]
  - [easing — cubic-bezier 명시 또는 spring 파라미터]

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(<list>)과 모든 서브 페이지는 반드시 위 Design System Definition을 엄격하게 준수.
- 새로운 색상·다른 Radius·다른 아이콘 스타일의 임의 추가 절대 허용 금지.
- AI 생성물처럼 보이는 시각적 패턴 배제:
  - [구체적 banned 패턴 1 — 예: 보라/인디고 그라데이션 금지]
  - [banned 패턴 2 — 예: shadcn 기본 테마 금지]
  - [banned 패턴 3 — 도메인별 cliché]
- 이 <섹션 이름>을 기준으로 전체 웹사이트의 톤앤매너·레이아웃·UI 규칙을 일관되고 의도적으로 확장하라.

## 5. (선택) Reference 시각 자료

- [reference 사이트 URL 또는 GDWEB 수상작 thumbnail]
- [핵심 visual cue verbatim 인용 — 예: "마스트헤드 좌측 italic logo + 우측 issue number"]
- [moodboard image path — 첨부 시 `./moodboards/<slug>/` 디렉토리]

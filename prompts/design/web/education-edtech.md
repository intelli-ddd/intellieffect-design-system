---
name: education-edtech
type: design-system-prompt
domain: EdTech / 학습 플랫폼 (K-12, 대학 강의, 코딩 부트캠프, 어학)
tone: friendly, approachable, optimistic, accessible, structured
reference: Duolingo, Coursera, Khan Academy, Brilliant, 천재교과서, 뮤지엔테크
---

# Design System Prompt — Education / EdTech

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용.

첨부된 레퍼런스를 분석하여, 풀-와이드 Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **EdTech / Online Learning Platform**이며, 톤은 Duolingo의 친근함, Coursera의 정보 구조, Khan Academy의 접근성, Brilliant의 학습 흐름, 그리고 천재교과서·뮤지엔테크 같은 한국 교육 플랫폼의 명료한 위계를 표적으로 한다. 어린 학습자 대상이라도 infantilize 금지 — 학습자를 능력 있는 주체로 대우.

## 1. Design System Definition

- **Primary Color:** `#FCFBF7` (warm white 배경 — pure `#FFFFFF` 금지, 종이 같은 따뜻한 base로 장시간 학습 환경의 eye strain 완화). 대안 `#FFFDF8`.
- **Accent Colors (2-color semantic system):** EdTech는 정보 구분이 핵심이므로 단일 accent 금지, 2-color 의미 분리 강제.
  - **Primary Accent (Study / Course):** `oklch(0.55 0.16 245)` — confident blue. Course thumbnail border, lesson navigation, primary CTA "수강 시작", active state.
  - **Secondary Accent (Progress / Achievement):** `oklch(0.72 0.16 60)` — warm amber. Progress bar fill, completion badge, streak counter, achievement notification.
  - 두 accent는 의미가 명확히 분리됨 — Course 영역에 amber, Progress 영역에 blue 같은 임의 사용 절대 금지.
  - 대안 palette (brand에 따라 swap 가능): sage green `oklch(0.62 0.12 155)` (study) + warm coral `oklch(0.70 0.17 30)` (progress).
- **Text Color:** `#1C1D24` (헤드라인 · lesson title), `#5C5E68` (바디 · description · meta). 대안 heading `#1F2028`.
- **Typography:** Display + Body sans-serif 페어, 한국어 지원 우선.
  - **Display:** `Pretendard Variable` 또는 `Geist` — Hero headline, course title, section heading. Weight `600-700` (heading impact).
  - **Body:** `Pretendard` 또는 `Inter` — 본문, lesson description, navigation. Weight `400-500`.
  - **Mono:** `Geist Mono` 또는 `JetBrains Mono` — progress 숫자 (`12/24 lessons`), lesson ID, course duration (`4h 32m`), code snippet (코딩 부트캠프 한정). Mono ↔ sans 혼용으로 진행 데이터를 시각적으로 분리.
  - 텍스트 그라데이션 절대 금지.
- **Border Radius:** `12px` (card · button · input), `16px` (large course preview card), `999px` (pill, badge, tag, category chip). Friendly 톤 확보, 단 `24px` 이상은 infantile 톤으로 흐름 — 금지.
- **Shadow:** medium soft, 2× distance rule.
  - Base: `0 4px 12px rgba(0,0,0,0.06)`
  - Hover: `0 8px 20px rgba(0,0,0,0.08)`
  - Course card에 강제 적용, hairline border (`1px solid rgba(28,29,36,0.08)`)와 병용 가능.
- **Icon Style:** duotone — primary outline (`1.5px` stroke) + accent fill at 20% opacity. 일관된 stroke width `1.5px` 강제. Lucide / Phosphor (Duotone) 기반. Emoji를 primary icon으로 사용 금지 (학습 contextual illustration은 허용).

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1440px` 풀-와이드 프레임, 콘텐츠 max-width `1280px`. Breakpoint: `1280 / 1024 / 768 / 480`.
- 12-column grid, gutter `24px`, side padding `64px` (desktop) / `24px` (mobile).
- **Split layout (asymmetric 6:6 또는 7:5):**
  - **좌측 (6-col, content stack):**
    - Eyebrow pill badge (e.g. `NEW · 신규 강의` — Primary Accent background at 12% opacity, accent text)
    - Headline (Display, clamp `48px → 64px`, line-height `1.1`, `#1C1D24`, max 3 lines)
    - Sub-description (Body, `18px`, `#5C5E68`, max 2-3 lines)
    - **Stat row** (3개): 누적 수강생 / 강의 수 / 평균 평점 — Mono Display size + sans label. Hairline divider 분리.
    - CTA row: Primary (`Primary Accent` solid + warm white text) + Ghost (border + dark text). 우측에 "샘플 강의 보기" tertiary link.
    - 하단 trust strip: 파트너 학교/기업 로고 4-6개 monochrome.
  - **우측 (6-col, course preview):**
    - **Course preview card** — 실제 강의 카드를 hero에 노출:
      - 강의 thumbnail (16:9, rounded `12px`)
      - 강사 avatar + name
      - Lesson count (`24 lessons`) · duration (`4h 32m`) — Mono
      - **Progress bar** with amber fill (인스타그램 stories 강도 금지, subtle 4px height)
      - Rating + 수강생 수
    - 또는 student avatar grid (3×3, 9개 원형 avatar) + 1줄 testimonial quote.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<1024px`에서 vertical stack, course preview card는 below text.
- Hero 하단은 hairline border 또는 다음 섹션의 warm white와 자연스러운 연결. Decorative gradient 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary`: Primary Accent solid, text warm white, radius `12px`, padding `14px 24px`, weight `600`. Hover: brightness +4%, `y: -1px`.
  - `Secondary (Progress CTA)`: Secondary Accent solid — "내 학습 이어하기" 같은 progress 맥락 한정.
  - `Ghost`: transparent, border `1px rgba(28,29,36,0.12)`, text `#1C1D24`. Hover: background `rgba(28,29,36,0.04)`.
  - `Tertiary`: text Primary Accent, underline on hover.
- **Course Card:** background `#FFFFFF`, border `1px rgba(28,29,36,0.06)`, radius `16px`, padding `20px`. Hover: shadow upgrade + `scale(1.02)`.
- **Progress Bar:** height `6px`, track `rgba(28,29,36,0.08)`, fill Secondary Accent. Smooth fill animation `400ms` ease-out on mount.
- **Badge / Tag / Category Chip:** pill (radius `999px`), `12px` weight `500`, padding `4px 10px`. 카테고리별 accent tinted background (8% opacity) + accent text. 무지개 multicolor 금지.
- **Lesson list item:** hairline divider 분리, checkbox + lesson title + duration (Mono right-aligned).
- **Animation library:** Framer Motion.
  - Duration `200-300ms`, easing `cubic-bezier(0.22, 1, 0.36, 1)` (ease-out emphasized).
  - **Transform · opacity only.** Filter blur · color animation 금지.
  - Hero 진입: text staggered reveal, `y: 12px → 0`, opacity `0 → 1`, stagger `60ms`. Course preview card는 `300ms` 후 fade+slide.
  - Progress bar: width `0 → target%` over `600ms` ease-out, on viewport enter.
  - Hover: `scale(1.02)` 상한, `y: -2px`. Bouncy spring · overshoot 금지 (어린 학습자 대상이라도).
  - Achievement notification 같은 트리거 모션은 single bounce `1.0 → 1.06 → 1.0` (300ms) 1회만 허용.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Course catalog, Curriculum, Instructor profile, Testimonials, Pricing, FAQ, Footer) 및 서브 페이지(Course detail, Lesson player, Dashboard, Certificate)는 위 Design System Definition을 엄격히 준수.
- 새로운 색상 · 다른 radius scale · 다른 아이콘 스타일의 임의 추가 금지.
- 2-color semantic system 강제 — Primary Accent는 study/navigation, Secondary Accent는 progress/achievement. 혼용 금지.
- **Banned patterns (AI EdTech cliché — 명시적 배제):**
  - Purple → pink gradient ("AI tutor" cliché)
  - Glassmorphism on course card (backdrop-blur)
  - Emoji as primary icon (📚 🎓 🚀 같은 데코 이모지)
  - 3-column "Features" 카드 grid (icon + title + 2-line description) — 클리셰
  - Gamification overload — badge·trophy·fire streak·confetti를 동시에 노출 금지. 사용 시 한 화면에 1개 메커니즘만.
  - Bouncy spring · overshoot · elastic easing
  - 무지개 multicolor 카테고리 (각 카테고리 다른 색상으로 8개+ 사용)
  - Stock illustration of "diverse students" · "lightbulb" · "graduation cap"
  - Neon accent · saturated cyan/magenta
- **Accessibility mandate:** 학습 플랫폼이므로 WCAG AA contrast 강제. Body text `#5C5E68` on `#FCFBF7` 검증. Focus ring 2px Primary Accent 강제, outline 제거 금지. 한글·영문 mixed line-height 최소 `1.6`.
- 이 Hero Section을 기준으로 전체 사이트의 톤앤매너, 정보 위계, 학습 흐름 표기 규칙을 일관되고 의도적으로 확장하라. Duolingo의 친근함과 Coursera의 정보 구조를 합쳐 단일 학습 신뢰감으로 통합한다.

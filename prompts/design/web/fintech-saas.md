---
name: fintech-saas
type: design-system-prompt
domain: Fintech / B2B Financial SaaS (payments infra, data analytics, risk management)
tone: precision, trustworthy, technical, dense, monochrome-with-single-accent
reference: Stripe, Mercury, Brex, Ramp, Linear
---

# Design System Prompt — Fintech SaaS

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용.

첨부된 레퍼런스를 분석하여, 풀-와이드 Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Fintech / B2B Financial SaaS**이며, 톤은 결제 인프라(Stripe), 비즈니스 뱅킹(Mercury), 비용 관리(Brex/Ramp), 엔터프라이즈 툴(Linear)의 정밀하고 기술적인 신뢰감을 표적으로 한다.

## 1. Design System Definition

- **Primary Color:** `#FBFBFB` (near-white 배경 — pure `#FFFFFF` 금지, 살짝 따뜻한 paper 톤으로 dense text를 받아내는 베이스)
- **Accent Color:** `#1E4DB7` (deep ink blue, CTA · 핵심 metric 강조 · active state 한정). Stripe-style purple 및 purple→blue gradient 절대 금지 (AI cliché).
- **Text Color:** `#0E1014` (헤드라인 · 핵심 수치), `#62656A` (바디 · 보조 라벨)
- **Typography:** 3-family system.
  - **Display:** `Söhne` 또는 `Inter Display` (grotesk display) — Hero headline 및 section title 전용
  - **Body:** `Inter` 또는 `Geist` — 본문 · 라벨 · 버튼 텍스트
  - **Mono:** `Berkeley Mono` 또는 `Geist Mono` — **반드시** transaction ID · API key · numeric metric (USD amount, percentage, latency ms) · inline code snippet 표시에 강제 사용. Mono ↔ sans 혼용으로 데이터 신뢰감을 시각적으로 분리.
  - 텍스트 그라데이션 절대 금지 — 특히 metric 위 gradient text는 금융 신뢰감을 즉시 파괴한다.
- **Border Radius:** `8px` (input · button · small badge), `12px` (card · panel). 16px 이상은 technical 톤을 흐트러뜨림 — 금지.
- **Shadow:** 2× distance rule 기반의 절제된 듀얼 섀도우만 허용:
  - `box-shadow: 0 1px 2px rgba(0,0,0,0.04), 0 8px 24px -8px rgba(0,0,0,0.08);`
  - Hero 영역 product mock 외에는 hairline border (`1px solid rgba(14,16,20,0.08)`) 우선 사용.
- **Icon Style:** monoline stroke `1.5px`, 단색 (`#0E1014` 또는 `#62656A`), 배경 없음. Lucide / Phosphor (Light weight) 기반. 파스텔 배경 · 컬러 아이콘 절대 금지.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1440px` 풀-와이드 프레임, 콘텐츠 max-width `1280px`. Breakpoint: `1280 / 1024 / 768 / 480`.
- 12-column grid, gutter `24px`, side padding `64px` (desktop) / `24px` (mobile).
- **Split layout (asymmetric 7:5):**
  - **좌측 (7-col, dense text stack):**
    - Eyebrow (mono, uppercase, tracked `0.08em`, `#62656A`)
    - Headline (Display, clamp `52px → 72px`, line-height `1.04`, `#0E1014`, max 3 lines)
    - Sub-description (Body, `18px`, `#62656A`, max 2 lines)
    - **Key metric stack** — 3개 horizontal metric (예: `99.99% uptime` · `<200ms p95` · `$2.4B processed`). 숫자는 Mono Display size, 라벨은 sans `13px` `#62656A`. Hairline divider로 분리.
    - CTA row: Primary (`#1E4DB7` 배경 + `#FBFBFB` 텍스트) + Ghost (border `1px` `#0E1014` 14% opacity).
  - **우측 (5-col, product mock):**
    - 실제 product UI 미리보기 — dashboard preview with mini chart + transaction list + API code sample 중 하나. Mock은 자기 자신의 design system (mono numbers, hairline borders)을 그대로 반영해 fractal 일관성을 확보.
    - Subtle perspective tilt 금지 — flat front-facing only.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<1024px`에서 vertical stack, product mock은 below text.
- Hero 하단은 hairline border 또는 `1px` ruler line으로 다음 섹션과 연결 — fade gradient 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary`: `#1E4DB7` solid, text `#FBFBFB`, radius `8px`, padding `12px 20px`, weight `500`. Hover: brightness +4% only.
  - `Ghost`: transparent, border `1px rgba(14,16,20,0.14)`, text `#0E1014`. Hover: background `rgba(14,16,20,0.04)`.
  - `Tertiary (inline link)`: text `#1E4DB7`, underline on hover only.
- **Card:** background `#FFFFFF`, border `1px rgba(14,16,20,0.08)`, radius `12px`, padding `24px`. Shadow는 hover 시에만 적용.
- **Badge:** mono `12px`, uppercase, tracked `0.06em`, background `rgba(30,77,183,0.08)` text `#1E4DB7` 또는 neutral variant. Pill shape (radius `999px`) 만 허용.
- **Nav:** sticky top, height `64px`, background `rgba(251,251,251,0.85)` + `backdrop-filter: saturate(180%) blur(8px)` (단, 카드에는 backdrop-blur 적용 금지 — nav 한정). Hairline bottom border.
- **Animation library:** Framer Motion. 룰:
  - Duration `150–200ms`, easing `cubic-bezier(0.2, 0, 0, 1)` (Linear-style).
  - **Transform · opacity only.** Filter blur · color animation 금지.
  - Hero 진입: text staggered reveal, `y: 8px → 0`, opacity `0 → 1`, stagger `40ms`.
  - Hover: `scale(1.02)` 상한. Bouncy spring · overshoot 금지.
  - Parallax · scroll-jacking · marquee 금지.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Features, Customer logos, Use cases, Pricing, Docs preview, Footer) 및 서브 페이지(Product, Pricing, Customers, Docs, Changelog)는 위 Design System Definition을 엄격히 준수.
- 새로운 색상 · 다른 radius scale · 다른 아이콘 스타일의 임의 추가 금지.
- **Banned patterns (AI fintech cliché — 명시적 배제):**
  - Purple → blue gradient background (Stripe mimicry)
  - Glassmorphism card (backdrop-blur on content card)
  - Gradient text — 특히 numeric metric 위
  - Bouncy spring · overshoot · elastic easing
  - Decorative emoji icons · multicolor 3D icons
  - Neon accent · saturated cyan/magenta
  - 파스텔 톤 아이콘 배경
  - Stock illustration of "handshake" · "rocket" · "abstract globe"
- **Data integrity 시그널:** 모든 숫자(금액, 퍼센트, latency, count)는 mono family로 표기. 천 단위 separator 일관성 유지 (`$2,400,000` 또는 `$2.4M` 중 페이지 전체 통일). Negative value는 `#B7281E` 또는 mono red, never red gradient.
- 이 Hero Section을 기준으로 전체 사이트의 톤앤매너, layout density, 데이터 표기 규칙을 일관되고 의도적으로 확장하라. Stripe의 정교함, Mercury의 절제, Linear의 밀도를 합쳐 단일 신뢰감으로 통합한다.

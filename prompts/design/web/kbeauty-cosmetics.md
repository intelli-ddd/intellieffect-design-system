---
name: kbeauty-cosmetics
type: design-system-prompt
domain: K-beauty / 한국 화장품 브랜드 마케팅 (스킨케어 · 메이크업 · 색조 · 향)
tone: soft skin-toned, dewy photographic, ingredient-focused, calm-yet-modern, photographic warmth
reference: 동국제약 마데키엘, 멜로우앤코 (지디웹 2026 수상작), 조선미녀, 닥터자르트, 라네즈, 어뮤즈, 토니모리, 헤라
---

# Design System Prompt — K-beauty / Korean Cosmetics

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/kbeauty-cosmetics.md` 로 참조.

첨부된 레퍼런스를 분석하여, editorial 한국 화장품 브랜드 사이트의 풀-와이드 Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **K-beauty / Korean Cosmetics Brand Marketing (스킨케어 · 메이크업 · 색조 · 향)**이며, 톤은 지디웹 2026 수상작 (동국제약 마데키엘 · 멜로우앤코), 조선미녀의 한방 prestige, 닥터자르트의 derma editorial, 라네즈의 dewy photographic을 표적으로 한다. 한국 소비자의 **ingredient-first 정보 위계** — 성분 · 효능 · 임상 결과 · 사용법을 카탈로그 위치로 박을 것. 제품 자체가 sacred — photography·typography가 제품을 가리거나 흐려선 안 된다.

## 1. Design System Definition

- **Primary Color (Background):** `oklch(0.965 0.018 50)` (warm cream/peach paper) 또는 `oklch(0.95 0.010 30)` (blush warm white). Pure `#FFFFFF` 금지 — warm paper tone이 제품 photography의 skin-tone과 자연스럽게 연결.
- **Accent Color:** 하나만 commit. 선택지:
  - `oklch(0.62 0.10 25)` deep rose-coral (color cosmetic · 립스틱 라인)
  - `oklch(0.55 0.06 80)` muted moss (한방·natural derma 라인)
  - `oklch(0.62 0.05 60)` warm taupe (neutral skincare 라인)
  - `oklch(0.78 0.08 65)` rose gold (premium · anti-aging 라인)
  - **Purple/violet 절대 금지** (AI-generic "K-beauty modern" cliché).
- **Text Color:** `oklch(0.20 0.012 50)` (deep umber heading), `oklch(0.45 0.014 50)` (body), `oklch(0.62 0.010 50)` (muted caption · 성분 명세). Pure `#000000` 금지 — umber tone이 warm cream background와 호흡.
- **Typography:** 3-family system, **한글 우선** — 영문은 secondary.
  - **Display Serif (제품명 · 브랜드 statement):** `Cormorant Garamond` / `Tiempos Headline` (영문) + `본명조` / `Pretendard Display` (한글). Weight `400-500` (refined serif는 light weight가 prestige). Letter-spacing `-0.015em`.
  - **Body Sans:** `Pretendard Variable` — 본문, navigation, ingredient list. 한글 우선 family.
  - **Mono (제한적):** `Geist Mono` / `Söhne Mono` — 제품 정보, SKU, 성분 비율 (`나이아신아마이드 5%` · `LOT 2026-04` · `30ml`) 표기 한정.
  - 텍스트 그라데이션 절대 금지.
  - 영문 위주 typography 금지 — 한글 브랜드명·제품명이 primary, 영문 italic은 secondary tagline 한정.
- **Border Radius:** `12-16px` (soft approachable) 기본 — button, badge, content card. **Product image card는 `0` 또는 `4px`** (still-life museum tone — 제품 사진은 sharp edge로 박물관 진열 느낌). Mixed scale 허용 — UI는 soft, photography frame은 sharp.
- **Shadow:** 매우 미세 — `0 4px 12px rgba(0,0,0,0.04)` 한정 (floating CTA · cart badge). Photography 자체가 elevation 역할이므로 추가 shadow stack 금지.
- **Icon Style:** 단색 monoline `1.5px` stroke. Lucide Light 또는 custom hairline botanical (성분 식물 silhouette 허용). 단일 accent color 또는 text color만. **성분 아이콘 같은 다중 카테고리 색상 절대 금지** — pastel rainbow ingredient icon은 AI-generic cliché.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1440-1920px` 풀-와이드 프레임. Inner padding `64-80px` desktop / `24px` mobile.
- **Hero 패턴 (2개 variant 중 선택, 사이트 단위로 lock):**
  - **Variant A — Editorial Still-life (default for skincare · 향):**
    - 좌측 (5-6col): large product photography. Glass bottle backlit, soft window light, beige/peach paper background. 제품 1개 hero shot — clutter 금지.
    - 우측 (6-7col): typographic statement. Eyebrow (Mono uppercase `12px` tracked `0.12em`) → 한글 제품명 (Display Serif clamp `48px → 96px`, line-height `1.05`) → 영문 italic sub (Serif italic `20-24px`) → Tagline (Sans `16-18px`, max 2 lines) → Ingredient highlight (Mono small caps, 2-3개 핵심 성분 + 농도) → CTA pair.
  - **Variant B — Lifestyle Portrait (default for color cosmetic · 메이크업):**
    - Full-bleed model portrait (16:9 또는 21:9, `100vh` desktop / `80vh` mobile). Natural skin texture 강조 — heavy retouching 금지.
    - Bottom-left overlay: 한글 캠페인명 (Display Serif clamp `56px → 112px`) + 영문 sub italic + Mono release date (`2026.06.04 LAUNCH`).
- **Top nav (transparent overlay):** 좌측 한글 브랜드 wordmark (Serif `20-24px`) + 중앙 5-7 menu (Sans `15px`, 제품 카테고리 한글 우선: 스킨케어 · 메이크업 · 향 · 브랜드 스토리 · 매거진 · 스토어) + 우측 search · cart · login. Hairline bottom border on scroll.
- **CTA placement:**
  - **Primary:** "구매하기" / "제품 보기" — accent fill, padding `14px 32px`, radius `12px`, Sans `15px` medium. Hover: background opacity `0.85`.
  - **Secondary:** "성분 알아보기" / "사용법 보기" — text + thin underline + small arrow glyph. No background.
- **Bottom info strip (Variant A 한정):** 가로 3-column — `핵심 성분` · `피부 타입` · `용량`. Each cell: Mono label (uppercase `11px` tracked) + Body value. Hairline divider.
- 12-column grid는 inner content에만 적용, hero photography는 full-bleed.
- 모든 요소 **Auto Layout** / CSS Grid 기반. 반응형 `<1024px`: 제품 이미지 위로 stack, typography 아래로.
- Hero 하단은 cream paper background로 hard cut 또는 1vh subtle vignette. Gradient fade 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Filled)`: accent color background, deep umber text, radius `12-16px`, padding `14px 32px`. Hover: opacity `0.85`, no transform.
  - `Secondary (Outline)`: 1px accent border, transparent background, accent color text, same radius. Hover: background accent `10%` opacity.
  - `Tertiary (Link)`: text + underline + arrow `→`. Hover: arrow translate `x: 4px`.
  - Floating "장바구니" sticky CTA bottom-right (mobile 한정), shadow `0 4px 12px rgba(0,0,0,0.04)`.
- **Product card:** image (radius `0` 또는 `4px`) + 1px hairline bottom divider + 한글 제품명 (Serif `18-20px`) + 영문 sub (italic `14px`) + Mono price (`32,000원`). Hover: image slight scale `1.0 → 1.02` over `400ms` ease-out only (subtle museum-grade lift). Card border·shadow 금지.
- **Ingredient card / Routine card:** background `oklch(0.98 0.008 50)` (slightly warmer than primary bg), radius `16px`, 24px padding. 성분명 (Serif) + 효능 description (Sans body) + 농도 (Mono). 다중 색상 icon 금지.
- **Badge:** Mono `11px` uppercase tracked `0.12em`. 예: `BESTSELLER` · `NEW` · `한정판` · `리뉴얼`. Radius `4px` (rectangular) — pill 금지. Accent color text on transparent background, 1px hairline border.
- **Nav:** transparent overlay → hairline bottom border on scroll. Sub-menu mega-dropdown (카테고리별 product thumbnail grid, 한방·진정·미백·안티에이징 등 한국 효능 위계 기준).
- **Ingredient list table:** hairline divider 분리, 성분명 (Sans medium) + 농도 (Mono) + 효능 1줄 (Sans body muted). EWG safety grade 표기 — 한국 K-beauty consumer expectation.
- **Animation library:** Framer Motion + GSAP (Ken Burns photography effect 한정).
  - **Hero photography Ken Burns:** on-load only, slow zoom `1.0 → 1.03` over `≤1800ms` ease-out. Loop 금지 — single playback.
  - **Text fade-in:** Hero typography `opacity 0 → 1` + `y: 12px → 0` over `600-900ms` ease-out (marketing exception). Eyebrow → 제품명 → tagline → CTA 순 stagger `150ms`.
  - **Scroll reveal:** ingredient story, routine guide, testimonial section viewport enter 시 `y: 20px → 0` + opacity over `500ms` ease-out. 한 번만 트리거.
  - **Hover:** subtle opacity `0.85` 또는 product card scale `1.0 → 1.02`. Bouncy spring · 큰 transform 금지.
  - **Banned motion:** Sparkle/shimmer particle effects, "글로우 메이크업" overlay filter on photography, lens flare, chromatic aberration, parallax scroll-jack, bouncy spring, marquee infinite loop, video autoplay with sound.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Hero · 제품 상세 · 루틴 가이드 · 성분 스토리 · 매거진 · 장바구니 · 브랜드 소개 · Footer)과 모든 서브 페이지는 위 Design System Definition을 엄격히 준수.
- Single accent only — 처음 선택한 accent 외 다중 색상 동시 사용 금지 (한 palette 내 1-2개로 lock).
- 새로운 색상 · radius scale · 아이콘 multi-color 사용 금지.
- **Banned patterns (AI K-beauty cliché — 명시적 배제):**
  - AI-generic "K-beauty modern" pink-purple gradient
  - Glassmorphism on product card — 제품 자체가 sacred, 흐려선 안 됨
  - Cartoon 캐릭터 mascot (Olive Young 톤 cliché)
  - Sparkle / shimmer particle effects · star dust animation
  - "글로우 메이크업" overlay filter on photography
  - Loud "SALE!" / "한정수량!" 빨간 sticker badge · ribbon · burst graphic
  - 영문 위주 typography (한글 브랜드명·제품명이 secondary로 밀려나는 구조 금지)
  - Centered hero + gradient blob 배경
  - 다중 accent color 동시 사용 (rainbow palette · pastel ingredient icon)
  - Pastel rainbow ingredient icon set
  - Gradient text · gradient button · gradient border
  - 3-up identical feature card with pastel icon + heading + body
  - AI-rendered product render with plastic sheen — branded photoshoot 또는 minimal still-life SVG render 강제
  - Generic Unsplash "skincare bottle" stock photo
- **Korean K-beauty 시그널 mandate:**
  - 한글 브랜드명·제품명 Serif treatment 강제, 영문은 italic secondary.
  - **Ingredient-first 정보 위계** — 성분 · 효능 · 임상 결과 · 사용법 순서로 카탈로그. 한국 소비자는 ingredient-focused이므로 가격·할인보다 성분이 상위.
  - 성분 농도 표기 한국식 (`나이아신아마이드 5%` · `히알루론산 1,000ppm`), EWG safety grade 병기.
  - 용량 표기 한국식 (`30ml` · `50g`), price 표기 한국식 (`32,000원` — Mono).
  - Trust signal — 피부과 임상 테스트 · 비건 인증 · EWG green grade · K-DESIGN AWARD · 지디웹 수상 이력 footer/제품 상세에 배치.
  - 매거진·에디토리얼 섹션 필수 — K-beauty 브랜드는 콘텐츠 마케팅이 핵심 (피부 고민별 루틴, 계절별 케어, 성분 스토리).
- 이 Hero Section을 기준으로 전체 사이트의 photographic warmth, ingredient-first 위계, dewy-yet-restrained 톤을 일관되고 의도적으로 확장하라. 동국제약 마데키엘의 derma editorial weight, 멜로우앤코의 typographic restraint, 조선미녀의 한방 prestige를 합쳐 단일 K-beauty 신뢰감으로 통합한다.

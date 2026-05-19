---
name: real-estate-kr
type: design-system-prompt
domain: 한국 부동산 / 분양 마케팅 (아파트, 오피스텔, 신축 단지)
tone: prestigious, cinematic, photographic, brand-name-heavy, traditional Korean luxury
reference: 코오롱 하늘채, 대우건설 블랑써밋, 한양사이버대 (지디웹 수상작), Sotheby's International Realty
---

# Design System Prompt — Korean Real Estate / 분양 Marketing

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용.

첨부된 레퍼런스를 분석하여, 풀-와이드 cinematic Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Korean Real Estate / 분양 마케팅 (아파트 · 오피스텔 · 신축 단지)**이며, 톤은 지디웹 수상작들 — 코오롱 하늘채, 대우건설 블랑써밋 — 같은 한국 럭셔리 분양 사이트의 사진 중심 cinematic 표현과 Sotheby's International Realty의 editorial prestige를 표적으로 한다. 단지명을 brand로 다룰 것 — 작은 logo가 아니라 typographic statement로.

## 1. Design System Definition

브랜드 톤에 따라 2개 variant 중 선택. 두 variant는 mutually exclusive — 같은 사이트 내 혼용 금지.

### Variant A — Dark Cinematic (default for 럭셔리 highrise, night skyline 강조)

- **Background:** `oklch(0.14 0.008 250)` (near-black with subtle cool undertone — pure `#000000` 금지)
- **Text Primary (Headline · 단지명):** `oklch(0.94 0.02 80)` (warm cream — pure `#FFFFFF` 금지, 사진 위에서 cream tone이 따뜻한 prestige 톤 형성)
- **Text Secondary (Body · spec):** `oklch(0.72 0.015 80)` (muted cream)
- **Accent:** `oklch(0.72 0.12 75)` (muted gold — 한국 럭셔리 분양의 전통 시그니처). 대안 `oklch(0.38 0.14 25)` deep wine.

### Variant B — Light Editorial (default for 자연 친화 단지, 주광 photography 강조)

- **Background:** `oklch(0.96 0.012 80)` (warm cream — pure `#FFFFFF` 금지)
- **Text Primary (Headline · 단지명):** `oklch(0.18 0.04 240)` (deep navy — pure `#000000` 금지, navy가 traditional Korean luxury 톤 형성)
- **Text Secondary (Body · spec):** `oklch(0.42 0.03 240)` (muted navy)
- **Accent:** `oklch(0.72 0.12 75)` muted gold 또는 `oklch(0.38 0.14 25)` deep wine.

### 공통 규칙

- Single accent only — 두 accent 동시 사용 금지.
- **Typography:** 3-family system, 한글 typography 강제 우선.
  - **Display Serif (단지명 brand mark):** `Cormorant Garamond` (영문) + `본명조` 또는 `Pretendard Display` (한글). 단지명은 letter-spacing `-0.02em`, weight `400-500` (heavy weight 금지 — refined serif는 light weight가 prestige).
  - **Body Sans:** `Pretendard Variable` — 본문, spec, navigation. 한글 우선 family.
  - **Mono (제한적):** `Pretendard JP` 또는 `Geist Mono` — spec numeric (`84㎡` · `34평형` · `1,247세대`) 표기에 한정.
  - 텍스트 그라데이션 절대 금지.
  - 영문 위주 typography 금지 — 한글 단지명이 primary, 영문은 secondary tagline 한정.
- **Border Radius:** `0` (default) 또는 `4px` (small UI element). Pills · 12px+ rounded corner 금지 — sharp edge가 premium의 시그니처.
- **Shadow:** 없음 또는 매우 미세 (`0 1px 2px rgba(0,0,0,0.04)` only on floating CTA). Background photography가 elevation 역할.
- **Icon Style:** 매우 적게, pictographic 작은 사이즈 (`16px-20px`). Monoline `1px` stroke, accent gold 단색. Lucide Light weight. Icon 의존도 낮음 — text와 photography가 주력.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1920px` 풀-블리드 (full-bleed mandatory — `max-width` cap 금지). 콘텐츠 inner padding `80px` (desktop) / `24px` (mobile).
- **Full-bleed cinematic photography hero:**
  - **Background:** 고해상도 architecture / interior photography (조감도 · 야경 · 로비 · 거실 view 중 1개). Premium photography 강제 — generic stock 금지. Image aspect ratio `21:9` 또는 `16:9` full viewport (`100vh` desktop, `80vh` mobile).
  - **Top overlay (logo + nav):** transparent, hairline bottom border accent gold 10% opacity 또는 없음. Logo (브랜드 + 단지명) 좌측 상단.
  - **Center / lower-left typographic statement:**
    - Eyebrow (Mono uppercase `12px`, tracked `0.12em`, accent gold) — 예: `PRE-LAUNCH · 2026`
    - **단지명 (Display Serif, clamp `64px → 128px`, line-height `1.0`, letter-spacing `-0.02em`)** — heavy typographic treatment, 한글·영문 stacked.
    - Tagline (Body Sans `20-24px`, max 2 lines) — 단지의 가치 제안 1-2줄.
  - **Bottom information row (full-width strip):**
    - 가로 4-column spec — `위치` · `세대수` · `평형` · `분양일정`. 각 cell: label (sans `12px` muted) + value (Display Serif `24px` 또는 Mono `20px`). Hairline divider 분리.
  - **CTA placement (우측 또는 하단 우측 corner):**
    - **Primary:** "관심고객 등록" — accent gold 1px border, transparent background, padding `16px 32px`, no radius (`0`), uppercase Mono `13px` tracked `0.08em`. Hover: background accent gold + dark text.
    - **Secondary tertiary link:** "사이버 모델하우스" — underline only.
- 12-column grid는 inner content에만 적용, hero photography는 full-bleed.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<1024px`에서 단지명 크기 축소, spec row는 2×2 grid로 wrap.
- Hero 하단은 photography에서 다음 섹션의 background로 hard cut 또는 1-2vh subtle vignette만. Fade gradient 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Outline)`: 1px accent gold border, transparent, uppercase Mono text, no radius. Hover: solid accent gold + bg-aware text color.
  - `Tertiary (Link)`: underline accent, text inherit. Hover: opacity `0.7`.
  - Filled solid button은 floating bottom-right "분양 문의" sticky CTA에만 한정 사용.
- **Card:** rare — spec sheet · floor plan thumbnail에만 사용. Background transparent 또는 1-tier darker/lighter than hero bg. 1px hairline accent border. Radius `0`.
- **Badge:** Mono `11px` uppercase tracked `0.12em`. 예: `PREMIUM` · `LIMITED` · `프리미엄 동`. Pill 금지 (`radius: 0`).
- **Nav:** transparent overlay on hero, hairline bottom border on scroll. Logo + 5-6 menu items (단지소개 · 입지 · 평면도 · 커뮤니티 · 분양안내 · 갤러리). Korean serif 또는 sans `15px`.
- **Spec table:** hairline divider 분리, label + value row. 평형 · 면적 · 발코니 · 향 같은 정형 데이터.
- **Animation library:** Framer Motion + GSAP (Ken Burns photography effect 한정).
  - **Hero photography Ken Burns:** on-load only, slow zoom `1.0 → 1.04` over `≤2000ms` ease-out OR slow pan horizontal `≤2000ms`. Loop 금지 — single playback. Marketing hero exception.
  - **Text fade-in:** Hero typography `opacity 0 → 1` + `y: 16px → 0` over `800-1200ms` ease-out (marketing hero exception — 일반 글로벌 `200-300ms` rule을 초과 허용). 단지명 → tagline → spec row → CTA 순 stagger `200ms`.
  - **Scroll-triggered reveal:** spec section, floor plan, 갤러리 section은 viewport enter 시 `y: 24px → 0` + opacity over `600ms` ease-out. 한 번만 트리거.
  - Hover: subtle opacity `0.7` 또는 `1px` underline reveal. Scale · transform 금지 (premium은 가만히 있음).
  - **Banned motion:** 화려한 모션, parallax scroll-jacking, bouncy spring, neon glow pulse, video autoplay with sound, marquee, infinite loop background animation.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(단지 소개 · 입지 · 평면도 · 인테리어 · 커뮤니티 시설 · 분양 안내 · Footer) 및 서브 페이지(평면도 상세 · 사이버 모델하우스 · 분양 문의)는 위 Design System Definition을 엄격히 준수.
- Variant A / B 선택은 프로젝트 단위로 lock — 페이지별 혼용 금지.
- 새로운 색상 · radius scale 추가 · 아이콘 multi-color 사용 금지.
- **Banned patterns (AI real estate cliché — 명시적 배제):**
  - Purple → blue gradient ("modern apartment" cliché)
  - Glassmorphism on info card · floor plan modal
  - 영문 위주 typography (한글 단지명이 secondary 위치로 밀려나는 구조 금지)
  - Neon accent · saturated cyan/magenta · electric blue
  - Playful illustration · cartoon character · 3D animated house icon
  - 화려한 모션 (bounce · spring · overshoot · particle effect)
  - Generic stock photography (Unsplash "modern apartment" cliché) — **premium architectural photography 강제**, 실제 단지 렌더링 또는 photoshoot.
  - 작은 hero (height `<60vh`) — **full-bleed `≥80vh` mandatory**
  - Pill button · rounded card · 16px+ border-radius
  - Emoji · multi-color icon set
  - Gradient text — 특히 단지명 위 (premium 즉시 파괴)
  - Auto-play video with sound · sticky floating chatbot widget · 화면 가리는 modal popup on load
- **Korean luxury 시그널 mandate:**
  - 단지명은 한글 serif + 영문 serif stacked treatment 강제.
  - Spec 표기 한국식 단위 (`㎡` + `평형` 병기, `세대` 사용).
  - 분양 일정은 한국 날짜 표기 (`2026.06 분양예정`).
  - Trust signal — 건설사 logo, 시공순위, GDWEB · K-DESIGN AWARD 수상 이력 footer에 배치.
- 이 Hero Section을 기준으로 전체 사이트의 cinematic tone, photographic weight, typographic prestige를 일관되고 의도적으로 확장하라. 코오롱 하늘채의 단지명 typography, 블랑써밋의 photography weight, Sotheby's의 editorial prestige를 합쳐 단일 한국 럭셔리 분양 신뢰감으로 통합한다.

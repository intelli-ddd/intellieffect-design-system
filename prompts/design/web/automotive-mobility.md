---
name: automotive-mobility
type: design-system-prompt
domain: Automotive / EV / 모빌리티 brand (제조사 brand site, vehicle landing, EV configurator, mobility service)
tone: precision-engineered, dark cinematic, motion-rich, technical, vehicle-centric, configurator-driven, full-bleed photography
reference: 그린카, HM그룹 (지디웹 2026 수상작), 현대자동차, 기아, 제네시스, BMW, Tesla, Rivian, Lucid, Polestar, Porsche, Mercedes-Benz
---

# Design System Prompt — Automotive / EV / Mobility

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/automotive-mobility.md` 로 참조.

첨부된 레퍼런스를 분석하여, 풀-블리드 cinematic Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Automotive / EV / 모빌리티 brand (제조사 brand site, vehicle landing, EV configurator, mobility service)**이며, 톤은 지디웹 2026 수상작 — 그린카, HM그룹 — 의 EV 브랜드 시그니처와 Polestar · Porsche · Genesis 같은 글로벌 OEM의 precision-engineered cinematic 표현을 표적으로 한다. 차량 photography는 sacred — overlay text · blur · filter 일체 금지, vehicle 자체가 hero의 brand statement이다.

## 1. Design System Definition

브랜드 톤에 따라 2개 variant 중 선택. 두 variant는 mutually exclusive — 같은 사이트 내 혼용 금지. Variant 선택 후 brand signature accent 1개만 commit.

### Variant A — Dark Cinematic (default for EV · sport · premium · night-shot photography)

- **Background:** `oklch(0.10 0.004 250)` (near-black canvas with subtle cool tint — pure `#000000` 절대 금지, slight cool undertone이 차량 photography의 depth를 살린다)
- **Surface elevation tier 1:** `oklch(0.14 0.004 250)` (spec card · configurator panel background)
- **Surface elevation tier 2:** `oklch(0.18 0.005 250)` (modal · dropdown · floating UI)
- **Text Primary (Headline · vehicle name):** `oklch(0.97 0.004 250)` (near-white — pure `#FFFFFF` 금지)
- **Text Secondary (Body · description):** `oklch(0.72 0.008 250)` (muted gray)
- **Text Tertiary (spec label · caption):** `oklch(0.50 0.012 250)` (low-contrast spec label)

### Variant B — Light Premium (default for BMW i 톤 · daylight studio shot · luxury sedan)

- **Background:** `oklch(0.97 0.004 250)` (near-white with subtle cool tint — pure `#FFFFFF` 금지)
- **Surface elevation tier 1:** `oklch(0.94 0.005 250)` (spec card background)
- **Surface elevation tier 2:** `oklch(0.90 0.006 250)` (modal · floating)
- **Text Primary:** `oklch(0.14 0.004 250)` (near-black — pure `#000000` 금지)
- **Text Secondary:** `oklch(0.40 0.008 250)`
- **Text Tertiary:** `oklch(0.58 0.010 250)`

### Accent — brand signature 1개만 lock (mutually exclusive, purple/violet 절대 금지)

브랜드 시그니처를 따라 아래 5개 중 1개만 선택. 다중 accent · saturated rainbow gradient 금지.

- `oklch(0.72 0.18 142)` **electric green** — EV brand signature, 그린카 / Polestar (EV 라인)
- `oklch(0.68 0.20 245)` **electric blue** — Polestar / BMW i / 미래 모빌리티
- `oklch(0.62 0.22 18)` **Tesla red** — sport · performance · 한국 hyundai N
- `oklch(0.78 0.04 60)` **warm gold** — Genesis premium · luxury sedan
- `oklch(0.85 0.02 240)` **cool silver** — BMW i · daylight studio · understated tech

### 공통 규칙

- **Typography:** 3-family system, 한글·영문 stacked treatment 강제.
  - **Display (vehicle name · brand statement):** Condensed grotesk — `Söhne Schmal` / `Inter Display` / `Geist Display` (영문) + `Pretendard Display` (한글). Weight `400-500` (premium 톤 — heavy weight 금지, refined light가 prestige). Letter-spacing `-0.025em`. Sport / performance variant는 `weight 700+` 허용. clamp `48px → 112px`.
  - **Body Sans:** `Inter` / `Pretendard Variable` — description · navigation · UI body. Weight `400` body, `500` emphasis.
  - **Mono (mandatory for spec):** `Berkeley Mono` / `Geist Mono` / `JetBrains Mono`. 모든 numeric spec (`0-100km/h`, `kWh`, `kW`, `km` range, `mm` dimension, `kg` weight, `₩` price, `€` price)에 강제. **Tabular-nums 강제 (`font-variant-numeric: tabular-nums`)** — non-tabular는 reject 사유.
  - 텍스트 그라데이션 절대 금지.
  - 영문 위주 typography 금지 — 한글 모델명 / 브랜드명이 primary, 영문은 stacked secondary.
- **Border Radius:** `0px` (default — precision engineering) 또는 `4px` (small UI element). EV configurator UI · friendly mobility service에 한해 `8-12px` 허용. **16px 이상 절대 금지.** Pill button 금지.
- **Shadow:** dark theme 기준 거의 무용 — surface elevation tier로 분리. Vehicle photography card에만 ambient `0 24px 64px rgba(0,0,0,0.4)` 허용. UI shadow 일반 사용 금지.
- **Icon Style:** monoline `1.5px` stroke, 단색 (text primary 또는 accent). 차량 component icon (engine · battery · drivetrain · charging port · ADAS sensor)은 SVG line drawing precision. Lucide / Tabler 권장. **3D rendered icon · isometric illustration · gradient icon 절대 금지.**

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1920px` 풀-블리드 (full-bleed mandatory — `max-width` cap 금지). Inner content padding `80px` (desktop) / `24px` (mobile).
- **Full-bleed vehicle photography 또는 cinematic video loop:**
  - **Background:** 고해상도 branded vehicle photography 또는 cinematic video loop (`autoplay` `muted` `loop`, 30sec loop, no sound). Aspect ratio `16:9` 또는 `21:9`, full viewport (`100vh` desktop, `85vh` mobile).
  - **Photography 강제 — branded photoshoot only.** Generic stock automotive · Unsplash "EV car" cliché 금지. 실제 차량 렌더링 또는 brand photoshoot.
  - **Vehicle photo는 sacred** — overlay text · blur · filter · lens flare · sun glare 일체 금지. Hero text는 vehicle 위가 아닌 **별도 영역 (좌측 lower / 우측 lower / bottom strip)** 에 배치.
- **Top transparent nav:**
  - Logo (브랜드 + 모델 라인업) 좌측. Center 또는 right에 menu: `모델` · `설계` · `EV` · `시승` · `구매` (5-6 items max). 한글 + 영문 toggle 우상단.
  - Background `transparent`, scroll 시 `oklch(0.10 0.004 250 / 0.85)` backdrop-blur 12px로 변환. Hairline bottom border accent 10% opacity 또는 없음.
- **Center 또는 하단 left typographic statement:**
  - **Eyebrow (Mono uppercase `12px`, tracked `0.12em`, accent color):** 예 `ALL-ELECTRIC · 2026 MODEL` 또는 `LIMITED EDITION · 999 UNITS`. 한국어 변형 `사전계약 · 2026.06 출시예정`.
  - **Vehicle name (Display, clamp `64px → 112px`, line-height `1.0`, letter-spacing `-0.025em`)** — 한글 모델명 + 영문 stacked. 예:
    - `제네시스 GV80 Coupe` / `Genesis GV80 Coupe`
    - `그린카 RANGE-X` / `GREENCAR RANGE-X`
  - **Tagline (Body Sans `18-22px`, max 2 lines)** — 차량의 핵심 가치 제안 1-2줄. `weight 400`.
- **Bottom 4-column spec strip (full-width, bottom of hero or directly under):**
  - 가로 4-cell — `출력` · `0-100km/h` · `주행거리` · `가격`. 각 cell:
    - Label (Body Sans `12px` uppercase tracked `0.08em`, text tertiary)
    - Value (**Mono tabular-nums** `24-32px`, text primary). 예:
      - `출력` → `350 kW · 470 hp`
      - `0-100km/h` → `3.4 s`
      - `주행거리` → `512 km WLTP`
      - `가격` → `from ₩ 89,000,000`
  - Hairline `1px` vertical divider 분리 (accent 10% opacity 또는 text tertiary).
- **CTA placement (우측 lower 또는 별도 strip 우측):**
  - **Primary:** `Configure` / `시승 신청` — accent fill solid 또는 solid white-on-dark. Padding `16px 32px`, radius `0` (또는 configurator UI에선 `8px`). Uppercase Mono `13px` tracked `0.06em`. Hover: opacity `0.85` + accent border glow `1px`.
  - **Secondary (Ghost):** `기술 사양` / `Specs` — `1px` outline text primary, transparent background. Hover: background `oklch(0.97 0.004 250 / 0.08)`.
  - **Tertiary (Link):** `Compare models` — underline only, text secondary. Hover: text primary.
- 12-column grid는 inner content (spec strip · CTA cluster) 에만 적용, vehicle photography는 full-bleed.
- 모든 요소는 **Auto Layout** (CSS Grid + Flexbox) 기반. 반응형: `<1024px`에서 vehicle name `clamp 40px → 56px` 축소, spec strip은 `2×2 grid`로 wrap, CTA는 `full-width stacked`.
- Hero 하단은 photography에서 다음 섹션으로 hard cut. Fade gradient overlay 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Filled)`: accent color background 또는 solid `text primary` background + opposite `text` color. Padding `16px 32px`, radius `0` (default) 또는 `8px` (configurator). Uppercase Mono `13px` tracked `0.06em`. Hover: opacity `0.85`, instant `120ms ease-out` (precision은 tight motion).
  - `Secondary (Ghost / Outline)`: `1px` outline text primary, transparent background. Hover: background `text primary / 0.08`.
  - `Tertiary (Link)`: underline accent, text inherit. Hover: text primary opacity `0.7`.
  - **Bouncy spring · overshoot · scale transform 절대 금지** — precision engineering 톤은 instant tight motion만 허용.
- **Card (spec card · configurator option card):** background surface tier 1, `1px` hairline border (accent 12% opacity 또는 surface tier 2). Radius `0-8px` (configurator UI 한정 12px 허용). Padding `24px-32px`. Shadow 없음.
- **Configurator UI 패턴:**
  - **좌측 (60% width):** vehicle preview — high-res photo 또는 short looped video (3D rotating preview 금지 — early-2010s skeuomorph cliché). Color · wheel · interior change 시 cross-fade `200ms ease-out`로 photo swap.
  - **우측 (40% width):** step-by-step option selector — `Color → Wheels → Interior → Tech Package → Summary`. Step indicator (Mono uppercase tracked) 상단 고정. 각 step은 option grid (2-3 column) + selected state는 accent `1px` border + accent text label.
  - Step transition: `y: 16px → 0` + opacity `300ms ease-out`. Swipe 또는 scroll 금지 — 명시적 `Next` / `Back` button.
  - Summary step 하단에 spec table (Mono tabular-nums) + total price (Mono `32-40px`) + `Reserve` CTA.
- **Badge:** Mono `11px` uppercase tracked `0.12em`. 예 `NEW` · `LIMITED` · `EV` · `사전계약`. Background accent solid 또는 outline. Pill 금지 (`radius: 0-4px`).
- **Nav:** transparent overlay → scroll 시 backdrop-blur. Logo + 5-6 menu items. Active state는 accent underline `1px` 또는 accent dot indicator.
- **Spec table:** hairline `1px` divider 분리, label (Sans secondary) + value (Mono tabular-nums primary) row. 차량 spec 정형 데이터 (`배터리 용량` · `최대출력` · `최대토크` · `1회 충전 주행거리` · `급속충전 시간`).
- **다국어 toggle 필수:** 한국어 · 영어 (글로벌 OEM은 + 독일어 · 일본어 · 중국어). 우상단 nav에 dropdown 또는 inline link.
- **Animation library:** Framer Motion (UI · scroll-reveal) + GSAP (Hero Ken Burns · 고급 timeline).
  - **Hero vehicle photo Ken Burns:** on-load only, slow zoom `1.0 → 1.04` over `≤2000ms ease-out` 또는 slow pan `≤2000ms`. **Single playback, loop 금지.** Video loop은 30sec seamless loop 허용 (sound 없음).
  - **Hero text stagger:** Eyebrow → Vehicle name → Tagline → Spec strip → CTA 순 `200ms` stagger, 각 `opacity 0 → 1` + `y: 16px → 0` over `800ms ease-out`. Marketing hero exception — 일반 글로벌 `200-300ms` rule을 초과 허용.
  - **Scroll-triggered reveal:** spec section · model lineup · charging network 등 viewport enter 시 `y: 24px → 0` + opacity `600ms ease-out`. 한 번만 트리거.
  - **Configurator color / wheel switch:** photo cross-fade `200ms ease-out`. Discrete swap, dissolve transition.
  - **Hover:** opacity `0.85` 또는 accent underline reveal. Scale transform · spring overshoot · particle effect 금지.
  - **Reduced-motion 존중:** `prefers-reduced-motion: reduce` 시 Ken Burns · video loop · scroll-reveal 비활성, 즉시 final state.
  - **Banned motion:** bouncy spring, parallax scroll-jacking, 3D rotating vehicle preview, particle / sparkle effect (EV charging visualization 포함), neon glow pulse, lens flare overlay, auto-rotate carousel without user control, marquee, infinite background animation.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션 (Hero · Model lineup · Configurator · Charging network · Test drive · Service · Dealership · About · News · Investor relations) 및 모든 서브 페이지는 위 Design System Definition을 엄격히 준수.
- Variant A / B 선택은 프로젝트 단위로 lock — 페이지별 혼용 금지.
- Brand signature accent는 1개만 commit — 다중 accent · saturated rainbow 금지.
- 새로운 색상 · radius scale 추가 · 아이콘 multi-color 사용 금지.
- **Vehicle photo는 sacred** — overlay text · blur · filter · lens flare · sun glare 일체 금지. Hero text는 vehicle 위가 아닌 별도 영역에.
- **Mono tabular-nums는 모든 spec / price / measurement에 강제** — non-tabular는 reject 사유. (`출력` · `토크` · `주행거리` · `충전시간` · `0-100km/h` · `최고속도` · `가격` · `dimension` · `weight` · `세대수` · `생산량`)
- **Configurator UI 패턴 강제:** 좌측 vehicle preview + 우측 step-by-step option selector. Step indicator Mono caps. Cross-fade transition only.
- **다국어 toggle 필수:** 한국어 + 영어 baseline, 글로벌 OEM은 + 독일어 / 일본어 / 중국어.
- **Banned patterns (AI automotive cliché — 명시적 배제):**
  - Purple → blue rainbow gradient ("futuristic EV" AI cliché)
  - Glassmorphism on spec card · configurator panel
  - 3D rotating vehicle preview (early-2010s skeuomorph cliché) — photo carousel 또는 short looped video로 대체
  - Bouncy spring · overshoot · scale transform on UI hover (precision engineering은 instant tight motion)
  - Generic stock automotive photo (Unsplash "EV car" cliché) — branded photoshoot only
  - Lens flare · sun glare overlay filter on vehicle photography
  - "Race now!" · "Limited stock!" · "마지막 기회!" high-pressure copy
  - Stock illustration of "happy driver" smiling at camera — actual driver portrait 또는 cabin interior shot
  - Carousel auto-rotate without user control
  - Rounded card 12px 이상 (precision은 sharp edge `0-8px`)
  - 다중 saturated accent (single brand hue lock)
  - Particle · sparkle · electric arc effect on EV charging visualization
  - Non-tabular nums on spec (모든 numeric은 Mono tabular)
  - Neon glow · pulse · animated gradient background
  - Auto-play video with sound · sticky chatbot widget · 화면 가리는 modal popup on load
  - Emoji · multi-color icon set · 3D rendered icon · isometric illustration
  - Cartoon character · playful illustration · animated EV car icon
  - 영문 위주 typography (한글 모델명이 secondary 위치로 밀려나는 구조)
  - Heavy weight serif on vehicle name (condensed grotesk 강제)
  - Gradient text — 특히 vehicle name 위 (premium 즉시 파괴)
- **Precision engineering 시그널 mandate:**
  - 모든 spec은 Mono tabular-nums + 정확한 단위 표기 (`kW` · `kWh` · `Nm` · `km` · `km/h` · `mm` · `kg` · `s` · `WLTP` · `EPA`).
  - 차량 dimension은 한국식 + 글로벌 단위 병기 (`전장 4,945mm` · `Length 4,945mm`).
  - 가격은 통화 기호 + tabular-nums (`₩ 89,000,000` 또는 `from ₩ 89M`).
  - Trust signal — 안전 등급 (`KNCAP 5-star` · `Euro NCAP 5-star`), 시상 이력 (`World Car of the Year 2026` · `iF Design Award`), 인증 (`UL Listed` · `KC 인증`) footer에 배치.
  - 출시일정 한국식 표기 (`2026.06 사전계약` · `2026.09 출고`).
- 이 Hero Section을 기준으로 전체 사이트의 dark cinematic precision, motion-rich vehicle photography, technical mono spec treatment를 일관되고 의도적으로 확장하라. 그린카 / HM그룹의 EV brand signature, Polestar의 minimalist precision, Genesis의 typographic prestige, Porsche의 spec discipline을 합쳐 단일 automotive brand 신뢰감으로 통합한다.

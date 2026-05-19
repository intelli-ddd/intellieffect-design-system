---
name: museum-cultural
type: design-system-prompt
domain: Museum / 디지털 역사관 / corporate anniversary marketing / cultural institution (박물관 · 미술관 · 기업 100주년 디지털 archive · 전시 공간)
tone: archival editorial, generous whitespace, photographic history, restrained typographic prestige, chronological narrative, institutional gravitas
reference: 퐁피두센터 한화, 대구대학교 70주년 디지털 역사관, SP삼화 100년 동행 뮤지엄 (지디웹 2026 수상작), 국립중앙박물관, MMCA, 리움미술관, Smithsonian Digital, V&A Online
---

# Design System Prompt — Museum / Cultural Institution / Anniversary Archive

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/web/museum-cultural.md` 로 참조.

첨부된 레퍼런스를 분석하여, 풀-블리드 archival editorial Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Museum / 디지털 역사관 / corporate anniversary marketing / cultural institution (박물관 · 미술관 · 기업 100주년 디지털 archive · 전시 공간)**이며, 톤은 지디웹 2026 수상작 — 퐁피두센터 한화 · 대구대학교 70주년 디지털 역사관 · SP삼화 100년 동행 뮤지엄 — 같은 institutional archive의 chronological narrative와 V&A · Smithsonian · MMCA · 리움미술관의 editorial prestige를 표적으로 한다. Anniversary 컨텍스트는 timeline-driven 정보 위계를 강제 — artifact · document · photograph가 모두 archival metadata와 함께 등장.

## 1. Design System Definition

브랜드 톤에 따라 2개 variant 중 선택. 두 variant는 mutually exclusive — 같은 사이트 내 혼용 금지. Anniversary 사이트는 Variant A default, 미술관 gallery night-mode는 Variant B.

### Variant A — Paper Cream (default for anniversary archive · 박물관 day-mode · 기업 디지털 역사관)

- **Background:** `oklch(0.96 0.014 80)` (warm paper cream — pure `#FFFFFF` 절대 금지. archival paper 톤이 institutional gravitas 형성)
- **Text Primary (Headline):** `oklch(0.18 0.012 80)` (deep ink — pure `#000000` 금지, ink-on-paper feel)
- **Text Secondary (Body):** `oklch(0.42 0.014 80)` (muted ink)
- **Accent:** 하나 commit (mutually exclusive):
  - `oklch(0.55 0.10 25)` deep terracotta (archival warmth, 한국 박물관 친화)
  - `oklch(0.42 0.08 240)` ink navy (institutional gravitas)
  - `oklch(0.45 0.06 80)` archival ochre (vintage document feel)

### Variant B — Gallery Night (default for 미술관 contemporary · 디지털 전시 공간)

- **Background:** `oklch(0.15 0.008 240)` (near-black with subtle cool undertone — pure `#000000` 금지)
- **Text Primary (Headline):** `oklch(0.94 0.02 80)` (warm cream — pure `#FFFFFF` 금지)
- **Text Secondary (Body):** `oklch(0.72 0.015 80)` (muted cream)
- **Accent:** Variant A 의 3개 hue 중 하나, 단 saturation `+0.02` 보정 — 어두운 배경에서도 muted 유지.

### 공통 규칙

- Single hue lock — 두 accent 동시 사용 절대 금지. **Purple · violet · electric blue · cyan 금지** (modern museum AI cliché).
- **Typography:** 3-family system, **한글 우선** (국내 박물관 · 한국 기업 anniversary 컨텍스트).
  - **Display Serif (institutional headline · 전시명):** `Cormorant Garamond` 또는 `Tiempos` (영문) + `본명조` 또는 `Pretendard Display` (한글). Weight `400-500` (museum gravitas는 light weight serif가 핵심 — heavy weight 금지). letter-spacing `-0.015em`, line-height `1.05`.
  - **Serif Body (editorial reading):** `Iowan Old Style` 또는 `본명조` body weight — 본문 · 큐레이터 노트 · provenance 설명. Sans-serif body 금지 (museum은 editorial reading 톤).
  - **Mono (caption · metadata 필수):** `Geist Mono` 또는 `JetBrains Mono` — artifact number · accession · year · vol number 표기 (`EST. 1924` · `VOL. III` · `ACC. 2026.103`). Mono uppercase tracked `0.12em`.
  - 텍스트 그라데이션 절대 금지.
  - 영문 위주 typography 금지 — 한글 전시명 · 기관명이 primary, 영문은 archival caption secondary.
- **Border Radius:** `0` (default · institutional sharp edge). Pills · rounded card (`12px+`) 금지 — sharp edge가 archival prestige의 시그니처.
- **Shadow:** 거의 없음. Hairline `1px` border가 elevation 대체. Hero photography만 ambient `0 12px 32px rgba(0,0,0,0.06)`. Drop shadow는 institutional 톤에 어울리지 않음.
- **Icon Style:** 단색 monoline `1px` stroke. 또는 SVG pictograph (artifact line drawing · 등사판 질감 · woodblock-style) 우선. Lucide Thin weight. Icon 의존도 매우 낮음 — typography와 photography가 주력.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1920px` 풀-블리드 (full-bleed mandatory — `max-width` cap 금지). 콘텐츠 inner padding `96px` (desktop) / `24px` (mobile).
- **Hero 구성 — 2개 patterns 중 선택:**
  - **Pattern A (Photography-led):** Full-bleed institutional photography (artifact close-up · gallery space · archival document · facility exterior). Aspect ratio `21:9` 또는 `16:9`. Photography 위 typographic overlay (lower-left 또는 centered).
  - **Pattern B (Artifact-led):** Single artifact still-life center placement + 좌우 generous whitespace (`min 25% each side`). Typographic statement는 artifact 하단 또는 좌측 caption block.
- **Top masthead (full-width strip):**
  - Institution name 한글 + 영문 stacked (Display Serif `20px`) 좌측.
  - 우측: archival caption Mono uppercase `12px` tracked `0.12em` — 예 `EST. 1924 · VOL. III` · `ANNIVERSARY 1924-2024` · `SPECIAL EXHIBITION 2026`.
  - Hairline `1px` bottom border accent 20% opacity.
- **Hero typographic statement:**
  - **Eyebrow (Mono uppercase `12px`, tracked `0.12em`, accent color)** — 예 `ANNIVERSARY · 100 YEARS OF LIGHT` · `SPECIAL EXHIBITION · 2026.07-2026.12` · `PERMANENT COLLECTION · GALLERY II`.
  - **Headline 한글 (Display Serif weight 400-500, clamp `60px → 128px`, line-height `1.0`, letter-spacing `-0.02em`)** — 영문 italic secondary stacked. 전시명 · 기관명이 primary typographic statement.
  - **Sub (Serif Body `18-22px`, max 3 lines)** — 전시 · archive institutional voice 1-3줄. 큐레이터적 톤.
- **Bottom information row (full-width strip):**
  - 4-col hairline divider strip — `기간` · `위치` · `큐레이터` · `입장료`. 각 cell: label (Mono uppercase `11px` muted) + value (Serif Body `15px` 또는 Mono `14px`). Hairline `1px` accent 20% opacity divider 분리.
- **CTA placement (하단 우측 또는 hero bottom strip):**
  - **Primary:** "관람 예약" 또는 "전시 둘러보기" — outline accent 1px border, transparent background, padding `18px 36px`, radius `0`, uppercase Mono `13px` tracked `0.08em`. Hover: accent solid + bg-aware text color.
  - **Tertiary (Link):** "Read the catalogue" 또는 "도록 다운로드" — accent underline only, Mono `12px`.
- 12-column grid는 inner content에만 적용. Hero photography는 full-bleed.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<1024px`에서 typography clamp 축소, info row는 2×2 grid wrap. Pattern B에서는 artifact가 상단 centered, caption block 하단.
- Hero 하단은 hard cut 또는 1-2vh subtle vignette만. Fade gradient · soft transition 금지 (institutional은 sharp section break).

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Outline)`: 1px accent border, transparent, uppercase Mono text, no radius. Hover: solid accent + bg-aware text color.
  - `Tertiary (Link)`: accent underline, no padding. Hover: opacity `0.7`.
  - Filled solid button은 사용 자제 — institutional voice는 outline이 default.
- **Card:** rare — collection grid · exhibition list에만 사용. Background transparent 또는 1-tier darker/lighter than hero bg. Hairline `1px` accent border. Radius `0`. Padding `32px`.
- **Badge:** Mono `11px` uppercase tracked `0.12em`. 예 `PERMANENT` · `SPECIAL` · `2026 NEW ACQUISITION` · `상설전시`. Radius `0`, transparent bg + 1px accent border. Pill 금지.
- **Nav:** transparent overlay on hero, hairline bottom border on scroll. Logo + 6-8 menu items (소장품 · 전시 · 교육 · 관람안내 · 소개 · 출판 · Press · 다국어 toggle). Display Serif 또는 Mono `14px` uppercase tracked.
- **Image archive grid:** 의도된 asymmetry — artifact 크기에 따라 다양한 cell size (small `4-col span` · medium `6-col span` · large full-width). Hairline border separator. Metadata caption 하단 (Mono uppercase artifact number + Serif Body title + year).
- **Timeline component (anniversary 컨텍스트 mandatory):** chronological narrative가 정보 위계 1순위. Vertical 또는 horizontal scroll timeline, year markers Mono `14px` accent, milestone description Serif Body. 각 milestone에 archival photograph + caption + provenance.
- **Multi-language toggle (mandatory):** 한국어 · 영어 default, 박물관이면 + 일본어 · 중국어 옵션. Mono `12px` uppercase tracked `0.12em`, 좌측 또는 우측 nav 끝.
- **Animation library:** Framer Motion + GSAP (View Transitions API for page navigation in 디지털 archive 컨텍스트).
  - **Hero entrance:** typography staggered reveal — masthead → eyebrow → headline → sub → info row → CTA 순 `150ms` stagger, `opacity 0 → 1` + `y: 12px → 0` over `800-1200ms` ease-out (marketing hero exception — 일반 글로벌 `200-300ms` rule 초과 허용). Photography는 `opacity 0 → 1` over `1200ms` ease-out, no scale (institutional은 정적).
  - **Hover:** subtle opacity `0.7` 또는 hairline border emphasis. Scale · transform · spring 금지 (museum은 가만히 있음).
  - **Scroll-triggered reveal:** section enter 시 `opacity 0 → 1` + `y: 20px → 0` over `700ms` ease-out, once-only. Timeline milestone은 individual stagger.
  - **Artifact zoom (collection page 한정):** click → full-screen lightbox with Ken Burns-style slow zoom `1.0 → 1.06` over `≤2000ms` ease-out. Single playback, no loop.
  - **Banned motion:** carousel auto-rotate, marquee scrolling text, parallax scroll-jacking, neon glow pulse, video autoplay with sound, bouncy spring, infinite loop background animation, sparkle/glow on featured artifact, 3D rotating artifact preview (cheap skeuomorph).

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Hero · Collection · Exhibition · Education · Visit info · About · Press · Footer) 및 서브 페이지(소장품 상세 · 전시 상세 · 도록 · 관람 예약 · 다국어 페이지)는 위 Design System Definition을 엄격히 준수.
- Variant A / B 선택은 프로젝트 단위로 lock — 페이지별 혼용 금지.
- 새로운 색상 · 추가 accent · 다른 radius scale · multi-color icon 임의 추가 금지.
- **Banned patterns (AI museum cliché — 명시적 배제):**
  - AI-generic "modern museum" purple-blue gradient (institutional prestige 즉시 파괴)
  - Glassmorphism on artifact card · exhibition modal (artifact는 sacred — clear typography 우선)
  - Stock photography of "art-loving diverse visitor" cliché — 실제 collection · facility · curator portrait 우선
  - Carousel auto-rotate (museum은 정적, viewer-controlled navigation 강제)
  - 3D rotating artifact preview · spinning gallery view (cheap skeuomorph)
  - Sparkle · glow effect on featured artifact (lab-tech sci-fi aesthetic 금지)
  - "Buy ticket now!" 빨간 CTA · high-pressure conversion copy — institutional voice는 "관람 예약" · "Visit" · "Reserve"
  - Modal popup on entry asking newsletter signup (institutional dignity 파괴)
  - Marquee scrolling text strip · ticker tape effect
  - Rounded card `12px+` border-radius (institutional은 sharp edge `0` only)
  - 다중 saturated accent (single muted accent lock)
  - Pure `#FFFFFF` background · pure `#000000` text (paper cream + ink가 institutional 시그니처)
  - Emoji · cartoon mascot · playful illustration
  - Gradient text — 특히 전시명 · 기관명 위 (즉시 prestige 파괴)
  - Auto-play video with sound · sticky floating chatbot widget
- **Institutional archive 시그널 mandate:**
  - Anniversary 컨텍스트 시 timeline-driven layout 강제 — chronological narrative가 정보 위계 1순위, hero 또는 second section에 timeline 배치.
  - Image archive grid는 의도된 asymmetry — artifact 크기에 따라 다양한 cell size (uniform grid 금지).
  - 다국어 toggle 필수 (한국어 · 영어, 박물관이면 + 일본어/중국어).
  - Curator notes · provenance · accession number · year · medium 같은 archival metadata 박을 위치 reserve — collection 상세 페이지에서 mandatory.
  - Footer에 기관 logo · 설립일 · 사업자등록번호 · 후원사 · 학술 협력 · ICOM/AAM 같은 박물관 협회 인증 · 다국어 사이트 link · 접근성 statement 배치.
  - Anniversary 사이트는 founder · key milestone · 시대 구분 chapters 강제.
- 이 Hero Section을 기준으로 전체 사이트의 archival editorial tone, photographic history weight, restrained typographic prestige를 일관되고 의도적으로 확장하라. 퐁피두센터 한화의 institutional gravitas, 대구대 70주년의 chronological narrative, SP삼화 100년의 anniversary timeline 깊이, V&A의 collection metadata 위계를 합쳐 단일 한국 cultural institution archive 톤으로 통합한다.

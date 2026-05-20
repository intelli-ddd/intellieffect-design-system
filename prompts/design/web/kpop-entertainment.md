---
name: kpop-entertainment
type: design-system-prompt
domain: K-pop entertainment company / artist platform / fan engagement (소속사 brand site, artist landing, album release campaign, fan community)
tone: bold cinematic, dark theme default, vivid single accent, motion-rich, photography·video heavy, fan-driven UX
reference: HYBE, SM Entertainment, YG, JYP, Weverse, 빅히트뮤직 (지디웹 2026 수상작), Antenna, SOURCE MUSIC
---

# Design System Prompt — K-pop Entertainment / Artist Platform

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/kpop-entertainment.md` 로 참조.

첨부된 레퍼런스를 분석하여, K-pop entertainment의 cinematic dark-theme Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **K-pop Entertainment Company / Artist Platform / Album Release Campaign / Fan Community**이며, 톤은 HYBE의 corporate cinematic, SM의 visual maximalism, Weverse의 fan UX, 빅히트뮤직 (지디웹 2026 수상작)의 editorial bold treatment를 표적으로 한다. 아티스트·앨범 아트가 sacred — typography·overlay·filter로 가리지 말 것. 한글 + 영문 stacked treatment 강제 (한국어 아티스트명 primary, 영문 romanization secondary 또는 대등).

## 1. Design System Definition

- **Primary Color (Background):** `oklch(0.08 0.004 250)` (near-black canvas with slight cool tint — pure `#000000` 금지). Surface elevation tier `oklch(0.12 0.005 250)` (card · modal), `oklch(0.16 0.006 250)` (popover · dropdown).
- **Accent Color:** artist 또는 album campaign 전용 color — **하나만** commit. 선택지:
  - `oklch(0.72 0.22 18)` vivid coral (default for energetic comeback)
  - `oklch(0.78 0.18 142)` electric mint (fresh debut · summer campaign)
  - `oklch(0.65 0.24 280)` royal violet (artist signature color로 명시된 경우 한정)
  - `oklch(0.82 0.18 65)` golden amber (anniversary · ballad release)
  - **Artist 자체의 signature color**가 있으면 그것을 따라가는 게 옳음 — 위 palette는 fallback.
- **Text Color:** `oklch(0.97 0.004 250)` (near-white heading — pure `#FFFFFF` 금지), `oklch(0.72 0.008 250)` (body), `oklch(0.50 0.012 250)` (tertiary · caption · meta).
- **Typography:** 3-family system, 한글 + 영문 stacked.
  - **Display (아티스트명 · 앨범명 statement):** `Pretendard Display` / `Apple SD Gothic Neo` Heavy (한글) + `Inter Display` / `Neue Haas Grotesk Display` (영문). Weight `700-800` 허용 — editorial과 차별되는 **heavy treatment**가 K-pop 시그니처. Letter-spacing `-0.03em` for large display.
  - **Body Sans:** `Pretendard Variable` (한글 우선) + `Inter` (영문). Weight `400-500`.
  - **Mono (numeric · meta · tag):** `Geist Mono` / `JetBrains Mono` — release date, track number, duration, comeback countdown 표기 한정.
  - 한글 아티스트명 primary, 영문 romanization secondary 또는 대등 stacked. 영문 위주 typography 금지.
  - 텍스트 그라데이션 금지 — 단, accent color flat fill on display heading은 허용 (album campaign color로 한정).
- **Border Radius:** `0` 또는 `4px` (sharp edge for music album cover ratio). **Album/poster art는 정사각 `0` radius** — album art는 sacred geometry. Button · badge · chip 한정 `4-8px` 허용. Pill · 16px+ rounded 금지.
- **Shadow:** dark theme이라 거의 무용. Surface elevation으로 분리 (위 tier 참조). Album art ambient `0 4px 12px rgba(0,0,0,0.5)` 한정 — album cover floating 시.
- **Icon Style:** filled high-contrast (Lucide Solid · Phosphor Fill). Play / pause / skip / heart / share — accent color when active, near-white when idle. 16-24px. Outline icon은 secondary nav 한정.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1920px` 풀-블리드 mandatory (`max-width` cap 금지). Inner content padding `64px` desktop / `24px` mobile.
- **Full-bleed cinematic media hero:**
  - **Background:** full-bleed artist photography 또는 group photo (`21:9` 또는 `16:9`, `100vh` desktop / `85vh` mobile). 실제 branded photoshoot 또는 album art — generic stock 금지. Subtle dark gradient overlay (`oklch(0.08 0.004 250)` from bottom, opacity `0 → 0.5`) for typography legibility only — 아티스트 얼굴 가리지 말 것.
  - **Top nav (transparent overlay):** 좌측 소속사 logo + 우측 5-7 menu (Sans `14-15px`, 한글 우선: 아티스트 · 디스코그래피 · 스케줄 · 커뮤니티 · 샵 · 매거진 · 회사소개). Hairline bottom border `oklch(0.97 0.004 250 / 0.08)` on scroll. Multi-language toggle (한국어 · 영어 · 일본어 최소).
  - **Center 또는 lower-left typographic statement:**
    - Eyebrow (Mono uppercase `12-13px`, tracked `0.12em`, accent color) — 예: `COMEBACK · 2026.06.04` · `1ST FULL ALBUM` · `DEBUT SHOWCASE`.
    - **아티스트명 / 앨범명 (Display Heavy, clamp `72px → 144px`, line-height `0.95`, letter-spacing `-0.03em`)** — heavy weight treatment, 한글·영문 stacked (한글 primary line + 영문 sub line, 또는 대등 horizontal stack).
    - Tagline (Body Sans `18-22px`, max 2 lines) — 앨범 컨셉 1줄.
  - **Bottom info strip (full-width):** 가로 3-4 column — `LATEST SINGLE` (track title + duration mono) · `UPCOMING CONCERT` (venue + date) · `OFFICIAL MV` (YouTube link → arrow). Each cell: Mono caps label `11px` tracked + Sans value. Hairline divider `oklch(0.97 0.004 250 / 0.12)`.
  - **CTA placement (lower-right 또는 center-bottom):**
    - **Primary:** "LISTEN NOW" / "들으러 가기" — accent color fill, padding `16px 32px`, radius `4px`, Sans `15px` medium uppercase tracked `0.04em`. Hover: opacity `0.85`, no transform.
    - **Secondary (Ghost):** "TOUR SCHEDULE" / "공연 일정" — 1px near-white border `oklch(0.97 0.004 250 / 0.3)`, transparent background, near-white text. Hover: border opacity `1.0`, background `oklch(0.97 0.004 250 / 0.05)`.
- 12-column grid는 inner content 한정, hero media는 full-bleed.
- 모든 요소 **Auto Layout** / CSS Grid 기반. 반응형 `<1024px`: 아티스트명 크기 축소, info strip 2×2 grid wrap.
- Hero 하단은 dark canvas로 hard cut. Subtle vignette `1-2vh` 만 허용. Fade gradient 금지.

## 3. UI Elements & Animation

### 🔴 MUST USE — distinct K-pop motion signature (v1.9.2)

**중요**: agency-portfolio 의 motion 패턴 (Magnetic CTA / DrawSVG / anime.js morph / SplitText chars 30ms all-at-once / ScrollTrigger pin+scrub fade) 을 그대로 복제하면 **fail**. K-pop 은 cinematic immersion + horizontal flow + 3D depth + countdown ticker 의 distinct signature 가 본질.

**Required motion snippets (의무):**

| Snippet | 적용 위치 | 필수도 |
|---|---|---|
| #2 GSAP register | 모든 motion 컴포넌트 상단 import + registerPlugin + CustomEase("brand") | **MANDATORY** |
| #15 Ken Burns slow zoom | hero photographic single zoom 1.0→1.05 over 2s (single play, no loop) | **MANDATORY** — hero signature |
| #16 Horizontal scroll carousel | discography section 4-6 album cards 가로 스크롤 (pin + horizontal translate) | **MANDATORY** — agency 의 vertical pin+scrub 와 명확히 다름 |
| #17 3D tilt card hover | roster member card hover (rotateX/Y ±10° Framer Motion spring) | **MANDATORY** — agency 의 simple scale 1.03 차별 |
| #18 Countdown ticker | hero eyebrow 또는 우상단 release countdown (D-day HH:MM:SS Mono tabular-nums) | **MANDATORY** — K-pop comeback signature |
| #19 Sequenced staggered hero load | 8-stage timeline (eyebrow → 한글 → 영문 → tagline → CTA), 각 stage timing 명확 | **MANDATORY** — agency 의 30ms all-at-once 와 차별 |
| #11 Lenis smooth scroll | 전역 inertia (mobile gate) | **MANDATORY** |
| #12 prefers-reduced-motion | JS gate + CSS @media 양 layer + Ken Burns 즉시 fallback | **MANDATORY** |

**Banned (agency-portfolio 시그니처 — kpop 에서 사용 금지):**

- ❌ Snippet #8 Magnetic CTA (agency 시그니처 — opacity 0.85 만 사용)
- ❌ Snippet #6 DrawSVG monogram (agency 시그니처)
- ❌ Snippet #10 anime.js path morph (agency 시그니처)
- ❌ Snippet #4 ScrollTrigger pin+scrub vertical fade (agency hero signature — horizontal 으로 대체)
- ❌ Snippet #3 의 SplitText chars stagger 30ms all-at-once 패턴 (agency 시그니처 — sequential 8-stage 로 대체)

판정: 위 mandatory 8 snippet 중 7개 이상 verbatim 적용 안 되거나 banned snippet 등장 시 motion-immersive 톤 실패 — re-generate.



- **Button variants:**
  - `Primary (Filled)`: accent color background, dark text (`oklch(0.08 0.004 250)`), radius `4px`, padding `16px 32px`. Hover: opacity `0.85`.
  - `Secondary (Ghost)`: 1px near-white border `30% opacity`, transparent background. Hover: border `1.0 opacity` + background `5% opacity`.
  - `Tertiary (Link)`: text + arrow `→`. Hover: arrow translate `x: 4px`.
- **Album / Poster card:** square (`1:1`) album art, **radius `0`** (album art is sacred geometry). Below: 한글 앨범명 (Display `20-24px` heavy) + 영문 romanization (italic `16px`) + Mono release date (`2026.06.04`). Hover: album art slight scale `1.0 → 1.03` over `400ms` ease-out + play icon overlay fade-in.
- **Artist card (group · solo):** full-bleed portrait (`3:4` or `2:3`), radius `0`. Bottom overlay: 한글 아티스트명 (Display Heavy `28-40px`) + role (Mono caps `12px`). Hover: dark gradient overlay deepens slightly, no transform.
- **Schedule item:** date Mono large (`24-32px`) + event title Sans medium + venue · time Sans muted. Hairline divider between rows. Accent color dot for "TODAY" marker.
- **Badge / Tag:** Mono `11px` uppercase tracked `0.12em`. 예: `NEW` · `COMEBACK` · `EXCLUSIVE` · `LIMITED` · `한정판`. Radius `4px`. Accent color text on transparent + 1px accent border, 또는 accent fill + dark text.
- **Nav:** transparent overlay → hairline bottom border on scroll. Mega-dropdown (artist grid thumbnail · upcoming schedule · latest release). Multi-language switcher Mono caps `12px`.
- **Music player widget (sticky bottom):** album art thumbnail (radius `0`) + track title + artist + play/pause/skip controls (accent color active state) + progress bar (1px height, accent fill). Background `oklch(0.12 0.005 250)` surface tier.
- **Community / Fan post card:** avatar (radius `999px` 한정 — 사람 얼굴만 예외) + username + post body + reaction count (Mono). Surface elevation `oklch(0.12 0.005 250)`.
- **Animation library:** Framer Motion + GSAP (cinematic effect 한정).
  - **Hero media Ken Burns:** on-load only, slow zoom `1.0 → 1.05` over `≤2000ms` ease-out OR slow pan `≤2000ms`. Loop 금지 — single playback. Marketing hero exception.
  - **Hero typography:** `opacity 0 → 1` + `y: 16px → 0` over `800-1200ms` ease-out, stagger `200ms` (eyebrow → 아티스트명 → tagline → info strip → CTA).
  - **Scroll-triggered parallax:** hero media subtle parallax (`y: -10%` over scroll), discography section album art reveal stagger `100ms`. Reduced-motion 시 즉시 표시 fallback.
  - **Hover:** album art scale `1.0 → 1.03` (`400ms` ease-out), button opacity `0.85`. Bouncy spring · overshoot 금지.
  - **Page transition:** fade `200-300ms` 또는 View Transitions API. Slide-jack 금지.
  - **Banned motion:** sparkle/star particle effects (fan-cam aesthetic cliché), lens flare overlay, chromatic aberration filter, bouncy spring on transition, marquee infinite loop, 3D rotating album cover (early 2010s skeuomorph), **auto-play music with sound on hero entry** (auto-play muted video는 허용).

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Hero · 아티스트 · 디스코그래피 · 스케줄 · 아티스트 bio · 커뮤니티 · 샵 · Auth · Footer) 및 모든 서브 페이지는 위 Design System Definition을 엄격히 준수.
- Single accent only — 처음 선택한 artist/campaign accent 외 다른 saturated color 동시 사용 금지.
- 새로운 색상 · radius scale 추가 · 아이콘 multi-color 사용 금지.
- **Album / Poster art는 sacred:**
  - Overlay text · blur · filter로 가리지 말 것
  - Aspect ratio 변경 금지 (정사각 `1:1` mandate)
  - Radius `0` mandate — rounded album art 금지
  - Cropping 금지 — full art 보존
- **Banned patterns (AI K-pop cliché — 명시적 배제):**
  - AI-generic "K-pop modern" purple-pink-blue rainbow gradient
  - Glassmorphism on artist card · album card · player widget
  - Sparkle / star particle effects · fan-cam shimmer mimicry
  - Bouncy spring · overshoot · elastic transition
  - 영문 위주 typography (한글 아티스트명이 secondary로 밀려나는 구조 금지)
  - 다중 saturated accent 동시 사용 (rainbow palette · neon multi-color)
  - Lens flare · chromatic aberration · TikTok-style filter overlay
  - 3D rotating album cover · skeuomorphic vinyl record graphic
  - Auto-play music with sound on hero entry — muted video만 허용
  - Generic stock concert imagery — branded photoshoot · album art only
  - Cartoon mascot · emoji-heavy decoration
  - Pure `#000000` background · pure `#FFFFFF` text
  - Centered hero with gradient blob background
  - "BUY NOW!" / "PRE-ORDER!" 빨간 sticker burst — Mono caps tracked badge로 대체
- **K-pop 시그널 mandate:**
  - 한글 아티스트명 · 앨범명 Display Heavy treatment 강제, 영문 romanization은 italic secondary 또는 대등 stacked.
  - **Multi-language toggle 필수** (한국어 · 영어 · 일본어 최소, 가능하면 중국어 간/번체 추가) — K-pop 글로벌 fanbase expectation.
  - Comeback countdown · release date Mono 표기 (`2026.06.04 18:00 KST`).
  - Trust signal — 소속사 logo, official partner (YouTube Music · Spotify · Apple Music · Melon · Weverse) footer 배치.
  - Fan engagement layer 필수 — 커뮤니티 · 멤버십 · 굿즈샵 · 콘서트 티켓 path 명확.
  - Album / artist photography 자체 brand asset — 외부 stock 금지.
- **Accessibility / motion:**
  - Reduced-motion media query 존중 — Ken Burns · parallax · album scale 모두 즉시 표시 fallback 필수.
  - Color contrast WCAG AA — dark theme accent color는 vivid라 contrast `4.5:1` 자동 충족하되, body text muted tier는 확인 필수.
  - Multi-language font fallback chain 안전하게 (한 → 영 → 일 → 중).
- 이 Hero Section을 기준으로 전체 사이트의 cinematic immersion, photographic weight, typographic heavy treatment를 일관되고 의도적으로 확장하라. HYBE의 corporate cinematic, SM의 visual maximalism, Weverse의 fan-driven UX, 빅히트뮤직의 editorial bold treatment를 합쳐 단일 K-pop entertainment 신뢰감으로 통합한다.

## 5. 구현 Guardrails (MUST READ)

상위 `prompts/design/_guardrails.md` 의 5 카테고리 (Text overflow / useGSAP scope / Motion stacking / Absolute positioning / Reduced motion) 모두 적용. 본 DSP 특이 trap:

### 5.1 SplitText + 한글 stacked treatment

본 DSP 가 한글 아티스트명 Display Heavy + 영문 romanization stacked 의무. SplitText 의 `type: "chars"` 적용 시 한글 음절이 jamo 단위로 분해될 가능성 — `type: "words,lines"` 로 설정해 단어 단위 stagger 권장. clip-path 룰 (Category A) 동일 적용.

### 5.2 ScrollSmoother (Lenis) + ScrollTrigger 동기화

본 DSP 가 Lenis 권장. ScrollTrigger 와 동시 사용 시 raf 안에서 `ScrollTrigger.update()` 호출 필수. 단순 import 만으로는 동기화 안 됨 — snippet #11 본문에 박힌 raf 패턴 verbatim 적용.

### 5.3 Album art radius 0 + sacred geometry

`<Image>` 사용 시 radius 0 강제. Tailwind `rounded-*` 클래스 또는 inline `borderRadius` 명시 금지. Album cover hover 시 scale 1.0 → 1.03 (`400ms ease-out`) 만 허용 — radius 또는 aspect ratio 변경 시 fail.

## 6. Media Generation Prompts

본 DSP 의 hero artist photography / artist roster / album cover 자리에 들어가는 image 자산. 공통 style descriptor 는 상위 `_media-prompts.md` 의 **Style D — K-Pop entertainment vibrant** 사용.

생성 방법:

```bash
# 전제: codex login 완료
./scripts/codex-media-gen.sh \
  --dsp kpop-entertainment \
  --prompt hero-artist \
  --output ../distinctive-ui-test/public/kpop/hero-artist.png \
  --size 1536x1024
```

### 6.1 Hero artist photography — cinematic group portrait

<!-- media-prompt: name=hero-artist type=image preset=hero-wide provider=gpt-image-1 -->

Style: K-pop entertainment cinematic dark-theme editorial photography. Studio-controlled stage performance lighting OR moody high-fashion editorial shoot. Mood: artist-tier presence, intentional, motion-blur on extremities allowed, choreography-implied mid-frame.

Subject: 4-member K-pop group (mixed gender or all-same), early 20s, styled in coordinated high-fashion looks (oversized blazers, layered streetwear, leather, sheer fabric — NOT identical uniforms). Members arranged in INTENTIONAL ASYMMETRY — one slightly forward, two mid-plane, one slightly back. Faces partially turned, none looking directly into camera (avoid stiff group shot). Three-quarter view dominant. Hair styled with movement (gel-set, swept, mid-motion).

Composition: 16:9 landscape, cinematic full-bleed. Subjects occupy lower 60-70% of frame, dark cinematic void upper 30-40% (typography overlay zone). Single accent color spill from off-frame side light — coral oklch(0.72 0.22 18) edge-lighting member silhouettes from camera-right.

Lighting: dramatic stage rim-light from upper-right at 30°, deep cast shadow on opposite side. Color temperature mixed: 3200K coral warm side + 5500K cool fill. Edge separation light on hair. NO flat softbox studio. NO beauty dish glamour. Mood: backstage moments before show / editorial cover.

Color: oklch(0.08 0.004 250) deep cool-tinted black background dominant 50%, oklch(0.72 0.22 18) coral accent edge light 10%, mid-tone fashion fabric 30%, skin tone warm natural 10%. Strictly monochrome dark + single coral accent — NO rainbow gradient, NO multi-color stage wash.

NO direct eye contact. NO over-saturated stage filter. NO TikTok lens flare. NO group "peace sign" gesture. NO fan-cam shimmer particle. NO cartoonish styling. Single intentional moment — pre-show or post-shoot editorial.

### 6.2 Album cover — square sacred geometry (1:1)

<!-- media-prompt: name=album-cover-01 type=image preset=cover-square provider=gpt-image-1 -->

Style: K-pop album art editorial cover — high-concept, minimalist, single subject. Mood: 1st full album debut statement, deliberate, mysterious.

Subject: single sculptural object on raw concrete plinth — choice between (a) cracked geode revealing iridescent coral interior, (b) twisted metallic ribbon catching coral edge light, or (c) folded silk drape with coral underlight glow. NO people, NO members visible. Object 50% of frame, anchored slightly right-of-center.

Composition: 1:1 square, hairline grid faintly visible in shadow regions. Subject mid-frame, surrounded by deep void. Subtle vignette corner darkening.

Lighting: single hard coral key light from upper-right at 30° + cool blue fill from camera-left. Edge separation. 3200K accent.

Color: oklch(0.08 0.004 250) background dominant, oklch(0.72 0.22 18) coral accent on subject highlight, single cool blue oklch(0.50 0.04 250) shadow fill. Strictly dark monochrome + single accent.

No text. No artist name. No album title (will be overlaid in code). No QR codes. No watermark. Sacred minimalism.

### 6.3 Album cover — alt concept (1:1)

<!-- media-prompt: name=album-cover-02 type=image preset=cover-square provider=gpt-image-1 -->

Style: K-pop album art — alternate concept, complementary to cover-01. Mood: comeback single, softer texture.

Subject: macro close-up of fabric texture catching directional light — silk velvet OR raw linen OR cracked porcelain surface — abstract enough that interpretation is open. Single coral light beam crosses upper-left to lower-right diagonal.

Composition: 1:1 square. Abstract texture fills frame. Single hard light beam as composition anchor.

Lighting: single hard coral light, dramatic falloff into deep shadow on opposite half. 3500K accent.

Color: deep cool-tinted black dominant, coral accent light beam mid-frame, fabric mid-tone natural. Monochrome + single accent.

No people. No text. No identifiable brand or logo. Pure abstract material study.

### 6.4 Artist roster portrait — member 01 (3:4 portrait)

<!-- media-prompt: name=artist-portrait-01 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: K-pop artist solo portrait — editorial cover quality, dark cinematic, single artist roster card asset. Mood: artist-tier presence, intentional gaze NOT into camera.

Subject: single K-pop artist (early 20s), three-quarter view looking off-frame to camera-left, hand partially up to face or in hair. High-fashion solo styling — oversized blazer with coral accent (single coral element: pocket square, tie, edge stitching). Hair styled with movement.

Composition: 3:4 portrait, subject centered, full-bleed cinematic dark void around. Single coral accent (clothing detail) catches edge light.

Lighting: single hard rim light from upper-right at 45°, deep shadow opposite. 3200K warm accent + cool fill. Mood: editorial cover.

Color: oklch(0.08 0.004 250) deep cool-tinted black dominant 70%, oklch(0.72 0.22 18) coral accent 5% (clothing detail only), skin tone warm natural 25%.

NO direct eye contact. NO stage backdrop. NO microphone or instrument. NO branded apparel logos. Single subject, deep void, editorial intentionality.

### 6.5 Artist roster portrait — member 02 (3:4 portrait)

<!-- media-prompt: name=artist-portrait-02 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: K-pop artist solo portrait — alternate member, same series as portrait-01. Visual continuity with member 01 but distinct subject.

Subject: single K-pop artist (early 20s, different from portrait-01), profile view OR three-quarter facing opposite direction (camera-right). Different styling but same coral accent element (single coral detail). Different hair styling (longer, swept differently).

Composition: 3:4 portrait, subject left-third of frame to balance opposite of portrait-01.

Lighting: matching rim light direction reversed (upper-left at 45°). 3200K coral + cool fill.

Color: matching palette — dark + coral accent + warm skin. Pair-able with portrait-01 in side-by-side layout.

NO direct eye contact. Same banned list as 6.4.

### 6.6 Album cover — repackage / pre-release (1:1)

<!-- media-prompt: name=album-cover-03 type=image preset=cover-square provider=gpt-image-1 -->

Style: K-pop album art — sister concept to 6.2/6.3. Mood: pre-release teaser / repackage edition, more graphic and bold than 6.2's mineral focus.

Subject: extreme close-up of a single sharp metal blade or geometric chrome ribbon partially submerged in glossy black liquid, coral light reflection on the metal surface. Or alternative: half-broken porcelain ceramic shard catching coral edge light at its fractured edge. NO people, NO members visible.

Composition: 1:1 square, subject centered-bottom, deep negative space upper half. Single bright accent point at the metal edge or shard fracture line.

Lighting: single hard coral key from upper-right at 30°, deep falloff. 3200K accent.

Color: oklch(0.08 0.004 250) deep dominant 65%, oklch(0.72 0.22 18) coral hot spot 5%, cool oklch(0.50 0.04 250) reflection 30%. Strictly dark monochrome + single coral.

No text, no artist name, no album title, no QR codes, no watermark.

### 6.7 Album cover — special edition / live recording (1:1)

<!-- media-prompt: name=album-cover-04 type=image preset=cover-square provider=gpt-image-1 -->

Style: K-pop album art — live recording or special edition, more performative cue than 6.2 (mineral) or 6.6 (metal). Mood: stadium-tier energy bottled as abstract object.

Subject: single rotating microphone OR vinyl record edge OR coiled cable on dark concrete, captured mid-motion blur on one element, sharp on another. Coral spotlight from above-right. NO people, NO band logo, NO concert stage backdrop.

Composition: 1:1 square, subject diagonal lower-left to upper-right, sharp at center, motion blur at edges. Single coral hot spot center-mass.

Lighting: single dramatic coral spotlight from upper-right, deep cast shadow. 3500K accent.

Color: oklch(0.08 0.004 250) deep dominant, oklch(0.72 0.22 18) coral accent on motion blur trail, cool reflection. Monochrome + single accent.

No text, no logo, no readable brand on equipment. Single abstract performance moment frozen.

### 6.8 Artist roster portrait — member 03 (3:4 portrait)

<!-- media-prompt: name=artist-portrait-03 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: K-pop artist solo portrait — third member of roster series. Visual continuity with 6.4/6.5 but distinct subject pose and styling.

Subject: single K-pop artist (early 20s, different from portrait-01 and portrait-02), seated low or leaning against frame edge. Hand visible holding something abstract (could be a ribbon, a chain, fabric) — implies introspective pause between performances. Same coral accent element (single coral detail in styling — e.g., earring, cuff stitching, ribbon). Shorter hairstyle or different parting.

Composition: 3:4 portrait, subject center-frame or slightly right, full-bleed cinematic dark void around. Lower-third dominant.

Lighting: single hard rim light from camera-left at 60° (different angle from 6.4/6.5). Deep shadow opposite. 3200K warm coral + cool fill.

Color: matching palette — dark dominant, coral accent (clothing detail), warm skin tone.

NO direct eye contact. NO microphone or instrument. NO branded apparel logos. NO sunglasses. Single subject, deep void, editorial intentionality.

### 6.9 Artist roster portrait — member 04 (3:4 portrait)

<!-- media-prompt: name=artist-portrait-04 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: K-pop artist solo portrait — fourth member of roster series. Completes the 4-member set.

Subject: single K-pop artist (early 20s, different from portraits 01-03), looking upward at slight angle (NOT into camera), strong contrast lighting on jawline. Hands in pockets or arms crossed in considered pose. Distinct styling — leather jacket with single coral lining or coral lining visible at collar/cuff. Mid-length hair styled with movement.

Composition: 3:4 portrait, subject left third of frame OR head slightly tilted creating dynamic diagonal. Full-bleed cinematic dark void.

Lighting: hard top-down rim light from above + coral accent from camera-right at 75° creating triangular jaw highlight. Deep shadow underneath. 3000K coral + cool fill.

Color: matching palette consistent with 6.4/6.5/6.8 — dark dominant, coral accent, warm skin.

NO direct eye contact. NO accessories with brand logos. Single subject, deep void, editorial.

### 6.10 Pre-commit audit hook for media

본 DSP 적용 시 generated code 가 external placeholder image (Unsplash / picsum 등) 또는 generic stock concert imagery 를 사용하면, designer agent 는 매핑되는 media-prompt 가 박혀있는지 확인:

```bash
# External placeholder + 외부 stock 색출
grep -rnE 'unsplash\.com|picsum\.photos|stock|getty|shutterstock' <project>/app

# DSP 의 media-prompt 매핑 카운트 (≥ 5 기대: hero-artist + album x2 + portrait x2)
grep -c "<!-- media-prompt: name=" prompts/design/web/kpop-entertainment.md
```

외부 stock 사용 자리 N개 → media-prompt N개 매핑 ≥ 1:1. 부족하면 DSP 에 prompt 추가 또는 Open question.

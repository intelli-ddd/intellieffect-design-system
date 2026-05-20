---
name: brutalist-architecture
type: design-system-prompt
domain: Brutalist architecture — architecture firm / law firm / consultancy / serious editorial studio / minimalist gallery / typographic identity
tone: heavy spacing, zero decoration, italic emphasis, numbered enumeration, bilingual, photo-as-data
reference: KVS Studio (ASCII identity), Aboutluca (entry gate + numbered chapters), Studio375 (italic asterisk emphasis), Victor Furuya '26 (manifesto block typography), David Chipperfield / Herzog & de Meuron 건축 사무실 site 류
---

# Design System Prompt — Brutalist Architecture (Heavy Typography, Restrained Motion)

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. agency-portfolio 의 cinematic motion-maximalist 시그니처 와 다름 — Cluster A subset (Brutalist agency / portfolio). 2-plugin minimal GSAP + heavy whitespace + numbered enumeration + bilingual 이 본질.

건축 사무실 · 변호사/컨설팅 · 미니멀 갤러리 · 학술 출판사 의 사이트. 전문성 + sobriety + 영구성. agency-portfolio 의 화려한 brutalist 와 다른 — **더 차분하고 archival 한 brutalist**. KVS / Aboutluca / Studio375 / Victor Furuya '26 의 4가지 sub-variant 통합. 작품 · case study · 출판 archive 자체가 hero.

## 1. Design System Definition

- **Primary Color (Background):** `oklch(0.96 0.008 90)` warm cream OR `oklch(0.97 0 0)` neutral off-white. **Pure `#FFFFFF` 금지** — eye fatigue. Dark mode 적용 시 `oklch(0.15 0.005 250)` (대안).
- **Accent Color:** **단일 색만 OR 무색** (most brutalist sites have NO accent).
  - `oklch(0.28 0.04 145)` deep forest (architecture firm)
  - `oklch(0.32 0.06 25)` deep oxblood (law firm)
  - `oklch(0.18 0.005 250)` near-black (zero accent — pure typography)
  - 또는 0 accent (text + dividers 만)
  - Accent 는 link · active state · pagination 한정.
- **Text Color:** `oklch(0.15 0.005 250)` near-black heading, `oklch(0.35 0.008 250)` body, `oklch(0.55 0.012 250)` muted/meta.
- **Typography:** 2-3 family carefully selected.
  - **Display (case study title · manifesto):** `Söhne Breit` / `Neue Haas Grotesk Display Pro` Medium 500-600 / `IBM Plex Sans` / `Inter Tight` 600. Letter-spacing `-0.015em`. **Italic axis 적극 활용** — italic words inline 강조 (`*creative* *clarity* *form*` 스타일).
  - **Body (long-read · manifesto):** `Söhne` / `Neue Haas Grotesk Text` Regular 400 / serif option (`PP Editorial New` / `Söhne Mono` for case study captions). Long-form copy 25-32em width.
  - **Mono (numeric · metadata · enumeration):** `IBM Plex Mono` / `Geist Mono` / `Berkeley Mono` — page enumeration `01/N`, year tags, file refs.
  - **Italic-wrapped inline emphasis** 시그니처 (Cluster A 공통) — `*creative*` / `_intelligence_` / `(form follows function)` parenthetical.
  - 텍스트 그라데이션 금지. Gradient text 절대 안 됨.
- **Border Radius:** `0px` 거의 강제. Interactive button 만 `0-2px` 허용. **모든 ≥ 4px rounded 금지** — sharp engineering edge.
- **Shadow:** **없음** (light theme 의 brutalist 는 hairline 만). Image · case study card 도 shadow 0, hairline border 1px 만.
- **Icon Style:** **거의 없음** — text-based label 으로 대체. Necessary 시 thin-stroke (1px) monoline. NO icon library default.

## 2. Layout & Structure

### Hero (4 sub-variant 중 선택)

본 DSP 는 4 sub-variant 가 있다 — domain · brand · personal narrative 에 따라 commit 1개:

#### Variant A — Numbered chapter / book metaphor (Aboutluca 패턴)
- 페이지 진입 시 `_loading_` interstitial gate → 사용자 `[ enter ]` 클릭 → main timeline play
- Hero 가 `1/N` page enumeration top-right (예: `1 / 23`)
- 각 case study / project 가 numbered chapter — book 구조
- Footer minimal — social link 3-5개

#### Variant B — Italic asterisk inline emphasis (Studio375 패턴)
- Hero 가 manifesto-block — italic asterisks 로 핵심 단어 wrap (`*creative* *meet* *375*`)
- 각 case study 가 `(Brand) Name / (Role) Y / (Location) Z` parenthetical metadata
- 무제목 또는 minimal title

#### Variant C — Portfolio versioning (Luke Baffait 패턴)
- Hero 가 `[firmname] V3.0` 또는 `[firmname]. 01 2026 preview` versioning marker
- Project covers 가 AVIF format grid — software product 같은 deliverable
- Bilingual EN/FR (또는 KR/EN) toggle minimal

#### Variant D — Manifesto block typography (Victor Furuya 패턴)
- Hero 가 large display text block — paragraph-form manifesto
- Numbered/sectioned (`# 0` / `01` / `No.1`)
- 학술 · 출판 톤

### Common layout rules

- 데스크톱 기준 max-width `1320px` 또는 `1440px`. Content padding `48-80px` desktop. Heavy whitespace (≥ 30% of viewport).
- 12-column grid 또는 1-column manifesto layout. 12-column 의 col 4-8 만 차지하는 narrow content track 시그니처.
- Top nav transparent overlay 또는 hairline-divided minimal — wordmark 좌측 + 3-5 menu 우측 (Mono caps `13px` tracked `0.06em`). Bilingual toggle 우측 끝.
- Bottom info strip 또는 footer 가 metadata-rich — N projects since YYYY, awards count, last update date.
- Page 하단은 부드러운 fade 없음 — hairline divider hard cut.

### Content composition

- **Eyebrow (Mono caps tracked):** `EST. YYYY · BASED IN [LOCATION]` · `WORK / N PROJECTS / YYYY - 2026` · `PRACTICE · ESTABLISHED 1998`
- **Display (italic asterisk wrapped 가능):** `Architecture for *quieter* days.` / `A practice in *form* and *care*.` — 단순 announcement 가 아닌 manifesto
- **Body subline:** 2-3 line, 25-32em width. 사이트의 본질 · approach
- **CTA:** 단 1개 — `VIEW SELECTED WORK ↗` 또는 `READ APPROACH →`. 단순 underlined text link 또는 sharp outline button (radius 0). **No filled colored CTA**.

## 3. UI Elements & Animation

### 🔴 MUST USE — verbatim motion snippets

Brutalist architecture 는 motion 이 **restrained** 가 본질. agency-portfolio 의 motion-maximalist 와 정반대.

| Snippet | 적용 위치 | 필수도 |
|---|---|---|
| #2 GSAP register | 모든 motion 컴포넌트 상단 (단 minimal — ScrollTrigger 만 활성화) | **MANDATORY** |
| #22 Entry gate (loading + [enter]) | Variant A 적용 시 hero 진입 gate | conditional (Variant A only) |
| #29 Variable font weight on hover | 모든 link / nav item — weight 400→600 transition | **MANDATORY** |
| #11 Lenis smooth scroll | 전역 inertia (단 mobile gate) | recommended |
| #12 prefers-reduced-motion dual gate | JS + CSS 양 layer | **MANDATORY** |
| #32 gsap.matchMedia reduced-motion | 모든 motion reduced variant | **MANDATORY** |
| (custom) Section block fade + y 24px | 각 section enter 시 `autoAlpha 0→1 + y: 24 → 0`, duration 1.1s, ease "expo.out" — **NO chars/words stagger** | **MANDATORY** |

### Banned (다른 cluster 시그니처)

- ❌ Snippet #3 SplitText chars stagger (kinetic 톤 — brutalist 위배)
- ❌ Snippet #4 ScrollTrigger pin+scrub (cinematic 톤 — brutalist 위배)
- ❌ Snippet #8 Magnetic CTA (agency 시그니처 — brutalist 는 underline OR sharp outline)
- ❌ Snippet #10 anime.js path morph (agency 시그니처)
- ❌ Snippet #15 Ken Burns slow zoom (cinematic — brutalist 위배)
- ❌ Snippet #16 Horizontal scroll carousel (kpop 시그니처)
- ❌ Snippet #17 3D tilt member card (kpop 시그니처)
- ❌ Snippet #18 Countdown ticker (kpop 시그니처)
- ❌ Snippet #25 R3F 3D camera (automotive 시그니처)
- ❌ Bouncy spring / elastic.out 어디든
- ❌ Particle / shimmer / sparkle
- ❌ Lottie illustration (text-only 톤 위배)
- ❌ Glassmorphism

### Component rules

- **Link (primary):** text + thin underline `1px solid currentColor` underline-offset `4px`. Hover: weight 400→600 (variable font axis) + accent color shift. **No magnetic. No transform.**
- **Button (rare — sharp outline only):** radius `0`, border `1.5px solid near-black`, transparent background, near-black text. Padding `14px 24px`. Mono caps `12-13px` tracked `0.06em`. Hover: background fill near-black + text inverted (slow 300ms ease-out).
- **Case study card:** thumbnail (AVIF) + hairline border `1px` + caption Mono caps. Hover: border → accent color OR weight → 600 on title. NO transform / zoom.
- **Image:** `objectFit: cover`, radius 0, hairline border 1px. NO drop shadow.
- **Cursor:** native default OR simple dot 8px. **No custom cursor decorations.**
- **Page transition:** Barba.js 또는 View Transitions API + simple opacity fade 200ms. NO Flip layout transition (agency 시그니처).

### Animation duration / easing

- Interactive (link hover · weight axis): 200ms ease-out.
- Section reveal entrance: 1100ms ease-out (NOT chars stagger — block fade + y).
- Page transition: 200-300ms simple opacity.
- Mobile · `prefers-reduced-motion: reduce` → 모든 motion 즉시 정지 + 정적 표시.
- **일률 `0.3s linear` fade 또는 `transition-all` 금지** — duration · easing 명시.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션 (work · approach · case study detail · about · contact · journal/publications) 은 위 Design System Definition 엄격 준수.
- **단일 accent 또는 무색.** 추가 색 도입 금지.
- Italic asterisk inline emphasis 시그니처 유지 (해당 variant 적용 시).
- Numbered enumeration (`01 / N`) 시그니처 유지 (해당 variant 적용 시).
- Heavy whitespace (≥ 30%) 유지 — content density 가 brutalist 톤 핵심.
- **Banned (brutalist 위배 패턴):**
  - Gradient text · radial gradient bg · mesh gradient
  - Glassmorphism · backdrop-blur
  - Rounded ≥ 4px · pill · capsule shape
  - Drop shadow · embossed text
  - Lucide / Heroicons multi-color icons (use text label instead)
  - Cartoon mascot · emoji · sticker
  - Bouncy spring · elastic transition
  - Magnetic CTA · scale 1.05 hover (agency 시그니처)
  - 3D / WebGL hero scene (cinematic 시그니처)
  - Auto-play video hero (cinematic 시그니처)
  - Marquee infinite loop · ticker animation (단 brand client list 한정 OK)
  - Multi-language toggle 가 carousel/dropdown (간단 toggle 만)
- **Brutalist architecture 시그니처 mandate:**
  - Heavy whitespace (≥ 30%) sacred
  - Single typeface system (display + body + mono 한 family-system, 4-5 family mixing 금지)
  - Italic axis 적극 활용 — italic words inline 으로 emphasis
  - Numbered enumeration 또는 versioning marker — book/software metaphor
  - Bilingual (locale 별) first-class
  - Project · case study 가 hero 자체 — 톤 자체가 archive
  - Award badges · publication credits inline 노출 (decoration 아님 data)
- **Accessibility / motion:**
  - `prefers-reduced-motion: reduce` 절대 존중 — 모든 motion 즉시 정지
  - Color contrast WCAG AAA (brutalist 톤은 AAA 기대) — near-black on cream `15:1+` 자동 충족
  - Long-form content 25-32em width (reading 최적화)
  - Keyboard navigation 완전 지원 (Tab order, focus ring 명시)
  - Image alt text + caption 의무
- 이 hero 와 typographic restraint 기준으로 전체 사이트 archival 감각, sobriety, longevity 일관 확장. KVS / Aboutluca / Studio375 / Victor Furuya '26 의 brutalist archive aesthetic 통합.

## 5. 구현 Guardrails (MUST READ)

상위 `prompts/design/_guardrails.md` 의 5 카테고리 모두 적용. 본 DSP 특이 trap:

### 5.1 Italic + heavy weight + SplitText 미사용

본 DSP 는 SplitText chars stagger 미권장 (kinetic 톤 위배). 단 manifesto block 의 italic word 가 정상 inline rendering 되도록 normal `<em>` 또는 inline-block span. clip-path 룰 (Category A) 은 적용되되 SplitText 자체 미사용.

### 5.2 Variable font weight hover

Snippet #29 활용 — nav link / hover 가능 link 모두 weight 400→600 transition. 단 variable font (Inter Variable / Söhne Variable / Geist) import 필수 — static font weight 만 import 시 작동 안 함.

### 5.3 Bilingual layout shift

EN / KR (또는 FR) toggle 시 line-height · character width 변동 — `font-feature-settings`, locale-specific font fallback chain 명시. CLS (Cumulative Layout Shift) 0.05 이하 유지.

### 5.4 NO chars stagger — block fade only

Brutalist 의 section reveal 은 block 단위 `autoAlpha + y 24` 만. SplitText 가 코드에 등장하면 fail. designer agent grep audit:
```bash
grep -rE "SplitText|new SplitText" <project>/app/<route> | wc -l
# 기대: 0 — match 시 brutalist 톤 위배, re-generate
```

## 6. Media Generation Prompts

본 DSP 의 case study cover / portrait / archival photo 자리. 공통 style descriptor 는 상위 `_media-prompts.md` 의 **Style E — Editorial magazine** 의 brutalist subset 사용.

```bash
./scripts/codex-media-gen.sh \
  --dsp brutalist-architecture \
  --prompt case-study-01 \
  --output ../distinctive-ui-test/public/brutal/case-study-01.png \
  --size 1024x1536
```

### 6.1 Case study cover — architectural (4:5 portrait)

<!-- media-prompt: name=case-study-01 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: Architectural editorial photography — single completed building captured in considered light. Mood: archival, sober, longevity. NO people. NO motion blur. NO golden-hour cheating.

Subject: single architectural project — concrete + glass + steel construction OR adaptive reuse OR landscape pavilion. Three-quarter view from ground level OR aerial. Building anchored LEFT THIRD of frame, right two-thirds void (overcast sky OR neutral plain).

Composition: 4:5 portrait. Building lower 60% + sky/void upper 40%. Hairline horizon line dead-center OR rule-of-thirds. NO dynamic angle (tilt < 5°).

Lighting: overcast diffuse OR golden hour SOFT (NOT magical hour cheating). 5500K daylight. Detail definition in shadow. Edge separation between mass and void.

Color: muted earth + concrete + glass — single brand accent if architecture has it (e.g. red Sun Yat-sen / blue Polish pavilion). Mostly grayscale + 0-1 accent.

NO people. NO furniture in window. NO cars in foreground. NO graffiti. Single subject, considered framing, editorial magazine cover quality.

### 6.2 Case study cover — interior detail (1:1)

<!-- media-prompt: name=case-study-02 type=image preset=cover-square provider=gpt-image-1 -->

Style: Architectural detail photography — material study close-up. Mood: archival, slow, material truth.

Subject: close-up of architectural detail — choice between (a) exposed concrete formwork pattern, (b) brushed steel handrail meeting cast iron column, (c) raw oak wood floor meeting concrete wall, (d) skylight slot revealing daylight on plaster. NO people. NO furniture overlay.

Composition: 1:1 square. Detail subject 60-70% of frame, deep void around. Hairline guide-lines.

Lighting: natural diffuse OR single hard daylight slot. 5000-5500K. Detail definition in shadow.

Color: material true (concrete grey / steel cool / oak warm / plaster cream). Maximum 1 accent.

NO color cast filters. NO oversaturated wood. NO HDR halo. Pure material study.

### 6.3 Architect portrait (4:5 portrait)

<!-- media-prompt: name=architect-portrait type=image preset=cover-portrait provider=gpt-image-1 -->

Style: Editorial architect portrait — magazine cover style. Mood: considered, archival, no smile.

Subject: single architect (mid-40s to early 60s), three-quarter view looking off-frame to camera-left, hand near face OR on drawing table OR holding rolled drawing. Wearing dark cardigan OR linen shirt. Hair natural, not styled.

Composition: 4:5 portrait, subject upper 60% of frame, lower 40% workspace context (drafting table / model / book).

Lighting: window soft light from camera-right at 30°. 5000K. Edge separation on hair.

Color: muted natural — gray cardigan, oak desk, warm cream paper. Single accent if hand-rolled drawing or single tool catches light.

NO over-perfect smile. NO direct camera contact. NO stock-photo construction site hardhat. Editorial cover quality.

### 6.4 Pre-commit audit hook for media

```bash
grep -rnE 'unsplash\.com|picsum\.photos|getty|shutterstock' <project>/app

grep -c "<!-- media-prompt: name=" prompts/design/web/brutalist-architecture.md
# 기대: ≥ 3 (case-study-01 + case-study-02 + architect-portrait)
```

## 7. Motion Choreography (이 DSP 의 distinct signature)

본 DSP 가 다른 cluster 와 시각적으로 구별되는 motion 정체성. **restraint 자체가 시그니처** — kinetic / cinematic / playful 모두 거부.

### 7.1 Hero on-load sequence (sequential simple, 800ms total)

```
t=0ms     Lenis 활성화 (mobile gate)
t=0ms     (Variant A only) `_loading_` interstitial gate visible, [enter] button awaits user click
t=200ms   eyebrow Mono caps fade in opacity 0→1 + y -8 over 400ms ease-out
t=400ms   display headline (italic asterisk inline emphasis 포함 가능) fade in opacity 0→1 + y 16 over 600ms ease "expo.out"
t=800ms   body subline + CTA underline fade in stagger 100ms
```

agency 의 chars stagger / kpop 의 8-stage sequenced / cinema 의 3D camera 와 명확히 다름 — block-level **단순 fade + y**.

### 7.2 Scroll behavior — block reveal only

```tsx
// v1.9.5 fix — `gsap.from + onEnter` skips sections that are ALREADY in
// viewport at page load (hero / first-fold). Use `gsap.set initial state +
// gsap.to onEnter + immediate reveal for in-view` 3-step pattern.
//
// CSS 초기 상태 [data-section] { opacity: 1; } (FOUC-safe).
// JS 에서 즉시 set opacity:0 으로 override → ScrollTrigger 가 reveal 담당.

gsap.set("[data-section]", { opacity: 0, y: 24 });

ScrollTrigger.batch("[data-section]", {
  start: "top 95%",                       // top 80% 보다 더 lenient
  onEnter: (batch) => gsap.to(batch, {    // gsap.to (NOT gsap.from)
    opacity: 1,
    y: 0,
    duration: 1.1,
    stagger: 0.05,
    ease: "expo.out",
    overwrite: "auto",
  }),
});

// belt-and-suspenders — 페이지 load 시점에 이미 viewport 안에 있는 섹션
// (hero, first-fold) 은 onEnter 가 안 발화. 직접 reveal.
ScrollTrigger.refresh();
document.querySelectorAll<HTMLElement>("[data-section]").forEach((el) => {
  if (el.getBoundingClientRect().top < window.innerHeight * 0.95) {
    gsap.to(el, {
      opacity: 1,
      y: 0,
      duration: 1.1,
      ease: "expo.out",
      overwrite: "auto",
    });
  }
});
```

**Why**: `gsap.from()` 은 element 의 현재 state 를 final 로 설정 후 from state 에서 animation 시작 — 단, onEnter 가 already-in-view 섹션에 안 발화하면 element 가 `from` state (`opacity: 0, y: 24`) 에서 멈춤. v19-brutal demo 첫 빌드에서 모든 hero section opacity:0 으로 white blank 노출 → 이 패턴으로 fix.

NO pin / NO scrub / NO horizontal carousel. 단순 enter 시 fade + y. brutalist restraint.

### 7.3 Hover patterns

- **Nav link / inline link:** weight 400→600 (variable font axis) + accent color shift, 200ms transition
- **Case study card:** border color → accent + title weight → 600. NO scale / NO transform
- **Image (case study cover):** hover 시 hairline border accent. NO inner zoom
- **CTA button:** background fill near-black + text inverted near-white, 300ms ease-out. NO transform / NO magnetic

### 7.4 Section transitions

- 각 section 진입 시 ScrollTrigger.batch (위 verbatim) 만
- Page transition: Barba.js 또는 View Transitions API simple opacity 200-300ms

### 7.5 Banned (다른 cluster 시그니처 — 등장 시 brutalist 위배 fail)

- ❌ SplitText chars / words stagger (kinetic typography)
- ❌ ScrollTrigger pin + scrub (cinematic immersion)
- ❌ Magnetic CTA (agency)
- ❌ DrawSVG (agency)
- ❌ anime.js path morph (agency)
- ❌ Ken Burns photo zoom (cinematic)
- ❌ Horizontal scroll carousel (kpop / editorial-horizontal)
- ❌ 3D tilt card hover (kpop)
- ❌ Countdown ticker (kpop)
- ❌ R3F 3D camera (cinematic-immersion-auto)
- ❌ Draggable + Inertia sticker (interactive-playground)
- ❌ Scramble effect (AI-SaaS)
- ❌ Particle / shimmer / sparkle 어디든

### 7.6 핵심 reference

- **KVS Studio** (https://kvs.studio/) — ASCII matrix hero, monospace alphabetic, image 0개
- **Aboutluca** (https://www.aboutluca.com/) — `_loading_[enter]` entry gate + numbered chapters 1-23
- **Studio375** (https://375.studio/) — `*creative* *meet* *375*` italic asterisk inline emphasis
- **Victor Furuya '26** (https://victorfuruya.com/) — manifesto-block typography + numbered `# 0 / 01 / No.1`
- **David Chipperfield Architects**, **Herzog & de Meuron**, **SANAA** site 류 — 건축 사무실 archive 톤

### 7.7 Pre-commit audit (designer agent 의무)

```bash
PROJECT_DIR=<project>/app/<route>

# A. Cluster A brutalist mandatory 패턴
grep -rE "ease:\s*['\"]expo\.out['\"]" "$PROJECT_DIR"        # block fade + y 24
grep -rE "font-variation-settings.*wght" "$PROJECT_DIR"      # variable font hover
grep -rE "data-section|\.section-block" "$PROJECT_DIR"       # block-level reveal
grep -rE "border-radius:\s*0|borderRadius:\s*0" "$PROJECT_DIR"  # sharp edge

# B. Banned cluster 시그니처
grep -rE "SplitText|new SplitText" "$PROJECT_DIR"            # kinetic — fail
grep -rE "scrub:\s*(true|0\.5|1)" "$PROJECT_DIR"             # cinematic — fail
grep -rE "useMotionValue.*Magnetic|stiffness:\s*150" "$PROJECT_DIR"  # magnetic — fail
grep -rE "createTimeline|svg\.morphTo" "$PROJECT_DIR"        # anime morph — fail
grep -rE "KenBurnsHero|kenBurns" "$PROJECT_DIR"              # cinematic — fail
grep -rE "TiltCard|rotateX.*rotateY" "$PROJECT_DIR"          # kpop tilt — fail
grep -rE "CountdownTicker" "$PROJECT_DIR"                    # kpop — fail
grep -rE "useFrame|R3F|fiber" "$PROJECT_DIR"                 # automotive — fail
grep -rE "Draggable|InertiaPlugin" "$PROJECT_DIR"            # playground — fail
grep -rE "@keyframes\s+(sparkle|shimmer|particle)" "$PROJECT_DIR"  # decoration — fail
```

매치 결과 motion-cluster 정합성 확인. Banned 매치 ≥ 1 시 fail → brutalist restraint 톤 위배, re-generate.

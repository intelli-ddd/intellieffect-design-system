---
name: agency-portfolio
type: design-system-prompt
domain: Creative agency / Creative developer portfolio / Branded campaign (디지털 에이전시·크리에이티브 디벨로퍼 포트폴리오·브랜디드 캠페인 사이트)
tone: brutalist, cinematic, experimental, motion-maximalist, hand-crafted
reference: |
  GSAP showcase 11선 —
  Luke Baffait https://www.lukebaffait.fr/ (Creative Developer portfolio, ScrollTrigger),
  Apex https://apex-psi-indol.vercel.app/ (SplitText),
  Škoda Vision Concept https://vision.doanbao.com/ (ScrollTrigger + ScrollSmoother, cinematic single-page),
  Studio375 https://375.studio/ (ScrollTrigger + SplitText, studio site),
  Maxima Therapy https://maximatherapy.com/ (ScrollTrigger, KOKI-KIKO team),
  Hypefluency https://hypefluency.com/ (ScrollTrigger + Draggable + SplitText + Inertia, interactive),
  Arijaya Putra https://arijayaputra.xyz/ (DrawSVG + MotionPath, personal portfolio),
  Victor Furuya '26 https://victorfuruya.com/ (ScrollTrigger + SplitText, student portfolio),
  DAVINCII https://davincii.com/ (ScrollTrigger + DrawSVG + SplitText + CustomEase + ScrollTo, agency),
  ADA https://thefirstthelast.agency/ (ScrollTrigger + Flip + SplitText, agency),
  Pacôme Pertant Portfolio http://pacomepertant.com/ (ScrollTrigger + SplitText)
---

# Design System Prompt — Agency / Creative Developer Portfolio

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/web/agency-portfolio.md` 로 참조.

크리에이티브 에이전시·creative developer 개인 포트폴리오·브랜디드 캠페인을 위한 motion-maximalist 디자인 시스템이다. GSAP ScrollTrigger·SplitText·DrawSVG·Flip·CustomEase 를 풀로 가동해 cinematic 또는 brutalist 한 감각을 만든다. 일률적 SaaS 랜딩 톤을 거부하고, 작품 그 자체가 사이트의 hero 가 된다.

## 1. Design System Definition

- **Background variant — 둘 중 단 하나 commit (혼합 금지):**
  - **Dark cinematic** `oklch(0.10 0.004 250)` near-black — Škoda Vision / Maxima Therapy / DAVINCII 패턴. 영상·3D scene·branded photography 가 hero 일 때.
  - **Brutalist light** `oklch(0.95 0.012 80)` warm cream — Studio375 / Pacôme Pertant 패턴. 타이포그래피 중심·hairline grid 가 hero 일 때.
- **Accent Color:** brand-specific signature 단 하나. DAVINCII coral `oklch(0.68 0.22 28)` / Apex 형광 lime `oklch(0.88 0.28 130)` / Hypefluency vibrant magenta `oklch(0.62 0.28 350)` 중 하나 또는 작품-derived custom. Generic 보라·인디고 금지. Accent 는 CTA·section marker·active state 한정 — 본문 도배 금지.
- **Text Color:**
  - Dark variant: `oklch(0.97 0.004 250)` near-white (headline + body), `oklch(0.62 0.006 250)` muted (caption + meta)
  - Light variant: `oklch(0.16 0.008 80)` deep ink (headline + body), `oklch(0.42 0.010 80)` muted (caption + meta)
- **Typography — 3-family 강제, distinctive display 의무:**
  - **Display**: 매우 distinctive 한 family — `Söhne` / `Migra` / `PP Editorial New` / `Whyte Inktrap` / `Ginto` / `Authentic Sans` 또는 brand-commissioned variable font. **Generic Inter / Manrope / Geist 일체 금지**. Variable font axis (weight 100→900, italic, optical size) 적극 활용.
  - **Body**: display 와 대비 — display 가 sans 면 body 는 serif (Tiempos Text / Söhne Breit), display 가 serif 면 body 는 grotesk (Söhne / ABC Diatype).
  - **Mono**: IBM Plex Mono / Berkeley Mono / Söhne Mono / JetBrains Mono. Eyebrow label, project meta (year, role, client), technical caption 한정. Tracking 0.04-0.08em, all-caps.
  - 헤드라인 크기: display 96-200px (clamp 사용), letter-spacing `-0.02em` 또는 `-0.04em` (tight). Body 16-18px, line-height 1.5-1.6.
  - Gradient text 금지. Drop shadow on text 금지.
- **Border Radius:** `0px` default — sharp edge. Interactive (button, input, hover state) 한정으로만 8-12px 허용. **Rounded-2xl 이상 / pill / fully rounded 일체 금지** (brutalist 톤에 위배).
- **Shadow:**
  - 카드·컴포넌트: shadow 없음 — hairline border `1px` at 12-20% opacity 만.
  - Hero image / case study cover 한정으로 cinematic shadow `0 24px 64px rgba(0,0,0,0.4)` (dark variant) 또는 `0 16px 48px rgba(0,0,0,0.12)` (light variant) 1회만 허용.
  - shadcn 기본 `shadow-sm/md/lg` stack 금지.
- **Icon Style:** monoline SVG 또는 hand-drawn brand-specific icon system. Stroke width `1.5px` consistent. **Lucide / Heroicons / Feather 일체 금지** — generic AI-portfolio 의 가장 흔한 tell. 또는 icon 전면 생략하고 mono caps text label 로 대체.

## 2. Layout & Structure (Hero) — 4 옵션 중 단 하나 commit

선택한 옵션을 끝까지 밀고 나가라. 옵션 혼합 시 톤 파괴.

**Option A — Single full-bleed cinematic hero** (Škoda Vision Concept 패턴):
- 100vw × 100vh full-viewport visual (branded video loop / branded photography / WebGL 3D scene).
- 하단 1/3 에 overlay text: 좌측 작은 mono eyebrow (`PROJECT 01 — 2026`), 중앙 또는 좌측 정렬 display headline.
- Scroll 시 GSAP ScrollTrigger `pin: true, scrub: 1` 로 hero 가 viewport 에 고정되며 다음 section 이 위로 올라옴. ScrollSmoother (또는 Lenis) 로 inertia scroll.
- Sound toggle (mute/unmute) 우상단 mono caps.

**Option B — Asymmetric brutalist typography hero** (Studio375 / DAVINCII 패턴):
- 12-col grid, 의도된 negative space.
- 좌상단 col 1-7 에 huge display headline (clamp(96px, 12vw, 200px), weight 400-500, italic optional). 1-2 단어 또는 한 문장.
- 우하단 col 9-12 에 작은 mono meta block — agency name, role, location, year, available status.
- Hairline 1px column rule grid 가 배경에 항시 visible (`oklch(0.16 0.008 80 / 0.08)` 또는 `oklch(0.97 0.004 250 / 0.06)`).
- Scroll indicator 좌하단 mono caps `(SCROLL)` + 작은 vertical line drawSVG animation.

**Option C — Interactive playground hero** (Hypefluency 패턴):
- Hero 가 그 자체로 인터랙티브 — 방문자가 마우스 / 터치로 visual element 를 직접 조작.
- GSAP Draggable + InertiaPlugin 으로 카드·이미지·텍스트 블록을 throw / spin / stack 가능.
- 중앙 또는 한쪽에 SplitText reveal 된 instruction (`DRAG ANYTHING`, `THROW IT`) mono caps.
- 첫 방문자 onboarding hint 3초 후 fade out.

**Option D — Showreel scroll-driven case study hero** (Maxima / Pacôme 패턴):
- Hero 자체는 작은 intro (display 1-line + mono tagline) + 곧장 scroll 유도.
- Scroll 시 각 case study 가 full viewport 차지하며 ScrollTrigger pin/scrub 로 cover image → project title → client → role → year 순차 reveal.
- 각 case study 사이 hairline divider 또는 1프레임 cut transition.

### 공통 layout rule

- Max-width 1440px container 또는 full-bleed. 1920px+ 화면에서는 좌우 negative space 확보.
- 12-col grid, gutter 24px desktop / 16px tablet / 8px mobile.
- Vertical rhythm 8px baseline grid snap.
- Section 간 transition: hairline divider, 1프레임 cut, 또는 ScrollTrigger pin/scrub. Generic fade-in 금지.

## 3. UI Elements & Animation

라이브러리 stack 의무: **GSAP + ScrollTrigger + SplitText + DrawSVG + Flip + CustomEase + ScrollSmoother**. 선택: Draggable + InertiaPlugin (Option C), MotionPathPlugin, ScrollToPlugin.

### 🔴 MUST USE — verbatim motion snippets (`prompts/design/_motion-snippets.md`)

본 DSP 적용 시 다음 snippet 9개 verbatim 박는 것이 의무. **abstract 텍스트로만 GSAP 언급하고 실제로는 CSS keyframes 로 fallback 하는 generation 은 fail.**

| Snippet | 적용 위치 | 필수도 |
|---|---|---|
| #2 GSAP register | 모든 motion 컴포넌트 상단 import + registerPlugin + CustomEase("brand") | **MANDATORY** |
| #3 SplitText hero | hero `<h1>` chars stagger reveal | **MANDATORY** |
| #4 ScrollTrigger pin/scrub | hero 의 3-stage timeline (meta parallax + headline fade + scale) | **MANDATORY** |
| #5 Scroll progress bar | document body 상단 fixed `<div id="scroll-progress">` | **MANDATORY** |
| #6 DrawSVG monogram | brand logo / signature 의 SVG path stroke draw | **MANDATORY** |
| #7 ScrollTrigger.batch | project tile / case study list 의 stagger reveal + parallax inner image | **MANDATORY** |
| #8 Magnetic CTA | primary CTA 1개만 (Framer Motion spring 150/15/0.1) | **MANDATORY** |
| #10 anime.js morph | corner decorative accent (square → diamond → triangle cycle) | recommended |
| #12 prefers-reduced-motion | JS gate + CSS @media 양 layer | **MANDATORY** |

**판정 룰**: 위 9 snippet 중 #2 + #3 + #4 + #5 + #6 + #7 + #8 + #12 의 7개 이상 verbatim 적용 안 되면 motion-rich 톤 실패 — re-generate.

### 필수 motion spec (옵션 무관 — 최소 4가지 적용)

### 필수 motion spec (옵션 무관 — 최소 4가지 적용)

- **SplitText hero headline** — chars 또는 words stagger reveal on load. Stagger `0.02-0.04s`, duration `0.8-1.2s`, ease `CustomEase.create("agency", "0.22, 1, 0.36, 1")`.
- **DrawSVG path animation** — brand logo / signature icon / underline / divider 의 SVG stroke `drawSVG: "0% 100%"` reveal. Duration `1.2-2s`, ease `power2.inOut`.
- **Flip layout transition** — project grid → project detail 화면 morph. 썸네일이 detail page 의 hero 로 그대로 모핑. `Flip.from(state, { duration: 0.8, ease: "expo.inOut" })`.
- **CustomEase** — agency-specific easing curve 1개 정의 후 모든 motion 에 재사용. 예: `CustomEase.create("agency", "M0,0 C0.22,0 0.36,1 1,1")`. Linear / default ease 금지.
- **ScrollTrigger pin/scrub** — 최소 1개 section pin (hero 또는 핵심 case study). Scrub `1` 또는 `true` 로 scroll-driven.
- **ScrollSmoother** (또는 Lenis) — 전역 inertia scroll. **단 mobile 에서는 disable** (touch hijacking 금지).
- **선택**: Draggable + Inertia hero playground, MotionPath element SVG path 따라가기.

### CTA pattern — 3 옵션 중 commit

- **Text-only with thin underline** — `[ VIEW WORK ]` 또는 `See selected projects ↗`, hairline 1px underline, hover 시 underline → accent color shift + magnetic 효과 (pointer 따라 ±8px translate).
- **Sharp outline button** — radius 0, 1.5px border, no fill, mono caps text, hover 시 background → text color invert (CustomEase, 0.4s).
- **Case study link as magnetic image card** — large project thumbnail, hover 시 scale 1.02 + image inner zoom 1.08 (Flip 또는 GSAP), title text translate-up 8px + accent color shift.

### 컴포넌트 룰

- **Nav:** 최소주의 — wordmark 좌상단, mono caps menu 우상단 (3-5 항목). Mobile 은 full-screen overlay menu (display 크기 메뉴 텍스트 + Flip transition). Sticky nav 시 ScrollTrigger 로 scroll-up 에서만 reveal, scroll-down 에서 hide.
- **Card:** hairline border 1px only. Hover 시 border color → accent. Inner padding 24-40px. shadcn `Card` 컴포넌트 default style 금지.
- **Input:** newsletter / contact form 은 underline-only (border-bottom 1.5px). Label 좌측 mono caps eyebrow. Filled rounded input 금지.
- **Cursor:** custom cursor 허용 — 단 simple dot (8-12px) 또는 outlined circle. Trailing meteor / sparkle / particle / blob 일체 금지.
- **Page transition:** Flip 또는 view-transition API. Generic opacity fade 금지.

### Animation duration / easing 룰

- Interactive (button hover, link, toggle): 200-400ms.
- Scroll-reveal entrance: 800-1400ms, stagger 20-60ms.
- Cinematic scroll pin section: scrub-bound, duration meaningless.
- Mobile 에서는 motion 강도 50% (prefers-reduced-motion 존중 + `matchMedia("(max-width: 768px)")` 분기).
- 일률 `0.3s linear` fade / `transition-all` 사용 금지.

## 4. Consistency Mandate

- 모든 섹션 (Hero, Selected work / case study list, Single project detail, About / Team, Process / Approach, Services, Contact, Footer) 과 모든 서브 페이지는 위 Design System Definition 을 엄격히 준수.
- Background variant (Dark cinematic / Brutalist light) 는 사이트 전역 단 하나만 commit — 페이지마다 다르게 가져가지 말 것. Accent color 도 처음 선택한 단일 색만, 추가 색 금지.
- Display typography family 는 1개만 import — 2-3개 mixing 금지. Variable font axis 로 variation 표현.
- GSAP CustomEase 는 사이트 전역 1개만 정의 후 모든 motion 에 재사용.
- **AI-generic banned 패턴 (어느 하나라도 등장 시 톤 파괴):**
  - Generic Inter / Manrope / Geist sans-only typography → distinctive display family 의무
  - Tailwind default slate / zinc / gray scale → brand commit 색만
  - Rounded-xl 이상 카드·hero element → sharp edge default
  - shadcn `shadow-sm/md/lg` 단일 drop shadow → 3-layer cinematic stack OR hairline border only
  - 일률 `transition-all 0.3s` linear fade → CustomEase 정의 또는 `cubic-bezier(0.22, 1, 0.36, 1)`
  - Stock illustration / generic isometric 3D / rendered blob → branded photography / commissioned SVG / custom WebGL
  - Generic "Build amazing things" / "Crafted with passion" copy → brand-specific noun-metaphor 또는 declarative 한 문장
  - Marquee logo cloud 5-8개 (SaaS 클리셰) → agency 는 selected case study showcase 가 더 강한 social proof
  - Glassmorphism, backdrop-blur, neumorphism
  - Auto-rotating carousel without user control
  - Mobile 에서 ScrollSmoother / Lenis 강제 hijacking (touch scroll 빼앗기 금지)
  - Cursor-follower trailing meteor / sparkle / particle / floating blob
  - Centered hero with large CTA pair (SaaS landing 클리셰)
  - Hero abstract gradient blob / mesh gradient / AI-rendered 3D shape
  - Lucide / Heroicons / Feather generic icon row
- **Reference site verbatim mimicry 금지** — `davincii.com` / `vision.doanbao.com` / `hypefluency.com` 의 layout·copy·visual 을 그대로 베끼지 말 것. 패턴·motion 기법·tone 만 채용.
- 이 Hero (선택한 옵션) 를 기준으로 전체 사이트의 톤앤매너·레이아웃·motion 룰을 일관되고 의도적으로 확장하라. 한 페이지만 화려하게 마감하고 sub page 가 generic 으로 무너지는 패턴 금지.

## 5. Reference 시각 자료

GSAP showcase 11선 — 본 DSP frontmatter `reference` 필드에 verbatim listing. 각 사이트의 핵심 visual cue:

- **Luke Baffait** `https://www.lukebaffait.fr/` — Option B brutalist typography hero, mono meta block, ScrollTrigger pin.
- **Apex** `https://apex-psi-indol.vercel.app/` — SplitText char-by-char reveal, 형광 accent on dark.
- **Škoda Vision Concept** `https://vision.doanbao.com/` — Option A cinematic full-bleed video hero, ScrollSmoother inertia, scroll-driven 3D scene reveal.
- **Studio375** `https://375.studio/` — Option B brutalist light variant, hairline grid visible, asymmetric display typography.
- **Maxima Therapy** `https://maximatherapy.com/` — Option D showreel scroll case study, ScrollTrigger pin per project.
- **Hypefluency** `https://hypefluency.com/` — Option C interactive playground, Draggable + Inertia, SplitText instruction reveal.
- **Arijaya Putra** `https://arijayaputra.xyz/` — DrawSVG personal mark, MotionPath element along SVG, personal portfolio scale.
- **Victor Furuya '26** `https://victorfuruya.com/` — SplitText line stagger, student portfolio minimalism.
- **DAVINCII** `https://davincii.com/` — Option B brutalist dark variant, coral accent, CustomEase signature curve, ScrollTo navigation.
- **ADA** `https://thefirstthelast.agency/` — Flip layout transition project grid → detail morph, SplitText agency name.
- **Pacôme Pertant** `http://pacomepertant.com/` — Option D scroll-driven case study, SplitText byline, hairline divider transitions.

## 6. 구현 Guardrails (MUST READ)

본 DSP 적용 시 상위 `prompts/design/_guardrails.md` 의 5 카테고리 (Text overflow / useGSAP scope / Motion stacking / Absolute positioning / Reduced motion) 모두 적용 의무. designer agent 는 pre-commit grep audit 실행 후 결과 리포트에 verbatim 박을 것.

본 DSP 특이 trap (agency-portfolio 톤이 motion-maximalist 라 특히 발화):

### 6.1 SplitText + italic + heavy display

본 DSP 가 italic axis 활용 + display weight 700+ + letter-spacing -0.06em 권장 — Category A trap 직격타. `.word-wrap { overflow: hidden }` 자동 NG. 반드시 `clip-path: inset(-0.15em -0.4em 0 -0.4em)` + italic span 에 `padding-right: 0.06em`.

### 6.2 GSAP ScrollTrigger pinned hero + 외부 progress bar

GSAP showcase reference 중 다수 (Luke Baffait / Studio375 / DAVINCII) 가 hero pin + 페이지 상단 progress bar 패턴. progress bar 는 보통 `<header>` sibling 또는 fixed top — hero ref scope 밖. `useGSAP({ scope: heroRef })` 안에서 `gsap.to("#scroll-progress", ...)` 는 silent fail. **반드시** `document.querySelector("#scroll-progress")` 로 ref 받아 전달 (Category B).

### 6.3 anime.js morph + GSAP rotation stacking

본 DSP 가 anime.js v4 SVG path morph + GSAP rotation 두 모션 모두 권장 — Category C trap 정확히 매치. 같은 element 또는 같은 wrapper 에 둘 다 적용 시 라벨 누움 + drift. **반드시** 다음 중 하나:

- anime.js path morph 만 (corner decorative accent — 본 DSP 기본 권장)
- GSAP rotation 만 (작품 frame / case study cover 처럼 본 element 가 hero 일 때)
- 두 motion 분리: anime.js 는 inner SVG path attr, GSAP rotation 은 outer wrapper, 라벨은 그 wrapper 의 sibling (Category C 선택 2)

### 6.4 ScrollSmoother 사용 시 mobile gate

본 DSP 가 ScrollSmoother 권장하나 mobile (`matchMedia("(max-width: 768px)")`) 에서 disable 의무 — touch hijacking 차단. 이 룰은 Section 4 에 이미 박혀있으나 Category E (reduced-motion) 와 함께 검수.

## 7. Media Generation Prompts

본 DSP 의 hero / project tile 자리에 들어가는 image·video 자산을 위한 prompt verbatim. 공통 style descriptor 는 상위 `prompts/design/_media-prompts.md` 의 **Style A — Brutalist cinematic dark** 사용.

생성 방법:

```bash
# 전제: codex login 완료 (OAuth, OPENAI_API_KEY 불필요)
# Image (Codex CLI imagegen skill 호출)
./scripts/codex-media-gen.sh \
  --dsp agency-portfolio \
  --prompt cover-01 \
  --output ../distinctive-ui-test/public/agency/cover-01.png

# Video (Veo 3 / Sora — manual hand-off, script가 prompt만 echo)
./scripts/codex-media-gen.sh --dsp agency-portfolio --prompt hero-video
```

### 7.1 Hero cinematic video (manual hand-off)

<!-- media-prompt: name=hero-video type=video preset=wide-21-9 provider=veo3 -->

Style: Brutalist editorial cinematic dark composition. Single coral accent light (oklch 0.68 0.22 28) sweeping across a matte-black studio environment. Subject: oversized brutalist serif glyph "S" — like a sculptural metal letterform — slowly rotating on a raw concrete plinth. Hairline lighting rim only, deep shadow occupying 80% of frame.

Subject: massive sculptural typography letterform on plinth, 1 single subject only, no people.

Camera: slow dolly-in from medium-wide to close-up over 8 seconds, locked horizontal, very subtle handheld micro-shake. End frame: extreme close-up of cast shadow edge on concrete.

Duration: 8s loopable.

Audio: silent (overlay studio room tone in post if needed).

Color grade: Roma (Lubezki) — deep blacks lifted to neutral grey, single warm coral accent isolated. No teal-orange. Avoid film grain emulation.

Resolution: 1080p, prepared for 21:9 letterbox crop in post.

### 7.2 Project cover N°01 — Maison Bréa (Editorial)

<!-- media-prompt: name=cover-01 type=image preset=cover-landscape provider=gpt-image-1 -->

Style: Brutalist editorial cinematic dark composition. Raw exposed concrete shelf at slight angle, single coral accent light from top-right at 30°, deep shadow occupying lower 60% of frame. Hairline column of typography "MAISON BRÉA" subtly visible at frame edge — feeling like a contact-sheet print mark.

Subject: matte-glass perfume bottle, oval architectural form, no label, single beam of light catching the glass top edge revealing internal liquid amber tone. Placed off-center (right third).

Composition: 4:3 landscape, deep negative space upper left, subject occupies right third only. Brutalist hairline grid faintly visible in shadow regions.

Lighting: single hard direction light, 3200K, deep shadows, no fill. Mood: post-industrial perfumer studio at night.

Color: oklch(0.10 0.004 250) background dominant 85%, single accent oklch(0.68 0.22 28) coral on bottle highlight 5%, oklch(0.97 0.004 250) glass detail 10%.

No people. No lifestyle props. No copy/text overlay. No watermark.

### 7.3 Project cover N°02 — Plinth Records (Music · WebGL)

<!-- media-prompt: name=cover-02 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: Brutalist cinematic dark composition with subtle electronic music studio cue. Geometric concrete cube sculptures stacked asymmetrically — like physical record press plinths. Single deep blue rim-light edge across one cube face.

Subject: 3-4 stacked concrete plinths of varying sizes, slight irregular angles. Top plinth holds a single matte black vinyl record half-visible — only the disc edge and label hole readable, no print. Mid-frame floating particles (vinyl dust) caught in side light.

Composition: 4:5 portrait, deep negative space top, sculptural subject bottom 60%. Floor reflection minimal (1px hairline).

Lighting: single hard side-light from camera left at 60°, deep shadows on opposite side, 3500K. Mood: a record pressing plant after hours.

Color: oklch(0.10 0.004 250) deep background, oklch(0.28 0.05 250) cube shadow areas, single coral accent oklch(0.68 0.22 28) on one plinth edge highlight. Monochrome 90%.

No people. No text. No genre stereotype (no headphones, no DJ equipment, no neon).

### 7.4 Project cover N°03 — Ottawa & Wend (Product)

<!-- media-prompt: name=cover-03 type=image preset=cover-portrait provider=gpt-image-1 -->

Style: Brutalist cinematic dark composition with product redesign cue. Single hardware product (e.g., minimal metal kitchen tool — pestle, weight, or grinder) on raw concrete surface. Single hand glimpse exit-frame holding tool edge — feeling like a product brief contact sheet.

Subject: brushed steel hand tool, cold metallic surface catching directional light. Tool 70% in shadow, 30% in coral-warm light only on its profile edge. Hand at frame-right edge, fingers visible only, gesture: just-released or about-to-grasp. Single hairline cast shadow under tool.

Composition: 4:5 portrait, subject lower-third, deep void upper two-thirds. Negative space deliberate for typography overlay (will be added in code, do not generate text).

Lighting: single key from camera right at 45° downward, 3800K. Deep shadow side fill = none. Mood: industrial designer studio late-stage proof.

Color: oklch(0.10 0.004 250) background, oklch(0.30 0.08 110) muted olive-tone shadow areas, single warm highlight oklch(0.68 0.22 28) on tool edge only.

No full hand. No face. No environmental clutter. No text.

### 7.5 Project cover N°04 — Foundry 7 (Brand film · Motion)

<!-- media-prompt: name=cover-04 type=image preset=cover-landscape provider=gpt-image-1 -->

Style: Brutalist cinematic dark composition with motion-blur cue suggesting film-still. Frame from an imagined brand film: a tall industrial space (foundry / forge), molten metal pour caught mid-frame in extreme slow motion freeze. Single figure silhouette far background, scale-establishing only.

Subject: stream of molten amber light pouring from upper-left exit at -30°, captured mid-fall, droplets frozen as geometric particles. Crucible vague at top frame edge. Smoke / steam ambient in background partially obscuring far wall.

Composition: 4:3 landscape, diagonal flow upper-left to lower-right. Empty negative space upper-right for typography overlay.

Lighting: molten pour itself = light source (warm amber, oklch 0.78 0.20 65). Ambient surrounding light from molten reflection only. No external key light.

Color: oklch(0.10 0.004 250) background space, oklch(0.78 0.20 65) molten amber primary subject, oklch(0.30 0.10 50) wall shadow reflection. High contrast.

No close-up worker face. No tool detail. No safety equipment visible. No text. Brutalist mood — industrial sublime.

### 7.6 Hero background plate (Option B — typography 뒤 깊이감 부여)

<!-- media-prompt: name=hero-bg type=image preset=hero-wide provider=gpt-image-1 -->

Style: Brutalist cinematic dark editorial — raw oversized industrial space at night. Single coral accent light source (oklch 0.68 0.22 28) sweeping from upper-right diagonal. Mostly empty negative space, deep shadows, hairline architectural detail. Mood: post-industrial studio, contemplative scale, single subject implied but never centered.

Subject: massive concrete or raw steel architectural surface — could be a single vertical column rising from floor, or a pair of overlapping plinths, or an exposed I-beam. Subject positioned in RIGHT THIRD of frame only — LEFT TWO-THIRDS must be deep negative space (this area will host overlaid white typography in the final composition, so any texture/detail there is forbidden).

Composition: 16:9 landscape, asymmetric — subject right third, void left two-thirds. Subtle hairline grid faintly visible only in shadow regions (almost invisible). Floor plane intersects lower 20% of frame, ceiling implied not seen.

Lighting: single hard direction light from upper-right at 30° angle, casting long cinematic shadow toward lower-left. Color temperature 3200K-3500K. Deep shadows, no fill light. Single coral edge highlight on the subject's right-facing surface only.

Color: oklch(0.08 0.004 250) deepest background void 70% of frame, oklch(0.14 0.005 250) mid-shadow concrete tones 20%, single oklch(0.68 0.22 28) coral accent 5%, no other hue. Strictly monochrome dark + coral accent only.

Usage note: this image will be placed full-bleed behind the hero typography at ~18% opacity with an additional `linear-gradient(to right, rgba(0,0,0,0.92) 0%, rgba(0,0,0,0.45) 100%)` left-to-right darkening overlay. Generate WITH that final usage in mind — heavier subject/light energy on the right side, void on the left.

No people. No text or signage. No vehicles. No furniture. No identifiable brand or logo. No motion blur. No film grain emulation. Single subject anchor, deep void elsewhere.

### 7.7 Brand monogram concept (manual hand-off)

<!-- media-prompt: name=brand-monogram type=image preset=cover-square provider=gpt-image-1 -->

Style: Brutalist editorial logomark exploration sheet — 4 distinct STRUKT monogram concepts on white grid, single-color (black ink on cream paper, oklch 0.96 0.012 80 background). Print-mark style, designed as if photographed from agency proof book.

Subject: 4 monogram concepts arranged in 2×2 grid, each ~35% of cell space. Each concept reinterprets letters S T R U K T as geometric brutalist form: option A = stacked square monolith, B = grid-flag construction, C = single hairline tall S, D = blocky 5-glyph mono-stack.

Composition: 1:1 square, 4 cells equal, hairline grid lines between cells, mono caps label below each ("Concept N°01" etc — but DO NOT generate readable text, just suggestion of label marks as small ink dashes).

Lighting: flat document scan, no shadow.

Color: oklch(0.96 0.012 80) cream paper, oklch(0.10 0.005 250) ink primary, no third color.

No watermark. No designer signature. No corner marks beyond hairline grid.

### 7.8 Pre-commit audit hook for media

본 DSP 적용 시 generated code 가 placeholder pattern (CSS lines/dots/diag/block) 자리를 사용하면, designer agent 는 다음 매핑이 박혀있는지 확인:

```bash
# Project tiles 4개 → cover-01..04 prompt 4개 매핑 확인
grep -c "<!-- media-prompt: name=cover-0" prompts/design/web/agency-portfolio.md
# 결과 ≥ 4 (현재 4개 박혀있음)
```

placeholder 자리에 prompt 매핑 없으면 fix 또는 Open question.

---
name: cinematic-immersion-auto
type: design-system-prompt
domain: Cinematic immersion — automotive concept / luxury vehicle / supercar / aircraft / yacht / luxury hardware product
tone: cinematic dark default, telemetry HUD, R3F 3D camera scroll, brand-anchored single accent, motion-heavy scroll-driven
reference: Škoda Vision Concept (Doan Bao Nam, https://vision.doanbao.com/), Polestar, Porsche, Tesla 2024+ campaign style, supercar 1-page launch
---

# Design System Prompt — Cinematic Immersion (Automotive / Luxury Hardware)

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. K-pop 의 "horizontal flow + 3D tilt" 시그니처 와는 다른 cluster — Cluster B (Cinematic immersion). ScrollTrigger pin + ScrollSmoother + scrub 1.5-2.5 + telemetry HUD + R3F 3D 가 본질.

cinematic camera scroll 을 통해 vehicle 또는 luxury hardware 의 form factor 를 점진적 reveal. 사용자는 vertical scroll 하지만 화면 안 에서는 camera 가 3D scene 을 orbit / dolly / track. Awwwards Site of the Day · FWA · CSS Design Awards level.

## 1. Design System Definition

- **Primary Color (Background):** `oklch(0.08 0.004 250)` near-black cool 또는 `oklch(0.10 0.005 200)` near-black warm — pure `#000000` 금지. Surface tier `oklch(0.12 0.005 250)` (HUD panel) / `oklch(0.16 0.006 250)` (overlay).
- **Accent Color:** brand-anchored 단일 색 (vehicle 색·brand identity 따라가야 함). 옵션:
  - `oklch(0.72 0.18 220)` electric blue (EV brand)
  - `oklch(0.74 0.16 145)` electric green (EV / sustainability)
  - `oklch(0.68 0.20 25)` ferrari coral (supercar)
  - `oklch(0.85 0.16 85)` gold amber (luxury anniversary)
  - **Vehicle paint color** 또는 **brand signature** 가 있으면 그것을 따라가는 게 옳음 — 위는 fallback.
  - Accent 는 telemetry HUD value + CTA + 데이터 highlight 한정 — body 도배 금지.
- **Text Color:** `oklch(0.97 0.004 250)` near-white heading (pure `#FFFFFF` 금지), `oklch(0.72 0.008 250)` body, `oklch(0.50 0.012 250)` meta/caption.
- **Typography:** 2-family system.
  - **Display (vehicle name · spec heading):** `Neue Haas Grotesk Display Pro` / `Inter Display` / `Söhne Breit` heavy 700-800. Letter-spacing `-0.025em` for large display. 차분한 mid-weight italic 또는 condensed-sans도 허용.
  - **Mono (telemetry HUD · spec value · numerology):** `Geist Mono` / `JetBrains Mono` / `Berkeley Mono` — RPM / kW / km/h / FPS / 0-100km/h 0.0s 등 모든 수치 mandatory mono caps tracked `0.08-0.14em`.
  - 텍스트 그라데이션 금지. Display heavy 가 본질.
- **Border Radius:** `0px` default (sharp engineering edge). Interactive (button / panel) 한정 `2-6px` 허용. **Rounded ≥ 8px 또는 pill 일체 금지** — luxury hardware 의 sharp tolerance 시그니처.
- **Shadow:** dark mode 에서 거의 무용. HUD panel 만 hairline border `oklch(0.97 0.004 250 / 0.10)` + inset `oklch(0 0 0 / 0.3)` 미세 inner shadow.
- **Icon Style:** thin-stroke (1px-1.25px) monoline. `Phosphor Thin` / `Heroicons outline` / brand 자체 SVG. 16-20px. Fill icon 금지 — sharp engineering 톤 위배.

## 2. Layout & Structure (Hero + Scroll Sections)

- 데스크톱 기준 `1920px` 풀-블리드 mandatory. Inner content padding `64px` desktop.
- **Full-bleed 3D scene hero (100vh / 100vw):**
  - **Background:** R3F (React Three Fiber) 3D vehicle scene OR full-bleed cinematic hero shot. Scene 시작 시 camera 가 vehicle 의 wide shot, scroll progress 에 따라 dolly-in + orbit. Single key light + rim. 환경광 minimal.
  - **Top transparent nav:** 좌측 brand logo + 우측 5-7 menu (Mono caps 12-14px, tracked 0.08-0.14em). 예: `MODEL · SPEC · CONFIGURE · TEST DRIVE · COMPARE · STORE · OWNER PORTAL`. Hairline bottom border `oklch(0.97 0.004 250 / 0.08)` on scroll.
  - **Telemetry HUD top-right (DSP signature):** 5-line mono caps live data 또는 system info — 예:
    ```
    ENGINE       3.0L INLINE-6 TURBO HYBRID
    DRIVE        AWD QUATTRO
    0-100 KM/H   3.2 S
    TOP SPEED    280 KM/H
    RANGE        680 KM (WLTP)
    ```
    또는 fake-telemetry (FPS / RENDER / WEBGL CTX) 도 brand-tonal 일 때 허용.
  - **Center 또는 lower-left typography:**
    - Eyebrow (Mono uppercase 12px, tracked 0.14em, accent color) — `PROTOTYPE · 2026` · `WORLD PREMIERE · GENEVA 2026` · `LIMITED · 300 UNITS`.
    - **Vehicle 명 (Display Heavy, clamp 64px → 120px, line-height 0.92, letter-spacing -0.025em)** — heavy weight. Optional italic axis for trim name.
    - Spec stack 3-line (Mono caps): `MODEL CODE · CHASSIS · POWERTRAIN`.
  - **Bottom info strip (full-width sticky-on-scroll):** 4-column — `PRODUCTION` (limited N units) · `PRICE` (from KRW / USD) · `DELIVERY` (Q3 2026) · `RESERVATIONS` (open). Hairline divider.
  - **Reservation CTA (lower-right pinned):** Primary `RESERVE — KRW 50M` (accent fill + radius 2-4px). Secondary `REQUEST TEST DRIVE` (ghost 1px border).
- **Scroll choreography:**
  - 100vh / 100vw scroll-pin hero with R3F camera tween (Section 3.3.2 verbatim).
  - 후속 sections: exterior 360° / interior detail / powertrain / spec table / configurator / press / reservation.
  - 각 section 은 `ScrollTrigger pin + scrub 1.5-2.5 heavy lazy` — 사용자 scroll 이 camera 또는 layout 을 누락 없이 추적하되 부드럽게 lag.
- Modal / overlay 는 dark surface tier + hairline border.

## 3. UI Elements & Animation

### 🔴 MUST USE — verbatim motion snippets (`prompts/design/_motion-snippets.md`)

Cinematic immersion 톤 적용 시 다음 snippet verbatim 박는 것이 의무.

| Snippet | 적용 위치 | 필수도 |
|---|---|---|
| #2 GSAP register | 모든 motion 컴포넌트 상단 + CustomEase("cinema", "M0,0 C0.6,0 0.1,1 1,1") | **MANDATORY** |
| #15 KenBurnsHero (또는 R3F camera 변형) | hero photographic / video poster fallback | recommended |
| #25 R3F + GSAP 3D camera scroll-pin | hero 3D scene (`scrub: 1.5`-`2.5` lazy) | **MANDATORY (3D hero 사용 시)** |
| #11 Lenis smooth scroll | 전역 inertia (mobile gate) | **MANDATORY** |
| #31 Lenis + GSAP ticker sync | Lenis raf 안에서 ScrollTrigger.update + R3F render | **MANDATORY** |
| #28 Horizontal scroll track | spec table / configurator 옵션 가로 패닝 (선택) | optional |
| #12 prefers-reduced-motion dual gate | JS + CSS + 3D scene static-image fallback | **MANDATORY** |
| #32 gsap.matchMedia reduced-motion | 모든 motion 의 reduced variant | **MANDATORY** |

### Banned (다른 cluster 시그니처 — cinematic-immersion 에서 사용 금지)

- ❌ Snippet #3 SplitText chars stagger 30ms (agency 시그니처)
- ❌ Snippet #8 Magnetic CTA Framer spring (agency 시그니처 — opacity 0.85 만)
- ❌ Snippet #10 anime.js path morph (agency 시그니처)
- ❌ Snippet #17 3D tilt member card (kpop 시그니처)
- ❌ Snippet #18 Countdown ticker (kpop 시그니처)
- ❌ Snippet #16 horizontal section pin (kpop discography 시그니처 — 단 spec table 가로 패닝은 OK)
- ❌ Bouncy spring · elastic.out everywhere (cinema 정밀 톤 위배)
- ❌ Decorative particles / blur backdrop (FPS drop)
- ❌ Rainbow gradient · multi-saturated accent

### Component rules

- **Button (Primary):** accent fill, dark text (`oklch(0.08 0.004 250)`), radius 2-4px, padding `14px 32px`, mono caps `13-14px` tracked `0.08em`, weight 500. Hover: opacity 0.85, no transform.
- **Button (Ghost):** 1px near-white border 30% opacity, transparent, near-white text. Hover: border 1.0 opacity + background 5% opacity.
- **HUD panel:** dark surface tier `oklch(0.12 0.005 250)` + hairline border `oklch(0.97 0.004 250 / 0.10)`. Padding `16px 20px`. Mono caps label `11px` + Mono value `14px`.
- **Spec table:** monospace tabular-nums. Vertical hairline dividers. Sticky header. Each row hover: row bg `oklch(0.97 0.004 250 / 0.03)`.
- **Configurator card:** square aspect, sharp edge (radius 0), thumbnail + Mono caps name + Mono price. Active state: 2px accent border + accent dot top-left.
- **Cursor:** custom thin crosshair OR simple dot 8px. Trailing meteor / sparkle 금지.
- **Page transition:** Flip 또는 View Transitions API + 짧은 (200-300ms) crossfade.

### Animation duration / easing

- Interactive (button hover / link / toggle): 200-300ms ease-out.
- Hero 3D camera scroll-pin: `scrub: 1.5` 또는 `2.5` heavy lazy.
- Section reveal: 1000-1400ms ease "cinema" CustomEase.
- Mobile 에서는 3D scene → static hero image fallback (touch hijacking 차단 + bandwidth 보호).
- `prefers-reduced-motion: reduce` → 3D scene 정적 fallback 이미지로 즉시 표시.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션 (exterior / interior / powertrain / spec / configurator / press / reservation / dealer locator) 은 위 Design System Definition 엄격 준수.
- Single accent only — vehicle/brand 색 외 다른 saturated 동시 사용 금지.
- 새로운 색·radius scale 추가 금지.
- **3D scene 은 sacred:**
  - Lighthouse Performance 핸디캡 인지 — 3D scene 의 JS bundle ≤ 1.5MB (gzipped), polyfill 적극 사용
  - Mobile static fallback 의무 (3D scene 비활성 + hero shot 이미지)
  - WebGL context loss 대비 reload button + 안내 메시지
- **Banned (cinema immersion cliché):**
  - Auto-play 3D scene with motion blur on entry (사용자 불쾌)
  - Rainbow gradient sky / lighting (mono + brand color 만)
  - Glassmorphism HUD (sharp edge + hairline 만)
  - Spline embed (Three.js / R3F 우선, 1MB+ bundle 부담)
  - Lottie 모든 곳 (vehicle motion 은 R3F, illustration 은 SVG)
  - Cartoon mascot / emoji / sticker overlay
  - 모든 motion 에 elastic.out (CTA 도 ease-out 만)
  - "BOOK NOW!" red sticker burst — Mono caps 만
- **Cinematic immersion 시그니처 mandate:**
  - 3D scene 또는 cinematic hero shot 하나는 mandatory
  - Telemetry HUD 1개 이상 visible (사용자가 spec/data 와 차분히 마주봄)
  - Heavy lazy scroll (scrub 1.5+) 으로 사용자 control 이 부드러우면서 lag — cinema 감각
  - Press release · campaign quote inline embed (저널리스트 · YouTube reviewer · 미디어 인용)
  - 모든 수치 (RPM · kW · km/h · 0-100 · price · production qty · range) Mono caps tabular-nums
  - Engineering provenance (chassis / manufacturer / origin / homologation) footer 또는 spec section 명시
- **Accessibility / motion:**
  - `prefers-reduced-motion: reduce` 절대 존중 — 3D scene 즉시 static fallback
  - Color contrast WCAG AA — dark theme + vivid accent contrast 4.5:1 자동 충족하되 body muted tier 확인
  - 3D scene focus trap 없이 keyboard navigation 가능
  - 사진/영상에 alt text + transcript
- 이 hero 와 scroll choreography 를 기준으로 전체 사이트의 cinematic 감각, engineering 신뢰감, motion-heavy choreography 일관 확장. Škoda Vision · Polestar · Porsche Newsroom 의 cinema-grade brand storytelling 을 IntelliEffect 톤 으로 통합.

## 5. 구현 Guardrails (MUST READ)

상위 `prompts/design/_guardrails.md` 의 5 카테고리 (Text overflow / useGSAP scope / Motion stacking / Absolute positioning / Reduced motion) 모두 적용. 본 DSP 특이 trap:

### 5.1 R3F + ScrollTrigger 동기화

본 DSP 가 R3F 3D scene + ScrollTrigger scrub 권장. R3F 의 `useFrame` 과 ScrollTrigger 의 scrub 이 동시 작동 시 motion 충돌 — Lenis raf 안에서 둘 다 sync 의무. Snippet #31 verbatim 적용.

### 5.2 3D scene mobile gate

Mobile (`matchMedia("(max-width: 768px)")`) + low-end device 에서는 3D scene 비활성 + static hero shot fallback. WebGL context creation 실패 시 graceful fallback.

### 5.3 Scrub 값 명시

`scrub: true` 일률 적용 금지 — heavy lazy `scrub: 1.5` 또는 `2.5` 명시. cinema lag 감각이 본질.

### 5.4 Telemetry HUD live data

real-time data (FPS / battery / temperature 등) 표시 시 setInterval 또는 requestAnimationFrame 으로 update. `font-variant-numeric: tabular-nums` 의무 (글자 폭 변동 차단).

## 6. Media Generation Prompts

본 DSP 의 hero photographic / spec configurator card / press / dealer 자리. 공통 style descriptor 는 상위 `_media-prompts.md` 의 **Style H — Automotive/mobility cinematic** 사용.

```bash
./scripts/codex-media-gen.sh \
  --dsp cinematic-immersion-auto \
  --prompt hero-vehicle \
  --output ../distinctive-ui-test/public/cinema/hero-vehicle.png \
  --size 1536x1024
```

### 6.1 Hero vehicle photography (cinematic 3-quarter / 16:9)

<!-- media-prompt: name=hero-vehicle type=image preset=hero-wide provider=gpt-image-1 -->

Style: Automotive cinematic editorial photography. HDR studio lighting on vehicle body with polarizer to manage glass reflection, OR harsh-sun + long-shadow environmental shot (desert / concrete jetty / industrial dock). Mood: engineering pride, motion implied through composition not blur.

Subject: single concept electric supercar OR luxury sedan, three-quarter view from front camera-right at 30°, vehicle parked but composition implies forward motion. NO people in shot. NO branding text visible on vehicle.

Composition: 16:9 landscape, vehicle anchored LEFT THIRD of frame, right two-thirds deep cinematic void OR environmental gradient (sky bleed for typography overlay zone). Floor plane lower 25% with subtle reflection / ground-shadow.

Lighting: HDR studio softbox from above OR single hard sun key + soft fill bounce. Color temperature 5000-5500K neutral. Edge separation rim on vehicle silhouette. NO neon underglow. NO sparkle. NO motion blur on still subject.

Color: oklch(0.08 0.004 250) deep cool-tinted background 60%, vehicle paint primary tonal 30% (single brand color — electric blue / matte black / coral red / metallic silver), single accent oklch(0.72 0.22 18) coral or vehicle paint highlight 10%. Strictly monochrome + 1 accent.

NO people. NO brand logo on vehicle visible. NO license plate readable. NO street signage. NO motion blur. Editorial cover quality, engineering provenance.

### 6.2 Interior detail close-up (4:3 landscape)

<!-- media-prompt: name=interior-detail type=image preset=cover-landscape provider=gpt-image-1 -->

Style: Automotive interior detail photography. Slow, considered, material study. Mood: craftsmanship + premium materiality + engineering precision.

Subject: close-up of interior control surface — choose between (a) brushed aluminum drive selector with engraved 'D / R / P' mono caps, (b) leather-wrapped steering wheel with stitching catching directional light, (c) HUD screen reflection on glass with subtle telemetry visible. NO occupants visible — hands only or none.

Composition: 4:3 landscape, subject occupies center 50-60%, deep void around. Hairline reflection plane.

Lighting: warm interior light from above-right at 30°, soft falloff. 3500K. Edge highlight on metal/leather.

Color: dark interior dominant (oklch 0.10-0.16), single warm accent on detail (oklch 0.68 0.20 25 coral or matching brand color), metallic mid-tone. Monochrome + 1 accent.

NO people visible (only hands at frame edge OK). NO branded logos visible. NO clutter. Editorial cover quality.

### 6.3 Configurator option swatch (1:1)

<!-- media-prompt: name=config-swatch type=image preset=cover-square provider=gpt-image-1 -->

Style: Automotive paint chip / material swatch — single sharp material square photographed against neutral void. Mood: spec sheet, precise, archival.

Subject: single paint/material sample square photographed flat — could be (a) metallic paint with depth, (b) brushed aluminum trim sample, (c) Alcantara fabric texture, (d) carbon fiber weave macro. 1:1 aspect, subject 90% of frame.

Composition: 1:1 square, sample dead-center, hairline framed (1px border), deep void margin.

Lighting: studio softbox 5500K direct + fill. Flat document scan quality.

Color: sample 90% color/texture true, void 10% (oklch 0.10). Single accent if material has natural coral / amber edge highlight.

NO text overlays. NO measurement scales. NO swatch labels. Pure material sample.

### 6.4 Press / campaign coverage thumbnail (4:3)

<!-- media-prompt: name=press-thumb type=image preset=cover-landscape provider=gpt-image-1 -->

Style: Automotive media campaign thumbnail — editorial cover style. Mood: magazine spread thumbnail.

Subject: cinematic vehicle moment — choice between (a) wide environmental shot vehicle on coastal road at sunset with long shadow, (b) studio campaign shot vehicle 3/4 with single dramatic light beam, (c) detail macro of headlight with light pattern catching glass.

Composition: 4:3 landscape, subject occupies 60-70% of frame, environment / void 30-40%.

Lighting: cinematic narrative — golden hour OR studio dramatic OR neon-night moody. Single dominant light.

Color: aligned with brand palette — vehicle paint primary + single accent. NO multi-color stage wash.

NO people. NO brand text. NO captions overlaid (added in code).

### 6.5 Pre-commit audit hook for media

```bash
grep -rnE 'unsplash\.com|picsum\.photos|getty|shutterstock' <project>/app

grep -c "<!-- media-prompt: name=" prompts/design/web/cinematic-immersion-auto.md
# 기대: ≥ 4 (hero-vehicle + interior-detail + config-swatch + press-thumb)
```

## 7. Motion Choreography (이 DSP 의 distinct signature)

본 DSP 가 다른 motion-heavy cluster (agency / kpop / interactive playground) 와 시각적으로 구별되는 motion 정체성. 단순히 SplitText+pin+batch generic 패턴 적용 금지.

### 7.1 Hero on-load sequence

```
t=0ms       Lenis 활성화 + R3F scene mount
t=0ms       3D scene preloader (low-poly stand-in → high-poly LOD swap when ready)
t=100ms     telemetry HUD `INITIALIZING WEBGL...` 메시지 typewriter (Mono caps)
t=600ms     LOD ready 시 HUD `WEBGL CTX READY · FPS 60+ · RENDER 16ms` 표시
t=800ms     camera fade-in (3D scene opacity 0→1 over 600ms ease-out)
t=1200ms    eyebrow (Mono caps coral) `PROTOTYPE · 2026` fade in y -8 over 400ms
t=1400ms    vehicle 명 Display Heavy fade in y 12 over 700ms (NO SplitText chars — too noisy for engineering tone)
t=1900ms    spec stack 3-line Mono caps stagger 80ms each
t=2400ms    reservation CTA fade in opacity 0.85 (NO magnetic — agency 시그니처)
```

agency 의 chars stagger 30ms all-at-once / kpop 의 8-stage sequenced 와 명확히 차별 — engineering 톤 절제 한 sequence.

### 7.2 Scroll behavior — pin + scrub 1.5-2.5 heavy lazy

cluster B 시그니처. 사용자 scroll → camera orbit/dolly 가 trailing motion 으로 따라옴.

verbatim choreography:
```tsx
gsap.timeline({
  scrollTrigger: {
    trigger: heroRef.current,
    start: "top top",
    end: "+=300%",       // 핀 구간 viewport 3배
    scrub: 1.5,          // heavy lazy (1.0 보다 cinematic)
    pin: true,
    pinSpacing: true,
    invalidateOnRefresh: true,
  },
})
  .to(cameraRef.current.position, { z: -8, x: 2, duration: 1 }, 0)
  .to(cameraRef.current.target,   { y: 0.5, duration: 1 }, 0)
  .to(heroOverlayRef.current,     { opacity: 0.2, duration: 1 }, 0.5);
```

(R3F `useFrame` 안에서 camera lookAt(target) 적용 필요)

### 7.3 Telemetry HUD live update

`requestAnimationFrame` 으로 FPS / RENDER ms 표시. setInterval (1s tick) 으로 fake telemetry (BATTERY / TEMP / SOC) update — 모두 `font-variant-numeric: tabular-nums` (글자 폭 변동 차단).

### 7.4 Section transition (exterior → interior → powertrain → spec)

각 section 진입 시 hero scrub 끝 + Lenis 가 다음 section 진입. ScrollTrigger 의 새 timeline 으로 camera 가 다음 view 로 이동 (orbit reverse / interior fly-in / powertrain explode).

### 7.5 Banned motion (다른 cluster 시그니처)

- ❌ SplitText chars stagger 30ms (agency)
- ❌ Magnetic CTA Framer spring (agency — opacity 0.85 만)
- ❌ DrawSVG monogram (agency)
- ❌ anime.js path morph (agency)
- ❌ 3D tilt card hover (kpop)
- ❌ Countdown ticker (kpop)
- ❌ Horizontal scroll carousel (kpop discography 시그니처 — 단 spec table 가로 패닝은 cluster 다름)
- ❌ Draggable + Inertia sticker (interactive-playground cluster)
- ❌ Scramble effect (AI-SaaS cluster)
- ❌ ASCII matrix hero (brutalist cluster)

판정: cluster B cinematic 시그니처 외 다른 cluster 시그니처가 1개 이상 등장 = fail. re-generate.

### 7.6 핵심 reference

- **Škoda Vision Concept** (Doan Bao Nam, https://vision.doanbao.com/) — GSAP Showcase entry. R3F + ScrollTrigger + telemetry HUD + scrub heavy lazy 의 archetype.
- Polestar 1-page launch — single hero + scroll camera + spec stack
- Porsche Newsroom — editorial press release with cinematic photography
- 2024-2026 supercar launch microsite 패턴

### 7.7 Pre-commit audit (designer agent 의무)

```bash
PROJECT_DIR=<project>/app/<route>

# A. Cluster B mandatory 패턴
grep -rE "scrub:\s*(1\.5|2\.[05]|3)" "$PROJECT_DIR"    # heavy lazy scrub
grep -rE "useFrame|R3F|fiber" "$PROJECT_DIR"           # R3F 3D
grep -rE "tabular-nums|font-variant-numeric" "$PROJECT_DIR"  # telemetry HUD

# B. Banned cluster 시그니처
grep -rE "stagger:\s*0\.0[123]" "$PROJECT_DIR"         # agency 30ms — fail
grep -rE "useMotionValue.*Magnetic|stiffness:\s*150" "$PROJECT_DIR"  # magnetic — fail
grep -rE "createTimeline|svg\.morphTo" "$PROJECT_DIR"  # anime morph — fail
grep -rE "scramble\b|JOYCO" "$PROJECT_DIR"             # AI-SaaS scramble — fail
grep -rE "ASCII|matrix.*hero" "$PROJECT_DIR"           # brutalist — fail
```

매치 결과 motion-cluster 정합성 확인. Banned 매치 시 fail → re-generate.

---
name: oryzo-derived
type: design-system-prompt
domain: Premium product showcase — cinematic editorial photographic + WebGL 3D scroll-driven
tone: cinematic dark warm, Lusion studio-tier production, mono caps editorial copy, photographic still life + 3D rendered product hero
reference: https://oryzo.ai/
analyzed_at: 2026-05-21
analyzed_by: analyze-reference skill (Phase 1-2)
---

# Derived DSP — oryzo.ai

본 DSP 는 https://oryzo.ai/ (Lusion Studio production, ORYZO AI coaster brand) 를 **analyze-reference** skill 로 reverse-engineer 한 결과. 우리 plugin 의 23 pre-built DSP 카탈로그 와 별개의 derived DSP — designer agent 가 이 spec 으로 directly build.

## Phase 1 분석 raw data (verbatim from Playwright)

```
Title: ORYZO AI
bodyFont: halyard-display-variable
bodyColor: rgb(255, 237, 215)   # warm cream off-white #FFEDD7
bodyBg: rgba(0, 0, 0, 0)         # transparent (canvas/photo behind)
htmlClasses: is-desktop is-ready
pageHeight: 56691px              # 63 viewports — cinematic full-page
vh: 900
canvasCount: 6                   # multiple WebGL contexts
videoCount: 2
imageCount: 39
sectionsCount: 0                 # div-based, semantic HTML 최소
motionScripts: [] (external)     # bundled in-house (Lusion framework)
h1: "Powered by AI*" 123px weight 500 halyard-display-variable
   color rgb(255, 237, 215)
textTransform: uppercase (all body)
fontWeight default: 500 (mid medium-bold)
```

## 1. Design System Definition

### Tokens (verbatim)

- **Primary text/foreground**: `oklch(0.93 0.04 75)` ≈ `#FFEDD7` warm cream off-white
- **Primary canvas**: dark cinematic with warm tint — likely `oklch(0.10 0.012 60)` near-black + warm undertone
- **Secondary accent**: amber/warm-coral spill light from WebGL scene (no flat accent — light-based)
- **Tertiary**: dark green `#2F4538` (cutting mat material in scene, not a brand color)

### Typography

- **Display**: `halyard-display-variable` (Adobe Fonts, variable font)
  - Weight: 500 (mid medium-bold)
  - Letter-spacing: normal (no tight tracking)
  - Text-transform: **uppercase** on every body text (시그니처)
  - H1 size: 123px desktop (huge editorial display)
  - Eyebrow size: 18px
- **Body**: same family `halyard-display-variable` — single-family system
- **Mono**: not detected in raw data (가능성 — supplementary mono for spec values, but primary is halyard-display)
- **Fallback chain** (Halyard 없을 때): `"Halyard Display", "Söhne Breit", "Inter Tight", -apple-system, "Helvetica Neue", sans-serif`

### Border radius

- 명시적 카드 / 버튼 / pill 검출 안 됨 — 페이지 자체가 typography + photography + 3D scene 만으로 구성, 전통적 UI card 없음
- 권장 fallback: radius 0 (sharp brand) 또는 매우 minimal radius 4-8 (CTA only)

### Shadow

- Drop shadow 없음 — light effect 가 WebGL scene 안에서 처리됨
- Surface elevation 없음 (single hierarchy)

## 2. Layout & Structure

### Page scroll factor

`56691 / 900 = 63x` — **cinematic full-page experience**. Apple AirPods Pro / Polestar / Lusion studio 표준 패턴.

### Hero composition (Section 1 — viewport 1)

- **Top-left**: huge "ORYZO" wordmark — Display Heavy, color cream
- **Top-right**: thin nav (INTRO · FEATURES · PRODUCT · CONTACT) Mono caps small
- **Center photographic plate**: still life on green cutting mat — cork coaster, pencil, paperclip, paper, eraser. **Designer studio aesthetic.** 사용자 손이 막 작업 중인 듯한 directorial 분위기.
- **Right column**: editorial copy (Mono caps 500 weight): "Designed to lift, insulate, and grip in all the right ways. Oryzo makes the simplest moment feel considered."
- **Bottom-left**: "DESIGNED BY LUSION. THE AWARD-WINNING DESIGN STUDIO." (small mono)
- **Eyebrow top**: "MADE FOR MUGS. BUILT FOR TABLES."
- **Right edge vertical text**: rotated text (90°)
- **Bottom-right badge**: small "ORYZO" sticker (typography mark)

### Scroll sections (viewports 2-63)

Observed via screenshots:

**Section 2 (~viewport 2-3)**:
- Headline: "ISN'T JUST A COASTER." (left, Mono caps weight 500, 2-line)
- Center: 3D rendered cork coaster floating, with material highlights — **WebGL scene rotation**
- Right: "Oryzo isn't just a coaster. It's the result of unprecedented AI* breakthroughs."

**Section 3 (~viewport 4-5)**:
- "SO PORTABLE." headline left
- 3D coaster inside hairline-framed gallery square + dial markers
- "SCROLL TO CONTINUE" hint
- Warm amber gradient light spill from right side

**Section deep (~viewport 30+)**:
- "SMART FLIP ENCRYPTION" (mock-tech humor, joke product)
- Eyebrow: "SECURE COMMUNICATIONS, WHEN IT'S NEEDED."
- 2 CTAs: "REPLY" + "DECODE MESSAGE"
- Designer studio still life (keyboard, mat, coaster, pencils, paperclips)

### Layout primitives

- **12-column grid** (inferred — typography aligned to left edge, copy column right, hero center)
- **Full-bleed sections**: 100vh height each
- **Hero photo center**: still life dominates, typography overlays
- **No traditional cards**: page is sections of typography + 3D scene + still life photo

## 3. UI Elements & Animation

### Detected motion stack

- **WebGL/Three.js**: YES — 6 canvases (3D coaster scene rotation throughout)
- **GSAP**: INFERRED (Lusion 의 표준 stack — ScrollTrigger + ScrollSmoother 거의 확실)
- **Lenis smooth scroll**: INFERRED (cinematic scroll 톤)
- **In-house bundled**: YES (motionScripts: 0 external) — Lusion 의 framework 또는 maintained R3F build
- **anime.js / Framer Motion**: 검출 안 됨

### Required snippets (cluster B — cinematic immersion 매핑)

- **#2 GSAP register** (시작점)
- **#25 R3F + GSAP 3D camera scroll-pin** (3D coaster scene 의 핵심)
- **#11 Lenis smooth scroll** (mandatory for 63-viewport cinematic)
- **#31 Lenis + GSAP ticker sync** (heavy lazy scroll accuracy)
- **#15 KenBurnsHero** (photographic still life subtle zoom)
- **#34 CustomEase × ScrollTo anchor** (nav INTRO/FEATURES/PRODUCT/CONTACT click → scroll)
- **#36 gsap.matchMedia reduced-motion** (Category E1)
- **#29 Variable font weight hover** on nav links (halyard-display variable axis)
- **#12 prefers-reduced-motion dual gate** + **#32 gsap.matchMedia**

### Banned

- **#3 SplitText chars stagger** (Lusion 시그니처 아님 — block typography reveal 만)
- **#8 Magnetic CTA** (cinematic dark 톤 — opacity 0.85 only)
- **#10 anime.js morph** (in-house WebGL 으로 해결)
- **#16 Horizontal scroll carousel** (vertical scroll only)
- **#17 3D tilt card** (kpop signature 아님)

## 4. Consistency Mandate

- **Single typography family** — `halyard-display-variable` 만 사용. mixing 금지.
- **All caps body** — `text-transform: uppercase` 모든 본문. 시그니처.
- **Warm cream text on dark warm canvas** — 새 color 추가 금지.
- **Photographic still life + 3D scene** 가 hero. text 단독 hero 금지.
- **63-viewport full-page narrative** — single landing page, multiple sub-pages 사용 안 함.
- **Lusion studio attribution** footer — original tone 유지.

## 5. 구현 Guardrails

상위 `_guardrails.md` 7 카테고리 모두 적용. 본 DSP 특이 trap:

### 5.1 Halyard Display 폰트 fallback

`halyard-display-variable` 는 Adobe Fonts kit. 사용자 프로젝트에 Adobe Fonts 미통합 시 fallback:
- `"Söhne Breit Variable"` (사용 가능 시)
- `"Inter Tight"` weight 500 + tracking adjustment
- 최종 fallback `-apple-system` (visually 차이 있지만 layout OK)

### 5.2 6-canvas WebGL 단순화

오리지널 6 canvas 다 재현 비현실적 (~5MB+ JS bundle). v1.10.0 demo 단순화:
- **Hero 만** R3F 1-canvas scene (rotating cork coaster) OR
- **Photo + scrub** (3D scene 대신 photographic plate + Ken Burns + scrub 1.5)

사용자에게 "WebGL 부분 생략 단순화, photographic 으로 대체" 명시.

### 5.3 63 viewport 압축

63 viewport 그대로 재현 비현실적. v1.10.0 demo 5-7 핵심 section 으로 압축:
1. Hero (viewport 1)
2. "Isn't just a coaster" (viewport 2)
3. "So portable" (viewport 3)
4. "Smart flip encryption" (viewport 5-6, joke section)
5. CTA / footer

사용자에게 "원본 63 viewport 압축, 핵심 section 만" 명시.

### 5.4 Adobe Fonts kit ID

oryzo.ai 의 halyard-display 는 specific kit. 우리 demo 에서 Adobe Fonts 라이선스 없으면 self-hosted Inter Tight + tracking 변형.

## 6. Media Generation Prompts

본 DSP 의 hero photographic still life + 3D coaster scene 자산.

### 6.1 Hero still life (photo)

<!-- media-prompt: name=hero-stilllife type=image preset=hero-wide provider=gpt-image-1 -->

Style: Designer studio still life photography, top-down or three-quarter overhead. Warm cinematic editorial lighting. Mood: considered, intentional, just-paused-mid-work.

Subject: dark green self-healing cutting mat occupying center, with single cork coaster (small disc) placed off-center right. Surrounding props: wooden HB pencil tilted, single paperclip, small white eraser, edge of book or clipboard. NO branding text visible on any prop. NO hand or person in frame.

Composition: 16:9 landscape. Cutting mat fills 70% of frame. Cork coaster anchored right-third of frame (typography overlay zone is left-third).

Lighting: warm window light from upper-right at 30°, color temperature 3500K. Soft falloff. Single hard cast shadow from coaster onto mat.

Color: dark green mat (`oklch(0.32 0.06 145)`) dominant, warm cream prop highlights (`#FFEDD7`), wood-grain pencil mid-tone, single coral/amber edge highlight on coaster.

NO motion blur. NO depth-of-field heavy bokeh. Sharp focus throughout. Editorial cover quality, design studio aesthetic.

### 6.2 Cork coaster product hero (1:1, 3D-style render)

<!-- media-prompt: name=coaster-render type=image preset=cover-square provider=gpt-image-1 -->

Style: Product render — single cork coaster floating against dark warm cinematic background. Mood: sculptural product reveal, gallery framing.

Subject: single cork coaster (disc shape, ~80mm diameter), tilted at slight angle showing texture detail (cork granules visible). Center of frame, full subject visible.

Composition: 1:1 square. Coaster occupies 60% of frame, deep void around. Hairline frame border (1px white at 12% opacity) visible at edges (gallery presentation).

Lighting: dramatic single coral light source from upper-right at 30°, creating warm highlight on coaster top + cast shadow below. Cool blue fill from camera-left at low intensity.

Color: cork warm brown (`oklch(0.52 0.08 65)`) on coaster, deep cinematic background (`oklch(0.10 0.012 60)`), single warm amber edge accent.

NO logo on coaster. NO text. NO motion blur. Pure sculptural product showcase.

### 6.3 Tech section still life (16:9)

<!-- media-prompt: name=workshop-stilllife type=image preset=hero-wide provider=gpt-image-1 -->

Style: Workshop / studio still life — keyboard + cutting mat + props.

Subject: top-down 3/4 view of designer workshop. Mechanical keyboard upper-right corner, dark green cutting mat center, cork coaster right of center, wood pencils + eraser + paperclips scattered. Notebook edge visible. NO human, NO branding text.

Composition: 16:9 landscape. Keyboard occupies upper 30%, mat + coaster center, props bottom 30%.

Lighting: warm overhead 3500K. Multiple soft shadows.

Color: warm wood + dark green mat + cream highlights. Same palette as 6.1.

NO motion. NO blur. Editorial sharp focus.

## 7. Motion Choreography (oryzo.ai distinct signature)

### 7.1 Hero on-load sequence (~1500ms)

```
t=0ms     Lenis activates, page render
t=0ms     Photographic still life background fade in 800ms ease-out
t=300ms   "ORYZO" wordmark fade in y -20 over 600ms ease "cinema" CustomEase
t=600ms   Eyebrow "MADE FOR MUGS. BUILT FOR TABLES." fade in y -8 over 400ms
t=800ms   Right column copy fade in y 12 over 600ms
t=1200ms  Bottom-left "DESIGNED BY LUSION" + right edge rotated text fade
t=1500ms  Right corner ORYZO sticker badge fade in scale 0.95→1.0 spring back.out(1.6)
```

### 7.2 Scroll behavior — 63 viewport scroll-driven cinematic

```tsx
// MANDATORY: Lenis smooth scroll global + ScrollTrigger pin per major section
import Lenis from 'lenis';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

// Snippet #31 verbatim — Lenis × GSAP ticker sync
const lenis = new Lenis({
  duration: 1.2,
  easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
  smoothWheel: true,
  autoRaf: false,
});
lenis.on("scroll", ScrollTrigger.update);
gsap.ticker.add((time) => lenis.raf(time * 1000));
gsap.ticker.lagSmoothing(0);

// 각 section pin + scrub 1.5 heavy lazy
const sections = gsap.utils.toArray("[data-section]");
sections.forEach((section, i) => {
  gsap.timeline({
    scrollTrigger: {
      trigger: section,
      start: "top top",
      end: "+=100%",
      scrub: 1.5,
      pin: true,
      pinSpacing: true,
    },
  })
    .to(section.querySelector(".section-headline"), { yPercent: -20, opacity: 0.5 })
    .to(section.querySelector(".section-3d"), { rotation: 90 }, 0);
});
```

### 7.3 WebGL 3D coaster rotation (단순화)

Original: 6 canvases with R3F. 단순화 (demo): 1 canvas + R3F + ScrollTrigger camera path.

```tsx
// Snippet #25 적용 — R3F + GSAP 3D camera scroll-pin
"use client";
import { Canvas, useFrame } from "@react-three/fiber";
import { useRef } from "react";
import * as THREE from "three";

function CoasterScene() {
  const meshRef = useRef<THREE.Mesh>(null);
  useFrame((state) => {
    if (!meshRef.current) return;
    // Scroll progress 가 mesh rotation 으로 piping
    const progress = state.clock.elapsedTime * 0.2;
    meshRef.current.rotation.y = progress;
  });
  return (
    <mesh ref={meshRef}>
      <cylinderGeometry args={[1.2, 1.2, 0.15, 64]} />
      <meshStandardMaterial color="#8B5A2B" roughness={0.6} />
    </mesh>
  );
}
```

### 7.4 Hover patterns

- **Nav link**: variable font weight 400→600 (Snippet #29), color cream → amber accent
- **CTA button**: opacity 0.85 only (NO magnetic — Lusion 시그니처 정직함)
- **Photographic plate**: Ken Burns slow zoom 1.0→1.05 over 2s on hero load (Snippet #15)

### 7.5 Banned motion (다른 cluster 시그니처)

- ❌ SplitText chars stagger (Lusion 은 block fade)
- ❌ Magnetic CTA spring
- ❌ DrawSVG monogram (typography wordmark 만)
- ❌ Horizontal scroll carousel
- ❌ 3D tilt card hover

### 7.6 핵심 reference

- **https://oryzo.ai/** — original
- **Lusion Studio portfolio** (https://lusion.co/) — 다른 cinematic WebGL 사이트 reference
- **R3F docs** (https://docs.pmnd.rs/react-three-fiber/) — 3D scene 구현
- **GSAP ScrollTrigger** — pin + scrub 1.5 heavy lazy

### 7.7 Pre-commit audit

```bash
PROJECT_DIR=<project>/app/<route>

# Mandatory (cluster B cinematic immersion 매핑)
grep -rE "Lenis|new Lenis" "$PROJECT_DIR"                    # Lenis smooth scroll
grep -rE "useFrame|@react-three/fiber" "$PROJECT_DIR"        # R3F WebGL
grep -rE "scrub:\s*1\.5" "$PROJECT_DIR"                       # heavy lazy
grep -rE "matchMedia.*reduced-motion" "$PROJECT_DIR"          # Category E1
grep -rE "halyard-display|Söhne Breit|Inter Tight" "$PROJECT_DIR"  # typography fallback

# Banned (다른 cluster 시그니처)
grep -rE "SplitText|new SplitText" "$PROJECT_DIR"            # ❌
grep -rE "useMotionValue.*Magnetic|stiffness:\s*150[^0]" "$PROJECT_DIR"  # ❌
grep -rE "HorizontalCarousel" "$PROJECT_DIR"                  # ❌
grep -rE "TiltCard|rotateX.*rotateY" "$PROJECT_DIR"           # ❌
```

매치 결과 oryzo-derived 정합성 확인.

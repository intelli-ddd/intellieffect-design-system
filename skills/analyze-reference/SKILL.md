---
name: analyze-reference
description: 사용자가 reference URL / 이미지 / 스크린샷 / Figma 링크 를 던지면서 "이거 처럼 만들어줘" / "이 사이트 분석해줘" / "이거 같은 디자인" 등 의 요청을 하면 자동 발화. Playwright 으로 reference 사이트 방문해 DOM + CSS + canvas + motion 패턴 reverse-engineer 후 DSP-format spec 으로 변환해 designer agent 에 전달. plugin 의 핵심 entry point — 사전-제작 23 DSP 카탈로그 보다 우선.
auto-trigger: true
trigger-patterns:
  - "이 사이트 처럼"
  - "이거 같은 디자인"
  - "이거 분석해"
  - "이 페이지 따라"
  - "reference"
  - "참고해"
  - "make it like"
  - "analyze this"
  - "URL 입력"
  - "https?://[^ ]+ 처럼"
---

# Analyze Reference — URL → DSP → Code

intellieffect-design-system plugin 의 **primary entry point**. 사용자가 reference 를 던지면 plugin 이 자동으로:

1. **분석** — reference 의 visual + motion + 코드 패턴 추출
2. **변환** — 추출한 패턴을 우리 DSP 스키마 (Section 1-7) 로 정리
3. **구현** — designer agent 에 spec verbatim 전달, React 컴포넌트 build
4. **iterate** — Playwright 으로 reference 와 visual diff 비교, 필요시 refine

**이 skill 이 활성화되면 사전-제작 23 DSP 카탈로그 (`prompts/design/web/` `prompts/design/mobile/`) 는 fallback 으로만 사용**. 사용자가 명시적으로 "agency-portfolio 톤" 같은 카탈로그 도메인 요청 시만 사전-제작 DSP 적용.

---

## Phase 1 — Analyze (Playwright + DOM extraction)

### 1.1 Reference 입력 형식 파싱

사용자 입력에서 reference 추출:
- **URL**: `https?://...` 패턴 매치
- **이미지 path**: 로컬 파일 (`.png` / `.jpg` / `.webp`) 또는 image URL
- **Figma URL**: `figma.com/file/...` / `figma.com/design/...`
- **스크린샷**: 사용자가 첨부한 이미지 (다중 첨부 가능)

URL 이 가장 강력 — 직접 방문 가능. 이미지 / 스크린샷 은 vision 분석으로 fallback (Playwright 사용 불가).

### 1.2 URL → Playwright 분석

```bash
# 메인 세션이 Playwright MCP 호출 (or sub-agent 위임)
mcp__playwright__browser_navigate { url: "<reference>" }
mcp__playwright__browser_resize { width: 1440, height: 900 }  # desktop default
```

await 후:

```js
// DOM + CSS extraction
const result = {
  // 1. Tokens
  bodyFont: getComputedStyle(document.body).fontFamily,
  bodyColor: getComputedStyle(document.body).color,
  bodyBg: getComputedStyle(document.body).backgroundColor,
  h1: document.querySelector('h1') ? {
    text: document.querySelector('h1').textContent.trim(),
    fontSize: getComputedStyle(document.querySelector('h1')).fontSize,
    fontWeight: getComputedStyle(document.querySelector('h1')).fontWeight,
    fontFamily: getComputedStyle(document.querySelector('h1')).fontFamily,
    color: getComputedStyle(document.querySelector('h1')).color,
    letterSpacing: getComputedStyle(document.querySelector('h1')).letterSpacing,
    textTransform: getComputedStyle(document.querySelector('h1')).textTransform,
  } : null,

  // 2. Structural
  pageHeight: document.documentElement.scrollHeight,
  vh: window.innerHeight,
  scrollFactor: document.documentElement.scrollHeight / window.innerHeight,
  // scrollFactor > 5 = 거대 scroll-driven 사이트
  // 1-2 = 짧은 landing
  // 2-5 = 일반 marketing

  // 3. Stack detection
  canvasCount: document.querySelectorAll('canvas').length,
  videoCount: document.querySelectorAll('video').length,
  imageCount: document.querySelectorAll('img').length,
  // canvasCount > 2 = WebGL / Three.js / R3F
  // videoCount >= 1 = video-driven hero
  // imageCount > 30 = image-heavy editorial

  // 4. Motion library detection
  motionScripts: Array.from(document.querySelectorAll('script[src]'))
    .map(s => s.src)
    .filter(s => /(gsap|lenis|three|barba|locomotive|motion|framer)/i.test(s)),
  // 매치 없으면 in-house bundled — Lusion 류 cinematic studio

  // 5. Color palette extraction
  uniqueColors: [...new Set(
    Array.from(document.querySelectorAll('*'))
      .slice(0, 200)
      .map(el => getComputedStyle(el).color)
      .filter(c => c && c !== 'rgba(0, 0, 0, 0)')
  )].slice(0, 10),
  
  uniqueBackgrounds: [...new Set(
    Array.from(document.querySelectorAll('*'))
      .slice(0, 200)
      .map(el => getComputedStyle(el).backgroundColor)
      .filter(c => c && c !== 'rgba(0, 0, 0, 0)')
  )].slice(0, 10),

  // 6. Typography survey
  uniqueFonts: [...new Set(
    Array.from(document.querySelectorAll('h1,h2,h3,p,span,div'))
      .slice(0, 50)
      .map(el => getComputedStyle(el).fontFamily)
  )].slice(0, 5),

  // 7. HTML / body classes (CMS / framework hints)
  htmlClasses: document.documentElement.className,
  bodyClasses: document.body.className,
  bodyDataset: { ...document.body.dataset },
};
```

### 1.3 Motion 관찰

```js
// scroll + observe
window.scrollTo({ top: 800, behavior: 'instant' });
await wait(800);
const elementsTransformed = Array.from(document.querySelectorAll('*'))
  .filter(el => {
    const t = getComputedStyle(el).transform;
    return t && t !== 'none' && t !== 'matrix(1, 0, 0, 1, 0, 0)';
  }).length;
// elementsTransformed > 10 = scroll-driven heavy
```

### 1.4 Screenshot 5 viewport

```bash
mcp__playwright__browser_take_screenshot { filename: "ref-hero.png" }
# scroll 1500 → ref-mid1.png
# scroll 3000 → ref-mid2.png
# scroll bottom → ref-bottom.png
```

각 screenshot 메인 세션에 vision 으로 read — 시각적 인상 + 색상 + composition 평가.

---

## Phase 2 — Convert to DSP

수집된 분석 데이터를 우리 DSP 스키마 (`prompts/design/_template.md`) 로 변환:

```markdown
---
name: <reference-domain>-derived
type: design-system-prompt
domain: <inferred — e.g., "Premium product showcase" or "Agency portfolio">
tone: <inferred — e.g., "Cinematic dark warm + Lusion studio-tier WebGL">
reference: <reference URL>
analyzed_at: <YYYY-MM-DD>
---

## 1. Design System Definition

**Verbatim extracted from reference**:
- Primary background: <bodyBg or surfaceColor>
- Primary text: <bodyColor verbatim>
- Display font: <bodyFont verbatim>
- Display weight: <h1 fontWeight>
- Display size: <h1 fontSize at desktop>
- Letter-spacing: <verbatim>
- Text-transform: <uppercase / none / capitalize>

**Inferred accent color palette** (from uniqueColors):
- Primary: <most common non-text color>
- Secondary: <second most common>

**Border radius**: <inferred from card / button samples>

## 2. Layout & Structure

**Page scroll factor**: <scrollFactor>
- < 2: short landing
- 2-5: medium marketing
- 5-15: scroll-driven product showcase
- 15+: cinematic full-page experience (Lusion / Active Theory 류)

**Hero composition**: <inferred from screenshot>
- Photographic hero + typography overlay
- Brutalist typography only
- 3D WebGL scene
- Video-driven

**Section count** (visible from scroll): <inferred>

## 3. UI Elements & Animation

**Detected motion stack**:
- WebGL/Three.js: <canvasCount > 1 ? "YES" : "NO">
- GSAP detected: <"YES if motionScripts has gsap" else "INFERRED (likely bundled)">
- Lenis smooth scroll: <"YES" if motion match>
- Bundled in-house: <"YES" if no external motion scripts but heavy motion>

**Required snippets** (cluster matching):
- If WebGL cinematic → Snippet #25 R3F + ScrollTrigger
- If brutalist typography → Snippet #29 variable font + block fade
- If horizontal scroll → Snippet #28
- If page > 50000px tall → Snippet #11 Lenis + #31 ticker sync mandatory

## 4. Consistency Mandate

(우리 plugin 의 표준 anti-AI-slop 룰 적용)

## 5. 구현 Guardrails

상위 `_guardrails.md` 7 카테고리 + reference-specific 추가:
- <inferred from analysis — e.g., variable font 사용 / large scroll height handling>

## 6. Media Generation Prompts

Reference 의 photographic asset 식별:
- Hero photo style: <inferred from screenshot>
- Asset count: <imageCount>
- Codex prompt 도출

## 7. Motion Choreography

**Inferred signature**:
- Hero on-load: <fade / Ken Burns / Three.js camera>
- Scroll behavior: <pin+scrub / parallax / vertical / horizontal>
- Hover: <variable font / scale / magnetic>

**Verbatim choreography**:
```tsx
// 추출된 패턴에 따라 적절한 snippet (#2~#40) 조합
```
```

DSP 결과를 `prompts/design/derived/<reference-slug>.md` 으로 저장 (또는 inline 으로 designer agent 에 전달).

---

## Phase 2.5 — Motion fidelity tier 결정 (v1.10.1 — gap fix)

이전 v1.10.0 limitation: WebGL canvas 내부 motion 은 DOM 으로 inaccessible — 단순화 (photo + scrub) 시 visual 70% / motion 0% 였음.

**v1.10.1 fix**: canvas count + reference 톤 에 따라 motion-tier auto-select.

### Tier matrix

| Detected | Tier | 적용 snippet | Bundle | Fidelity |
|---|---|---|---|---|
| canvas count = 0 | **Tier 0** DOM only | #1-#40 (기본) | ~150KB GSAP | 95% (DOM motion 정확 reproduction) |
| canvas count 1-3 + image-heavy | **Tier A** Image sequence | **#41** imageSequenceScrub | GSAP + 5-10MB frames | 80% (Apple AirPods 패턴) |
| canvas count 4+ + 3D 추정 | **Tier C** Lusion sync | **#44** WebGL-Scroll-Sync | Three.js ~600KB + custom shader | 90% (Lusion 본인 pattern) |
| 사용자 GLTF 모델 보유 | **Tier B** R3F + GLTF | **#42 + #43** | R3F + Three.js + drei ~1MB + model | 95% |
| Fast prototype | **Tier D** Spline | **#45** | Spline runtime + 2-5MB scene | 70% mobile-hostile |

### Auto-detection logic (Phase 1 에서 추가 수집)

```js
const detection = {
  canvasCount: document.querySelectorAll('canvas').length,
  imagesPerViewport: imageCount / (pageHeight / viewportHeight),
  hasGLTFLoader: scripts.some(s => /(gltf|three|fiber)/.test(s)),
  hasSpline: scripts.some(s => /splinetool/.test(s)),
  scrollFactor: pageHeight / viewportHeight,
};

// Tier decision:
if (detection.canvasCount === 0) return "Tier 0";
if (detection.hasSpline) return "Tier D";
if (detection.canvasCount >= 4 && detection.scrollFactor > 30) return "Tier C";  // Lusion-tier
if (detection.canvasCount >= 1) return "Tier A";  // Most common cinematic
return "Tier 0";
```

### Sample reference assignment

- **oryzo.ai**: canvas 4+ + scrollFactor 63 + scripts bundled → **Tier C** (Lusion pattern #44)
- **Apple AirPods Pro**: canvas 1 + image sequence detected → **Tier A** (#41, 132 frames)
- **Polestar 1-page**: canvas 1-2 + Three.js detected → **Tier A 또는 B**
- **Awwwards SOTD 류 일반 cinematic agency**: canvas 0 + scroll heavy → **Tier 0** + 적합 snippet

### Frame source (Tier A 적용 시)

`imageSequenceScrub` 의 frame source 옵션:

1. **AI video → ffmpeg PNG sequence** (BP 2026):
   ```bash
   # Veo3 / Sora 으로 8-15s product video 생성 → ffmpeg PNG export
   ffmpeg -i product-rotation.mp4 -vf fps=30 frames/frame_%04d.png
   ```
2. **R3F headless render** — Three.js scene 만든 후 frame-by-frame export
3. **After Effects / Blender** — 디자이너 production
4. **Codex `gpt-image-1` 12-30장 photographic angles** — cheap fallback (cork coaster at 12 rotation angles)

### Frame budget

- Desktop: 132 frames × 1920×1080 JPEG q75 ≈ 10MB
- Mobile: 132 frames × 720×1280 ≈ 3-5MB (별도 frame set 권장)
- Reduced motion: first frame only

## Phase 3 — Build (designer agent dispatch)

생성된 DSP 를 `~/.claude/agents/designer.md` 에 전달:

```
TASK: 다음 reference-derived DSP 를 적용해 <target-route> 에 page 빌드

CONTEXT:
- Reference: <URL>
- DSP: (inline DSP body verbatim)
- 분석된 motion stack: <detected>
- 권장 snippets: <list>

MUST DO:
- DSP token (color/font/radius) verbatim 적용
- 검출된 motion stack 그대로 (e.g., 3D scene 없으면 photo + scrub 만)
- Banned web cluster signatures 0 매치
- TypeScript 0 errors, HTTP 200
```

---

## Phase 4 — Iterate (Playwright visual diff)

```bash
mcp__playwright__browser_navigate { url: "<reference>" }
mcp__playwright__browser_take_screenshot { filename: "ref-final.png" }

mcp__playwright__browser_navigate { url: "http://localhost:3000/<target-route>" }
mcp__playwright__browser_take_screenshot { filename: "our-final.png" }
```

두 이미지 메인 세션이 vision 으로 비교:
- Color match
- Typography match
- Layout match
- Composition match

다르면 designer agent 에 specific feedback 으로 재 dispatch.

---

## Anti-patterns (이 skill 호출 후 발생 시 fail)

1. **사전-제작 23 DSP 강제 적용** — 사용자가 reference 제시했는데 우리 카탈로그 도메인 매핑해서 처리하면 fail. reference 가 우선.
2. **분석 skip** — Playwright 없이 LLM 추측만으로 DSP 생성. 토큰 / 폰트 / scroll height 등 정량 데이터 verbatim 필수.
3. **이미지 mockup 으로 demo** — Codex 으로 page screenshot 생성해서 보여주기 (image-driven mockup). React 컴포넌트 build 가 본질.
4. **Iteration skip** — 한 번 build 후 종료. visual diff 비교 의무.
5. **WebGL/3D scene 추측 build** — reference 가 canvas 6개인데 우리 demo 가 그냥 photo. 정직하게 "WebGL 부분 생략, photo + scrub 로 단순화" 명시 + 사용자 confirm.

---

## 핵심 reference 예시 (분석 → DSP → 코드 transition)

### Example: oryzo.ai (Lusion Studio production)

**Phase 1 analyze 결과**:
- bodyFont: `halyard-display-variable`
- bodyColor: `rgb(255, 237, 215)` warm cream
- h1: 123px weight 500 (huge display)
- pageHeight: 56691px (63 viewports — cinematic full-page)
- canvasCount: 6 (multiple WebGL)
- imageCount: 39 (photographic-heavy)
- motionScripts: 0 (bundled in-house)
- textTransform: uppercase (모든 body uppercase)

**Phase 2 DSP**:
- Style cluster: Cinematic immersion (cluster B subset)
- Tokens: warm cream + dark canvas
- Display: halyard-display-variable weight 500 huge
- Motion: WebGL scroll-driven 63 vh, Lenis smooth, scrub heavy lazy

**Phase 3 build**:
- 3D scene 단순화 (R3F 부담) → photo hero + Lenis scroll + scrub
- Halyard 폰트는 Adobe Fonts kit 필요 → fallback `Inter Tight` Medium 500 또는 `Söhne` 사용 명시
- 63 viewport 전체 재현 비현실적 → 5-7 핵심 section 으로 압축

**Phase 4 iterate**:
- screenshot 비교 → composition 유사도 평가 + 필요시 refine

---
name: implementation-guardrails
description: 모든 DSP가 reference하는 implementation-level code trap 카탈로그 — abstract tone guardrail (색·폰트·radius) 로 prevent 못 하는 5개 카테고리. designer agent 가 코드 생성 후 pre-commit grep audit 의무.
version: v1.7.0
---

# Implementation Guardrails

DSP 의 abstract tone 룰 (색·폰트·radius·motion 라이브러리 선택) 만으로 prevent 되지 않는, **구현 레벨에서 반복적으로 재발하는 code trap** 5 카테고리.

본 문서는 모든 DSP 가 reference 하며, designer agent 가 generation 후 pre-commit audit 으로 직접 검증한다.

---

## Category A — Text overflow (italic + SplitText)

### Trap

SplitText (`type: "chars,words"`) 가 생성하는 word wrapper div 에 `overflow: hidden` 만 박으면 다음 케이스에서 글립이 우측 클리핑된다:

- `font-style: italic` 적용된 글자 (italic 슬랜트가 em-square 우측 경계를 넘김)
- `font-weight: 700` 이상 + 매우 큰 size (heavy weight 가 em-square 좌우 경계 침범)
- 매우 tight letter-spacing (-0.06em 이하, 음수 트래킹이 글립 간 간격 더 좁힘)

원인: slide-up reveal 효과 (`gsap.set(chars, { yPercent: 100 })` → `to(chars, { yPercent: 0 })`) 가 **세로 방향** 클리핑만 필요한데, `overflow: hidden` 은 **사방** 클리핑이라 가로 overshoot 도 잘림.

### MUST USE

`clip-path` 로 세로만 클리핑, 가로는 overshoot 허용:

```css
/* SplitText word wrapper — slide-up reveal 가능하면서 italic glyph 우측 overshoot 허용 */
.word-wrap {
  display: inline-block;
  line-height: 0.95;
  padding-bottom: 0.05em;
  /* top, right, bottom, left — bottom 만 0 (tight), 나머지는 negative 로 overshoot 허용 */
  clip-path: inset(-0.15em -0.4em 0 -0.4em);
}
```

italic span 에 `padding-right: 0.06em` belt-and-suspenders:

```tsx
<span
  style={{
    fontStyle: "italic",
    paddingRight: "0.06em",  // italic glyph overshoot accommodation
    display: "inline-block",
  }}
>
  outlast
</span>
```

### MUST NOT

- `overflow: hidden` on SplitText word wrappers when content includes italic OR weight ≥ 700 OR letter-spacing ≤ -0.05em
- `overflow-x: visible; overflow-y: hidden` — CSS 가 한 축 visible 다른 축 hidden 이면 visible 축이 강제로 auto/scroll 됨 (사양 위반)

### Grep audit

```bash
# SplitText word wrapper 에 overflow:hidden 박힌 케이스 색출
grep -rnE "\.(word|char|line)-wrap[^{]*\{[^}]*overflow:\s*hidden" <project>/app <project>/components
# 매치 ≥ 1 시 수동 확인 — italic / weight 700+ / tight tracking 동반 여부 검증
```

---

## Category B — useGSAP scope rules

### Trap

`@gsap/react` 의 `useGSAP({ scope: ref })` 는 함수 내부의 string CSS selector 를 `scope` element 의 descendant 로만 매치한다. scope 외부 element 를 string selector 로 타게팅하면 silent fail (no error, no tween).

대표 케이스:
- Scroll progress bar (fixed top, hero 컴포넌트 밖)
- Other sections 의 element (selected-work tile, section 2 headline)
- Document body / documentElement

### MUST USE

scope 외부 element 는 `document.querySelector` 로 ref 받아 직접 전달:

```tsx
const heroRef = useRef<HTMLDivElement | null>(null);

useGSAP(
  () => {
    // ✅ External element — DOM ref directly bypasses scope
    const progressBarEl = document.querySelector<HTMLElement>("#scroll-progress");
    if (progressBarEl) {
      gsap.to(progressBarEl, {
        scaleX: 1,
        scrollTrigger: {
          start: 0,
          end: () => ScrollTrigger.maxScroll(window),
          scrub: true,
        },
      });
    }

    // ✅ Internal element — string selector resolved within scope
    gsap.from(".hero-meta-line", { opacity: 0, x: 24 });

    // ✅ External NodeList — toArray + forEach
    const tileNodes = Array.from(document.querySelectorAll<HTMLElement>(".project-tile"));
    if (tileNodes.length) {
      // v1.9.5 — `gsap.set` initial + `gsap.to` onEnter (NOT `gsap.from`) +
      // manual reveal for already-in-view nodes. `gsap.from` skips nodes
      // already past start trigger at page load.
      gsap.set(tileNodes, { opacity: 0, y: 80 });
      ScrollTrigger.batch(tileNodes, {
        start: "top 95%",
        onEnter: batch => gsap.to(batch, { opacity: 1, y: 0, duration: 0.9, stagger: 0.1, overwrite: "auto" }),
      });
      ScrollTrigger.refresh();
      tileNodes.forEach((t) => {
        if (t.getBoundingClientRect().top < window.innerHeight * 0.95) {
          gsap.to(t, { opacity: 1, y: 0, duration: 0.9, overwrite: "auto" });
        }
      });
    }
  },
  { scope: heroRef },
);
```

### MUST NOT

scope 외부 element 를 string selector 로 gsap.to / ScrollTrigger.batch / gsap.utils.toArray 에 전달:

```tsx
// ❌ Bad — "#scroll-progress" 가 heroRef 안에 없으면 silent fail
useGSAP(() => {
  gsap.to("#scroll-progress", { scaleX: 1, scrollTrigger: {...} });  // NO-OP
  ScrollTrigger.batch(".project-tile", { ... });  // NO-OP if tiles outside scope
}, { scope: heroRef });
```

### Grep audit

```bash
# useGSAP scope 사용한 파일에서 string selector 사용 케이스 색출
grep -lE "useGSAP\(" <project>/app | xargs -I {} sh -c '
  if grep -qE "useGSAP\([^,]+,\s*\{\s*scope:" "{}"; then
    grep -nE "gsap\.(to|from|fromTo|set)\(\"[#.][a-z]" "{}"
    grep -nE "ScrollTrigger\.batch\(\"[#.][a-z]" "{}"
  fi
'
# 매치 시 해당 selector 가 scope element descendant 인지 수동 확인 — 외부면 document.querySelector 로 교체
```

---

## Category C — Motion stacking conflicts

### Trap

같은 element (또는 같은 wrapper 의 부모-자식) 에 **두 independent motion source** 를 stack 하면 transform property 충돌 + 자식 label 회전 동조 → visual chaos.

대표 케이스:
- anime.js `svg.morphTo()` infinite loop (path d attribute 만 morph) + GSAP `gsap.to({ rotation, scale, scrollTrigger })` 가 같은 SVG element 부모에 적용 → SVG 가 회전하면서 anime.js morph 도 진행 → 사용자가 인지하기 어려운 회전체
- 부모 div 에 GSAP rotation 적용 + 자식 `<span>LABEL</span>` 도 같이 회전 → 라벨 옆으로 누움
- absolute element 가 GSAP transform 받으면 default transform-origin (center) 로 visual drift

### MUST USE

선택 1 — **한 transform-source per element** (most reliable):

```tsx
// ✅ anime.js 만 적용 (path d attribute 만 morph, 회전·scale 없음)
<div style={{ position: "absolute", right: 64, top: 96 }}>
  <svg ref={animeMorphRef}>
    <path d={...} />  {/* anime.js 가 d attribute 만 morph */}
  </svg>
  <span>LABEL</span>  {/* sibling, 부모 transform 없음 → 정자세 유지 */}
</div>
```

선택 2 — **GSAP 회전 + 라벨 non-rotating sibling 분리**:

```tsx
// ✅ Rotation 은 SVG wrapper 에만, 라벨은 outer container 의 sibling
<div style={{ position: "relative" }}>
  <div ref={rotateTarget} style={{ position: "absolute", right: 64, top: 96 }}>
    <svg>...</svg>
  </div>
  <span style={{ position: "absolute", right: 64, top: 200 }}>
    LABEL  {/* 부모 rotation 영향 없음 */}
  </span>
</div>
// GSAP: gsap.to(rotateTarget, { rotation: 120, transformOrigin: "50% 50%" })
```

선택 3 — **counter-rotation label** (motion 강도 유지 필요 시):

```tsx
<div ref={parent} style={{ rotation: 0 /* GSAP overrides */ }}>
  <svg>...</svg>
  <span style={{ display: "inline-block" }} ref={counterEl}>
    LABEL
  </span>
</div>
// GSAP parent rotation 120 → counterEl 도 -120 (= 0deg net)
gsap.to(parent, { rotation: 120, scrollTrigger: ... });
gsap.to(counterEl, { rotation: -120, scrollTrigger: ... });
```

### MUST NOT

```tsx
// ❌ Bad — anime.js morph + GSAP rotation 둘 다 같은 wrapper, label 도 안에
<div ref={morphWrapper} className="absolute right-12 top-30">
  <svg>... anime.js path morph ...</svg>
  <span>MORPH · 003</span>  {/* 부모 회전하면 같이 누움 */}
</div>
// GSAP: gsap.to(morphWrapper, { rotation: 120, scale: 1.6 })  // ❌
```

### Grep audit

```bash
# anime.js morph + GSAP rotation 둘 다 등장하는 파일 색출
grep -lE "svg\.morphTo|createTimeline" <project>/app | xargs -I {} sh -c '
  if grep -qE "gsap\.(to|from|fromTo).*rotation" "{}"; then
    echo "POTENTIAL CONFLICT: {}"
    grep -nE "svg\.morphTo|gsap\.(to|fromTo).*rotation" "{}"
  fi
'
# 매치 시 해당 element 가 같은 wrapper 인지 sibling 인지 수동 검증
```

---

## Category D — Decorative absolute positioning

### Trap

`position: absolute` element 에 GSAP rotation 적용 시 transform-origin default (center, 50% 50%) 가 (a) bounding box 가 작으면 의도와 다른 pivot (b) scale 동반 시 좌표 drift 유발.

### MUST USE

rotation 적용 element 에 `transformOrigin` 명시:

```tsx
gsap.to(decorEl, {
  rotation: 120,
  scale: 1.4,
  transformOrigin: "50% 50%",  // 또는 명확한 픽셀 좌표 "48px 48px"
  scrollTrigger: ...,
});
```

absolute element 의 위치는 GSAP transform 이 아닌 CSS top/right 로 잡고, GSAP 은 rotation/scale 만 담당:

```tsx
// ✅ position 은 CSS, transform 은 GSAP — 책임 분리
<div ref={decorEl} style={{ position: "absolute", top: 96, right: 64 }}>
  <svg width="64" height="64">...</svg>
</div>
// GSAP: gsap.to(decorEl, { rotation, scale, transformOrigin: "50% 50%" })
```

### MUST NOT

```tsx
// ❌ Bad — transformOrigin 누락 + GSAP 으로 위치까지 잡으려는 패턴
gsap.to(".decor", { rotation: 120, x: 200, y: 100, scale: 1.4 });  // drift 위험
```

### Grep audit

```bash
# GSAP rotation 적용 라인 색출 후 주위 ±5줄에서 transformOrigin 확인
grep -nE "gsap\.(to|fromTo)\([^)]*rotation" <project>/app -A 5 | grep -B 5 "rotation" | grep -E "transformOrigin|^--$"
# transformOrigin 없는 매치는 수동 fix
```

---

## Category E — Reduced motion as parallel design (v1.9.6 rename)

> **v1.9.6 paradigm shift**: reduced-motion 은 "motion 끔" (disable flag) 이 아니라 **"동등한 정보 전달 + 다른 visual layer"** (parallel design) — Cassie Evans (GSAP team) via Thibault Guignand (Codrops 2026-05-06) verbatim:
> "When you turn motion off, the design must still communicate everything the motion communicated. Color, typography, layout, and copy must do the heavy lifting."
>
> 즉, motion 이 brand identity 전달의 핵심이라면 reduced-motion 버전도 색·타이포·레이아웃 만 으로 같은 메시지 전달 가능해야. 단순 `if (reduce) return;` 으로 hero 가 invisible 되는 패턴 = fail.

### E1 — `gsap.matchMedia()` wrapping 의무 (v1.9.6 신규)

snippet #36 `matchMedia-reduced-motion` verbatim 적용 — 단순 useReducedMotion 분기 보다 강력:
- viewport / preference 변경 시 자동 cleanup + rebuild
- 동일 timeline 의 두 variant (full / reduced) 동시 정의
- React 와 무관하게 GSAP 차원에서 lifecycle 관리

### E2 — WCAG 2.2.2 in-page toggle (auto-play 5초+ 시 의무)

브라우저 preference 가 default, 단 in-page toggle 도 제공 의무:
- 5초 이상 auto-play 또는 loop 하는 motion (Lenis smooth scroll / Ken Burns / particle / autoplay video) 은 사용자가 페이지 내에서 stop 가능해야 함
- Top-right corner 의 단순 button `[ pause motion ]` 또는 ESC keystroke 지원
- system preference + in-page toggle = OR (둘 중 하나라도 reduce 면 reduced variant)

### E3 — `aria-live="polite"` on SplitText reveal

SplitText 가 chars 단위 reveal 시 screen reader 가 글자 단위 announce — accessibility 무너짐:
- SplitText container 에 `aria-live="off"` + `aria-label="<원본 텍스트>"` 의무
- Original headline text 는 hidden `<span>` 으로 보존, visually 보이는 chars 는 `aria-hidden="true"`
- Reveal 완료 후 `aria-live="polite"` 로 전환 가능 (선택)

### E4 — Focus visible dark/light variant

`prefers-color-scheme: dark` + `prefers-reduced-motion: reduce` 조합 시 focus ring 가독성 검증:
- focus ring 이 background 와 contrast WCAG 4.5:1 자동 충족하도록 dark/light variant 분리 정의
- `outline: 2px solid color-mix(in srgb, var(--brand-accent), white 30%)` 같은 adaptive 사용

### Trap (기존 v1.7.0)

motion 강제 종료 메커니즘이 JS gate (Framer `useReducedMotion()` / `window.matchMedia`) 만 박혀있고 CSS `@media (prefers-reduced-motion: reduce)` 빠지면 — 또는 그 반대 — accessibility 검수 실패 + 일부 motion 이 stop 안 됨.

### MUST USE

두 layer 모두 작성:

```tsx
import { useReducedMotion } from "motion/react";

export function MyHero() {
  const reduce = useReducedMotion();

  useGSAP(() => {
    if (reduce) return;  // JS gate — GSAP / anime.js init skip
    // ... motion setup ...
  }, [reduce]);

  return (
    <>
      <style>{`
        /* CSS gate — 모든 transition / animation 0.01ms 로 clamp */
        @media (prefers-reduced-motion: reduce) {
          *, *::before, *::after {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
            scroll-behavior: auto !important;
          }
        }
      `}</style>
      {/* ... */}
    </>
  );
}
```

### MUST NOT

- JS gate 만 박고 CSS 누락 — non-Framer CSS transition (`.btn:hover { transition: ... }`) 가 reduced motion 무시
- CSS 만 박고 JS gate 누락 — GSAP / anime.js timeline 이 스스로 0.01ms 로 clamp 안 됨

### Grep audit

```bash
# useReducedMotion 있는 파일에 CSS @media 빠진 경우 색출
grep -lE "useReducedMotion\(\)" <project>/app | xargs grep -L "prefers-reduced-motion"
# 매치 시 해당 파일에 CSS @media 블록 추가
```

---

## Pre-commit audit checklist (designer agent 의무)

코드 생성 완료 후 다음 5 명령 모두 실행. 매치 시 수동 fix 또는 명시적 사유 보고:

```bash
# A. Text overflow
grep -rnE "\.(word|char|line)-wrap[^{]*\{[^}]*overflow:\s*hidden" <project>/app <project>/components 2>/dev/null

# B. useGSAP scope (수동 확인 필요)
grep -lE "useGSAP\([^,]+,\s*\{\s*scope:" <project>/app 2>/dev/null | while read f; do
  echo "=== $f ==="
  grep -nE "gsap\.(to|from|fromTo|set)\(\"[#.]|ScrollTrigger\.batch\(\"[#.]" "$f"
done

# C. Motion stacking (anime + GSAP rotation 공존)
grep -lE "svg\.morphTo|createTimeline" <project>/app 2>/dev/null | while read f; do
  if grep -qE "gsap\.(to|from|fromTo).*rotation" "$f"; then
    echo "POTENTIAL STACK CONFLICT: $f"
    grep -nE "svg\.morphTo|gsap\.(to|fromTo).*rotation" "$f"
  fi
done

# D. transformOrigin 누락
grep -rnE "gsap\.(to|fromTo)\([^)]*rotation" <project>/app -A 5 2>/dev/null | grep -B 1 "rotation" | grep -v "transformOrigin" | grep "rotation"

# E. reduced-motion 한쪽 누락
grep -lE "useReducedMotion\(\)" <project>/app 2>/dev/null | xargs grep -L "prefers-reduced-motion" 2>/dev/null
```

각 명령의 매치 결과를 designer 리포트의 "Pre-commit audit" 섹션에 verbatim 박을 것. 0 매치 또는 모두 의도된 예외 사유 (`# OK — sibling, not stacked` 같은 inline 주석) 가 코드에 있어야 작업 완료.

---

## 관련 DSP

각 DSP body 마지막에 다음 짧은 reference 박힘:

```markdown
## 구현 Guardrails

상위 `prompts/design/_guardrails.md` 의 5 카테고리 (Text overflow / useGSAP scope / Motion stacking / Absolute positioning / Reduced motion) 모두 적용. 본 DSP 특이 사항만 추가 기재.
```

DSP-specific 추가 룰 있으면 그 DSP 본문에 박고, 공통은 본 문서에 박는다.

---

## Category G — Production-hostile patterns (v1.9.4)

2026-05-17 studiomeyer "Web Design Trends I Stopped Believing In" reality check + line25.com 2026-04-16 트렌드 디스카운트 + cssshowcase 2024-2026 production audit 기반. **Demo / Awwwards 에서는 흔하지만 production 에선 거의 안 ship 하는 패턴 명시화**. designer agent 가 production-grade DSP (B2B SaaS / fintech / commerce / enterprise) 적용 시 차단.

### G.1 Elastic / bouncy spring 어디나 적용

**Trap**: `ease: 'elastic.out(1, 0.5)'` 또는 Framer `transition={{ type: 'spring', bounce: 0.5 }}` 를 모든 hover · transition · CTA 에 적용. 사용자 cursor 가 닿는 모든 element 가 튕김 — production 에서 noise + 멀미.

**Production reality** (Maxima Therapy 자체도 elastic.out 을 CTA 한정 — 모든 hover 아님):
- B2B SaaS · enterprise 도구 · fintech dashboard 에서 elastic 등장 ≈ unprofessional 시그널
- 사용자 frequent interaction (10+ /min) 시 motion sickness 누적

**MUST USE**:
- `ease: 'expo.out'` / `'power2.out'` / `'cubic-bezier(...)'` brand-specific curve 가 default
- elastic.out 은 **단발성 hero CTA 1개** 또는 **child playful illustrated DSP** 한정
- B2B / fintech / saas / corporate / medical DSP 에서는 사용 금지

**MUST NOT**:
```tsx
// ❌ Bad — 모든 hover 에 elastic
gsap.to('.card', { scale: 1.1, ease: 'elastic.out(1, 0.5)', duration: 0.8 });
// ✅ Good — expo / power
gsap.to('.card', { scale: 1.03, ease: 'expo.out', duration: 0.35 });
```

**Grep audit**:
```bash
# Count elastic.out usage
COUNT=$(grep -rcE "elastic\.(out|in|inOut)" <project>/app | awk -F: '{s+=$2} END {print s+0}')
# B2B / fintech / corporate / medical DSP 라면 COUNT > 0 시 수동 확인
# Playful illustrated DSP 라면 COUNT ≤ 2 (CTA 한정) 기대
```

---

### G.2 Glassmorphism heavy (`backdrop-blur-xl`)

**Trap**: 모든 card / nav / modal 에 `backdrop-filter: blur(40px)` + low-opacity bg + transparency.

**Production reality** (studiomeyer 2026-05-17 verbatim):
> "`backdrop-filter: blur()` is still computationally expensive… 15 to 30 percent FPS drops on real user devices… did not become the dominant treatment for hero sections."

- iOS Safari · old Android · Windows IE Edge 호환성 이슈
- Layered glassmorphism (nav + modal + card 모두) → composite layer 비대화 → janky scroll
- Apple SwiftUI mimicry 의 가장 흔한 production failure

**MUST USE**:
- DSP 가 명시적으로 glass surface 정의 한 경우만 (e.g. Apple Vision Pro 시연 DSP) 한정
- 그 외에는 hairline border + 단색 surface tier
- `backdrop-filter: saturate(140%) blur(8px)` 같은 가벼운 surface 만 nav sticky 한정 OK

**MUST NOT**:
```css
/* ❌ Bad — heavy glass everywhere */
.card { backdrop-filter: blur(40px) saturate(180%); background: rgba(255,255,255,0.1); }
.modal { backdrop-filter: blur(60px); }
.nav { backdrop-filter: blur(30px); }
/* ✅ Good — minimal */
.nav-sticky { backdrop-filter: saturate(140%) blur(8px); }
.card { background: oklch(0.97 0.004 250); border: 1px solid oklch(0 0 0 / 0.06); }
```

**Grep audit**:
```bash
grep -rcE "backdrop-filter:\s*blur\([2-9][0-9]+px|blur\([1-9][0-9]{2,}px" <project>/app
# Match > 1 시 production-hostile glass — 수동 검증
```

---

### G.3 Organic blob hero / abstract gradient blob

**Trap**: Hero background 가 organic blob shape (Spline 3D / SVG `<filter>` morph) + multi-color gradient.

**Production reality** (studiomeyer verbatim):
> "almost never ship on B2B SaaS, e-commerce or any conversion-critical flow."

- AI generation cliché — 사용자가 즉시 "ChatGPT 가 만든 사이트" 인지
- 전환율 (conversion) 무관 visual noise
- Color theory · brand discipline 부재 시그널

**MUST USE**:
- Photographic hero OR brutalist typography OR product mockup OR R3F 3D scene (vehicle / hardware)
- Solid color + hairline grid + brand accent 만

**MUST NOT**:
```tsx
// ❌ Bad — organic blob hero
<div className="absolute inset-0 -z-10">
  <svg viewBox="0 0 800 800">
    <filter id="blob"><feTurbulence ... /></filter>
    <ellipse fill="url(#rainbow-gradient)" filter="url(#blob)" />
  </svg>
</div>
```

**Grep audit**:
```bash
grep -rnE "feTurbulence|blob-bg|organic-blob|conic-gradient" <project>/app
# Match ≥ 1 + DSP 가 B2B/SaaS/commerce/enterprise/medical 면 fail
```

---

### G.4 3D / WebGL hero everywhere

**Trap**: 모든 페이지 hero 에 Spline embed 또는 Three.js scene.

**Production reality** (studiomeyer verbatim):
> "a site with a single Spline scene in the hero loads 800kB to 2MB of JavaScript runtime before the user sees anything. Lighthouse scores [drop]."

- 800kB-2MB JS bundle before user sees anything → Lighthouse Performance 절단
- Mobile / low-end device 에서 unusable
- WebGL context creation 실패 시 white screen
- Battery drain mobile

**MUST USE**:
- 3D scene 은 cinematic-immersion-auto / luxury hardware / 3D product configurator DSP 한정
- Mobile 에서 static image fallback 의무 (`matchMedia("(max-width: 768px)")` gate)
- `requestIdleCallback` 또는 user gesture 후 lazy mount
- Lighthouse Performance 90+ 유지 (mobile 4G throttle)
- B2B SaaS / fintech / commerce / editorial / medical DSP 에서 사용 금지

**MUST NOT**:
```tsx
// ❌ Bad — eager Spline mount on every page
import Spline from '@splinetool/react-spline';
export default function Page() {
  return <Spline scene="https://.../hero.splinecode" />;  // 2MB runtime
}
```

**Grep audit**:
```bash
grep -rnE "@splinetool|three\.module|fiber" <project>/app
# Match + DSP 가 cinematic-immersion-auto 외 다른 DSP 면 fail
```

---

### G.5 Rainbow gradient / multi-saturated accent

**Trap**: Hero / CTA 에 `linear-gradient(45deg, #ff0080, #7928ca, #00d4ff)` 같은 3-color saturated gradient.

**Production reality**: 2026 award sites 단일 accent + 무채색 99%. Rainbow gradient 는 2018-2020 Stripe mimicry 의 잔재.

**MUST USE**:
- 단일 accent (DSP token 정의된 oklch 색) 만
- 무채색 + 1 accent 가 award trend
- Gradient 사용 시 monochrome variation 만 (예: 같은 hue 의 brighter→darker)

**MUST NOT**:
```css
/* ❌ Bad — rainbow gradient */
.cta { background: linear-gradient(45deg, #ff0080, #7928ca, #00d4ff); }
.hero-bg { background: conic-gradient(from 0deg, magenta, cyan, yellow); }
/* ✅ Good — monochrome variation */
.cta { background: linear-gradient(45deg, oklch(0.55 0.20 28), oklch(0.65 0.20 28)); }
```

**Grep audit**:
```bash
grep -rnE "linear-gradient\([^)]*,[^)]*,[^)]*,[^)]*,[^)]*," <project>/app  # 3+ color
grep -rnE "conic-gradient|radial-gradient.*saturated" <project>/app
```

---

### G.6 Kinetic typography 모든 섹션 강제

**Trap**: 모든 섹션 headline + body 에 SplitText chars stagger + scroll-driven kinetic animation.

**Production reality** (studiomeyer 2026-05-17 verbatim):
> "Kinetic typography is everywhere as a demo on Awwwards and Dribbble. It almost never ships in production. The reason is simple: animated text fights screen readers, fights search crawlers, and adds layout shift that destroys Core Web Vitals scores. Real teams use it sparingly, on hero headlines and section transitions."

**MUST USE**:
- SplitText 는 hero headline + key section transition 1-2개 한정
- Body / long-form text 는 정적 표시 (또는 line-level mask 만)
- `aria-hidden` + 정적 alternative text 의무
- Core Web Vitals (CLS · LCP) 영향 확인

**MUST NOT**:
- 모든 `<p>` `<h2>` `<h3>` 에 SplitText chars 적용
- Body text scrambling / typewriter

**Grep audit**:
```bash
grep -c "new SplitText\|SplitText.create" <project>/app/<route>/*.tsx
# Count > 5 in single route + non-hero usage = production-hostile
```

---

### G.7 Auto-play 3D / Auto-play video with sound

**Trap**: Hero 가 mount 시 즉시 3D scene 시작 + 사용자 interaction 없이 video 음성 재생.

**Production reality**:
- 사용자 불쾌 (특히 회사 office / public space 에서 brand 사이트 방문)
- Browser auto-play policy 변경 (Chrome 2018+, Safari 2020+) — muted only
- Battery drain · CPU spike on page load
- Accessibility 위반

**MUST USE**:
- 3D scene 은 user gesture (scroll / click) 후 시작
- Auto-play video 는 `muted + playsinline + loop` 의무
- 사용자가 play 컨트롤 가능
- `prefers-reduced-motion: reduce` 존중

**MUST NOT**:
```tsx
// ❌ Bad
<video src="hero.mp4" autoPlay />  // unmuted, no controls
```

---

### G.8 Mobile parallax / pin (v1.9.6 신규)

**Trap**: 데스크톱에서 잘 작동하는 `ScrollTrigger pin + scrub` 또는 `parallax` 를 mobile (≤ 768px) 에 그대로 적용.

**Production reality** (Web.dev mobile UX 2026 + UXPin):
- iOS Safari 의 `scroll-behavior: smooth` 와 ScrollTrigger pin 충돌 — janky scroll
- 모바일 viewport 가 100dvh 인데 pin spacing 이 100vh 로 계산되면 address bar 크기만큼 mismatch
- Touch scroll 의 native momentum 이 GSAP scrub 와 race → motion drift
- 모바일 사용자는 horizontal carousel 도 swipe 로 인식 안 함

**MUST USE**:
- `gsap.matchMedia()` 안에서 `(min-width: 769px)` branch 에만 pin / parallax / horizontal scroll 활성화
- Mobile branch 는 단순 vertical scroll + 짧은 fade reveal 만
- `100dvh` 사용 (100vh 대신) for pin spacing on mobile

**MUST NOT**:
```tsx
// ❌ Bad — pin + scrub everywhere
gsap.timeline({
  scrollTrigger: { trigger: ".hero", pin: true, scrub: 1, start: "top top" }
});

// ✅ Good — matchMedia branching
gsap.matchMedia().add("(min-width: 769px)", () => {
  // pin + scrub only on desktop
}).add("(max-width: 768px)", () => {
  // simple fade only
});
```

**Grep audit**:
```bash
# Pin/scrub 사용한 파일에서 matchMedia branch 누락 검출
grep -lE "pin:\s*true|scrub:" <project>/app | while read f; do
  if ! grep -q "matchMedia.*min-width\|matchMedia.*max-width" "$f"; then
    echo "POTENTIAL G.8: $f has pin/scrub WITHOUT matchMedia mobile branch"
  fi
done
```

---

### G.9 Cursor effects without `hover:hover` gate (v1.9.6 신규)

**Trap**: Custom cursor / magnetic CTA / trail cursor 를 mobile · touch 디바이스에 그대로 적용.

**Production reality**:
- Mobile 에 cursor 자체 없음 — magnetic CTA 가 touch 와 충돌 → CTA 가 사용자 손가락 따라 미세하게 움직임 → 의도된 motion 아닌 글리치
- `@media (hover: hover) and (pointer: fine)` 가 native CSS gate — JS 로도 동일 매칭 필요

**MUST USE**:
- 모든 cursor-related JS effect 를 `window.matchMedia("(hover: hover) and (pointer: fine)").matches` 로 gate
- Custom cursor `<div>` 자체를 `@media (hover: hover) and (pointer: fine)` 에서만 render
- Magnetic CTA 의 mouse position handler 도 동일 gate

**MUST NOT**:
```tsx
// ❌ Bad — magnetic CTA 가 mobile 에서도 작동
<motion.button onMouseMove={handleMagnetic}>...</motion.button>

// ✅ Good — hover:hover gate
const canHover = useMemo(() =>
  typeof window !== "undefined" &&
  window.matchMedia("(hover: hover) and (pointer: fine)").matches,
  []
);
<motion.button onMouseMove={canHover ? handleMagnetic : undefined}>...</motion.button>
```

**Grep audit**:
```bash
# Cursor / magnetic / trail 사용 검출 후 hover:hover gate 확인
grep -rE "magnetic|trail-cursor|onMouseMove" <project>/app | grep -v "node_modules" | while read line; do
  file=$(echo "$line" | cut -d: -f1)
  if ! grep -q "(hover: hover)" "$file"; then
    echo "POTENTIAL G.9: $file uses cursor effect WITHOUT hover:hover gate"
  fi
done
```

---

### G.10 Audio autoplay with sound (v1.9.6 신규 — strict reinforcement of G.7)

**Trap**: Hero 의 video / 3D scene 이 mount 시 즉시 audio 재생.

**Production reality**:
- Chrome / Safari / Firefox 모두 autoplay policy: muted only on initial mount (user gesture 필요)
- Audio context API 도 동일 — user gesture 없이 resume 시 silent fail
- Battery drain / data usage / public space 에서 사용자 embarrassment

**MUST USE**:
- 모든 `<video>` 에 `muted + playsinline + loop` 의무
- Audio 활성화는 explicit user gesture (play button click) 후 만
- 사용자에게 `Audio: off` toggle visible (top-right corner pill 등)
- `prefers-reduced-motion: reduce` 일 때 video 도 정지

**MUST NOT**:
```tsx
// ❌ Bad — unmuted autoplay
<video src="hero.mp4" autoPlay loop />

// ❌ Bad — AudioContext().resume() without user gesture
useEffect(() => {
  const ctx = new AudioContext();
  ctx.resume();  // silent fail on Chrome 100+
}, []);

// ✅ Good — muted autoplay + user-gesture audio
<video src="hero.mp4" autoPlay loop muted playsInline />

const enableAudio = () => {
  audioRef.current?.play();  // inside onClick handler — gesture context
};
```

**Grep audit**:
```bash
# autoPlay 사용 검출, muted 동반 안 됨 시 fail
grep -rnE "autoPlay" <project>/app | grep -v "muted" | head -10
```

---

## Category G summary

Production-hostile patterns 검출 종합 grep audit:

```bash
PROJECT_DIR=<project>/app/<route>

# G.1 elastic everywhere
ELASTIC=$(grep -rcE "elastic\.(out|in|inOut)" "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')
# G.2 heavy glass
GLASS=$(grep -rcE "backdrop-filter:\s*blur\(([2-9][0-9]|[1-9][0-9]{2,})px" "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')
# G.3 organic blob
BLOB=$(grep -rcE "feTurbulence|blob-bg|organic-blob|conic-gradient" "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')
# G.4 3D everywhere (DSP-conditional)
WEBGL=$(grep -rcE "@splinetool|three\.module|fiber" "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')
# G.5 rainbow gradient
RAINBOW=$(grep -rcE "linear-gradient\([^)]*,[^)]*,[^)]*,[^)]*,[^)]*," "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')
# G.6 SplitText 도배
SPLIT=$(grep -rcE "new SplitText|SplitText\.create" "$PROJECT_DIR" | awk -F: '{s+=$2} END {print s+0}')

echo "G.1 elastic: $ELASTIC   G.2 glass: $GLASS   G.3 blob: $BLOB   G.4 webgl: $WEBGL   G.5 rainbow: $RAINBOW   G.6 split: $SPLIT"

# 판정 룰:
# - B2B SaaS / fintech / corporate / medical DSP: ELASTIC > 1 또는 WEBGL > 0 또는 BLOB > 0 또는 RAINBOW > 0 → fail
# - 모든 DSP: GLASS > 2 → fail (1개는 sticky nav 한정 OK)
# - 모든 DSP: SPLIT > 5 / route → 수동 hero/section 한정 확인
```

각 카테고리 매치 시 designer agent 가 reporting 의 "Pre-commit audit" 섹션에 verbatim 박고, 의도된 사용이면 사유 명시. 의도 안 된 production-hostile 패턴은 fix 후 재실행.

### Reference

- studiomeyer 2026-05-17 "Web Design Trends I Stopped Believing In" — verbatim quotes 위 인용
- line25.com 2026-04-16 — "All major animations are duplicated with reduced-motion versions"
- 3str.net 2026 — "production-ready pattern combines CSS scroll-driven animations as baseline with GSAP ScrollTrigger as enhancement"
- gsap.com/showcase 15-site analysis (2026-05-20) — `13-Wiki/research/2026-05-20-gsap-showcase-research.md`

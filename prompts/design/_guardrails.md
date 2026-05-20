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
      ScrollTrigger.batch(tileNodes, { onEnter: batch => gsap.from(batch, { ... }) });
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

## Category E — prefers-reduced-motion full audit

### Trap

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

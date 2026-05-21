---
name: motion-snippets
description: 모든 motion-heavy DSP가 reference하는 verbatim TypeScript/React 코드 snippet 카탈로그. abstract "GSAP 사용" 표현으로는 LLM 이 CSS keyframes fallback 하므로, 실제 production code를 박아 LLM이 그대로 copy-paste 하도록 강제.
version: v1.9.0
---

# Motion Implementation Snippets

GSAP / anime.js v4 / Framer Motion / Lenis 의 production-grade verbatim code. DSP body 에서 "ScrollTrigger pin" 같은 텍스트가 등장하면 그 옆에 본 카탈로그의 snippet 번호를 reference (`→ snippet #4 verbatim 적용`).

각 snippet 은:
- 즉시 copy-paste 가능한 완성 TypeScript
- `_guardrails.md` 5 카테고리 (italic clip / useGSAP scope / motion stacking / transformOrigin / reduced-motion) 통과
- 마커 `<!-- motion-snippet: name=<id> stack=<gsap|anime|framer|lenis> -->` 로 grep audit 가능

---

## Snippet 1 — Package setup (모든 motion-heavy 프로젝트 공통)

<!-- motion-snippet: name=package-setup stack=mixed -->

```bash
# 의무 (모든 agency-portfolio / editorial / cinematic 톤)
npm install gsap @gsap/react
# Framer Motion 도 magnetic CTA / reduced-motion gate 용
npm install motion
# anime.js v4 (path morph 등)
npm install animejs
# 선택: 전역 inertia scroll
npm install lenis
```

**중요**: GSAP 3.13+ 부터 ScrollTrigger / SplitText / DrawSVG / Flip / CustomEase / MotionPath / ScrollSmoother 등 club plugin 이 **무료**. 별도 패키지 설치 불필요 — 모두 `gsap/<PluginName>` 로 import.

---

## Snippet 2 — GSAP plugin register (한 곳에서 등록)

<!-- motion-snippet: name=gsap-register stack=gsap -->

```tsx
"use client";

import { gsap } from "gsap";
import { useGSAP } from "@gsap/react";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { SplitText } from "gsap/SplitText";
import { DrawSVGPlugin } from "gsap/DrawSVGPlugin";
import { CustomEase } from "gsap/CustomEase";
import { Flip } from "gsap/Flip";

// 한 번만 등록 (SSR 안전 가드)
if (typeof window !== "undefined") {
  gsap.registerPlugin(
    useGSAP,
    ScrollTrigger,
    SplitText,
    DrawSVGPlugin,
    CustomEase,
    Flip,
  );
  // Brand signature curve — 모든 reveal 에 재사용
  if (!CustomEase.get("brand")) {
    CustomEase.create("brand", "M0,0 C0.86,0 0.07,1 1,1");
  }
}
```

**MUST USE**: 모든 hero / page 컴포넌트 상단에 박아라. `import` 없이 `gsap.to(...)` 호출하면 동작 안 함.

---

## Snippet 3 — SplitText hero reveal (chars stagger slide-up)

<!-- motion-snippet: name=splittext-hero stack=gsap -->

```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { SplitText } from "gsap/SplitText";
import { useReducedMotion } from "motion/react";

// 부모 컴포넌트 어딘가:
const heroRef = useRef<HTMLDivElement | null>(null);
const headlineRef = useRef<HTMLHeadingElement | null>(null);
const reduce = useReducedMotion();

useGSAP(
  () => {
    if (reduce) return;  // Category E — JS gate

    if (!headlineRef.current) return;
    const split = new SplitText(headlineRef.current, {
      type: "chars,words",
      charsClass: "split-char",
      wordsClass: "split-word",
    });

    gsap.set(split.chars, { yPercent: 100, opacity: 0 });
    gsap.to(split.chars, {
      yPercent: 0,
      opacity: 1,
      duration: 1.0,
      stagger: 0.030,
      ease: "brand",  // CustomEase 등록된 브랜드 곡선
      delay: 0.15,
    });

    return () => {
      split.revert();  // cleanup (HMR 안전)
    };
  },
  { scope: heroRef, dependencies: [reduce] },
);

// JSX:
<section ref={heroRef}>
  <h1 ref={headlineRef} className="hero-headline">
    Selected work, built to outlast.
  </h1>
</section>
```

**Category A guardrail** — `.split-word` CSS 는 반드시 `clip-path` (overflow:hidden 금지):

```css
.split-word {
  display: inline-block;
  line-height: 0.95;
  padding-bottom: 0.05em;
  clip-path: inset(-0.15em -0.4em 0 -0.4em);
}
.split-char {
  display: inline-block;
  will-change: transform, opacity;
}
```

---

## Snippet 4 — ScrollTrigger pin/scrub hero (multi-stage timeline)

<!-- motion-snippet: name=scrolltrigger-pin stack=gsap -->

```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

const heroRef = useRef<HTMLDivElement | null>(null);
const reduce = useReducedMotion();

useGSAP(
  () => {
    if (reduce) return;
    if (!heroRef.current) return;

    // Multi-stage timeline tied to scroll. scrub:1 으로 부드러운 스크롤-바인딩.
    const heroTl = gsap.timeline({
      scrollTrigger: {
        trigger: heroRef.current,
        start: "top top",
        end: "+=120%",        // 핀 구간 = viewport 1.2배
        scrub: 1,             // 1초 ease 보간
        pin: true,
        pinSpacing: true,
        invalidateOnRefresh: true,
      },
    });

    // Stage 1 (0 → 30%): 메타 블록 위로 빠르게 (parallax)
    heroTl.to(".hero-meta-line", { y: -120, ease: "none", duration: 3 }, 0);

    // Stage 2 (20 → 60%): 헤드라인 살짝 위 + scale 축소
    heroTl.to(
      ".hero-headline",
      { y: -60, scale: 0.97, opacity: 0.4, ease: "none", duration: 4 },
      2,
    );

    // Stage 3 (40 → 100%): 전체 hero opacity 페이드아웃
    heroTl.fromTo(
      heroRef.current,
      { opacity: 1 },
      { opacity: 0.35, ease: "none", duration: 6 },
      4,
    );
  },
  { scope: heroRef, dependencies: [reduce] },
);
```

**Category B guardrail** — `.hero-meta-line` 가 `heroRef` 안에 있으면 string selector 가능. **외부 element** 면 `document.querySelector` 로 ref 전달 필수.

---

## Snippet 5 — Full-page scroll progress bar (외부 element)

<!-- motion-snippet: name=scroll-progress-bar stack=gsap -->

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

const heroRef = useRef<HTMLDivElement | null>(null);

useGSAP(
  () => {
    // ❗ Category B — progress bar 는 heroRef 외부 → document.querySelector
    const progressBarEl = document.querySelector<HTMLElement>(
      "#scroll-progress",
    );
    if (!progressBarEl) return;

    gsap.to(progressBarEl, {
      scaleX: 1,
      ease: "none",
      scrollTrigger: {
        start: 0,
        end: () => ScrollTrigger.maxScroll(window),
        scrub: true,
        invalidateOnRefresh: true,
      },
    });
  },
  { scope: heroRef },
);

// JSX (heroRef 의 sibling, document body 직속):
<div
  id="scroll-progress"
  aria-hidden
  style={{
    position: "fixed",
    top: 0,
    left: 0,
    right: 0,
    height: 2,
    background: "var(--brand-accent)",
    zIndex: 50,
    transformOrigin: "left center",
    transform: "scaleX(0)",
    pointerEvents: "none",
  }}
/>
```

---

## Snippet 6 — DrawSVG monogram / signature path reveal

<!-- motion-snippet: name=drawsvg-monogram stack=gsap -->

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { DrawSVGPlugin } from "gsap/DrawSVGPlugin";

useGSAP(() => {
  if (reduce) return;

  const monogramPaths = gsap.utils.toArray<SVGPathElement>(
    "#brand-monogram [data-draw]",
  );
  if (!monogramPaths.length) return;

  gsap.set(monogramPaths, { drawSVG: "0%" });
  gsap.to(monogramPaths, {
    drawSVG: "100%",
    duration: 1.6,
    ease: "power2.inOut",
    stagger: 0.18,
  });
}, { scope: heroRef, dependencies: [reduce] });

// JSX:
<svg
  id="brand-monogram"
  width="28"
  height="28"
  viewBox="0 0 32 32"
  fill="none"
  stroke="currentColor"
  strokeWidth="1.75"
  strokeLinecap="square"
>
  <path data-draw d="M3 6 L29 6 L29 14 L3 14 L3 26 L29 26" />
  <path data-draw d="M16 6 L16 26" />
</svg>
```

---

## Snippet 7 — ScrollTrigger.batch (tile staggered reveal on scroll)

<!-- motion-snippet: name=scrolltrigger-batch stack=gsap -->

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

useGSAP(() => {
  if (reduce) return;

  // ❗ Category B — tiles 가 useGSAP scope 외부면 document.querySelectorAll
  const tileNodes = Array.from(
    document.querySelectorAll<HTMLElement>(".project-tile"),
  );
  if (!tileNodes.length) return;

  // v1.9.5 fix — `gsap.from + onEnter` skips already-in-view tiles.
  // Use gsap.set + gsap.to + manual reveal for in-view.
  gsap.set(tileNodes, { opacity: 0, y: 80, scale: 0.96 });

  ScrollTrigger.batch(tileNodes, {
    start: "top 95%",
    onEnter: (batch) =>
      gsap.to(batch, {
        opacity: 1,
        y: 0,
        scale: 1,
        duration: 0.95,
        stagger: 0.12,
        ease: "brand",
        overwrite: "auto",
      }),
  });

  // tiles already in viewport at load — manually reveal (onEnter won't fire).
  ScrollTrigger.refresh();
  tileNodes.forEach((tile) => {
    if (tile.getBoundingClientRect().top < window.innerHeight * 0.95) {
      gsap.to(tile, {
        opacity: 1,
        y: 0,
        scale: 1,
        duration: 0.95,
        ease: "brand",
        overwrite: "auto",
      });
    }
  });

  // 각 tile inner image 에 scrub parallax
  tileNodes.forEach((tile) => {
    const inner = tile.querySelector<HTMLElement>(".tile-inner");
    if (!inner) return;
    gsap.to(inner, {
      yPercent: -12,
      ease: "none",
      scrollTrigger: {
        trigger: tile,
        start: "top bottom",
        end: "bottom top",
        scrub: 0.8,
      },
    });
  });
}, { scope: heroRef, dependencies: [reduce] });
```

---

## Snippet 8 — Magnetic CTA (Framer Motion spring)

<!-- motion-snippet: name=magnetic-cta stack=framer -->

```tsx
"use client";

import { useRef, type MouseEvent as ReactMouseEvent } from "react";
import { motion, useMotionValue, useReducedMotion } from "motion/react";

export function MagneticCTA({
  children,
  href,
}: {
  children: React.ReactNode;
  href: string;
}) {
  const ref = useRef<HTMLAnchorElement | null>(null);
  const reduce = useReducedMotion();
  const x = useMotionValue(0);
  const y = useMotionValue(0);

  const handleMouseMove = (e: ReactMouseEvent<HTMLAnchorElement>) => {
    if (reduce || !ref.current) return;
    const rect = ref.current.getBoundingClientRect();
    const dx = e.clientX - (rect.left + rect.width / 2);
    const dy = e.clientY - (rect.top + rect.height / 2);
    x.set(dx * 0.22);
    y.set(dy * 0.30);
  };

  const handleMouseLeave = () => {
    x.set(0);
    y.set(0);
  };

  return (
    <motion.a
      ref={ref}
      href={href}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      whileTap={reduce ? undefined : { scale: 0.98 }}
      transition={{ type: "spring", stiffness: 150, damping: 15, mass: 0.1 }}
      style={{ x, y, display: "inline-flex", cursor: "pointer" }}
      className="magnetic-cta"
    >
      {children}
    </motion.a>
  );
}
```

**중요**: 한 페이지에 magnetic CTA 1개만 (primary). 모든 link 에 적용 시 노이즈.

---

## Snippet 9 — Marquee infinite scroll (Magic UI 패턴)

<!-- motion-snippet: name=marquee stack=framer -->

```tsx
"use client";

import { cn } from "@/lib/utils";  // tailwind-merge + clsx
import type { ComponentPropsWithoutRef, ReactNode } from "react";

interface MarqueeProps extends ComponentPropsWithoutRef<"div"> {
  pauseOnHover?: boolean;
  reverse?: boolean;
  vertical?: boolean;
  repeat?: number;
  children: ReactNode;
}

export function Marquee({
  pauseOnHover = true,
  reverse = false,
  vertical = false,
  repeat = 4,
  className,
  children,
  ...props
}: MarqueeProps) {
  return (
    <div
      {...props}
      className={cn(
        "group flex overflow-hidden p-2 [--duration:40s] [--gap:1rem]",
        "[gap:var(--gap)]",
        { "flex-row": !vertical, "flex-col": vertical },
        className,
      )}
    >
      {Array(repeat)
        .fill(0)
        .map((_, i) => (
          <div
            key={i}
            className={cn("flex shrink-0 justify-around [gap:var(--gap)]", {
              "animate-marquee flex-row": !vertical,
              "animate-marquee-vertical flex-col": vertical,
              "group-hover:[animation-play-state:paused]": pauseOnHover,
              "[animation-direction:reverse]": reverse,
            })}
          >
            {children}
          </div>
        ))}
    </div>
  );
}
```

```css
/* globals.css */
@keyframes marquee {
  from { transform: translateX(0); }
  to { transform: translateX(calc(-100% - var(--gap))); }
}
@keyframes marquee-vertical {
  from { transform: translateY(0); }
  to { transform: translateY(calc(-100% - var(--gap))); }
}
.animate-marquee { animation: marquee var(--duration) linear infinite; }
.animate-marquee-vertical { animation: marquee-vertical var(--duration) linear infinite; }
@media (prefers-reduced-motion: reduce) {
  .animate-marquee, .animate-marquee-vertical { animation-play-state: paused; }
}
```

---

## Snippet 10 — anime.js v4 SVG path morph

<!-- motion-snippet: name=anime-morph stack=anime -->

```tsx
"use client";

import { useEffect } from "react";
import { useReducedMotion } from "motion/react";
import { createTimeline, svg } from "animejs";

export function MorphingMark() {
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce) return;

    const target = document.querySelector<SVGPathElement>("#morph-target");
    if (!target) return;

    // ❗ Category C — anime.js loop 만 적용. 같은 wrapper 에 GSAP rotation 추가 금지.
    const tl = createTimeline({
      defaults: { duration: 2400, ease: "inOutQuad" },
      loop: true,
    });

    tl.add(target, { d: svg.morphTo("#morph-state-b") });
    tl.add(target, { d: svg.morphTo("#morph-state-c") });
    tl.add(target, { d: svg.morphTo("#morph-target") });

    return () => { tl.pause(); };
  }, [reduce]);

  return (
    <div aria-hidden style={{ position: "absolute", right: 64, top: 96 }}>
      <svg width="64" height="64" viewBox="0 0 96 96" fill="none">
        <defs>
          <path id="morph-state-b" d="M48 8 L88 48 L48 88 L8 48 Z" />
          <path id="morph-state-c" d="M8 8 L88 8 L48 88 Z" />
        </defs>
        <path
          id="morph-target"
          d="M8 8 L88 8 L88 88 L8 88 Z"
          stroke="var(--brand-accent)"
          strokeWidth="1.5"
          fill="none"
        />
      </svg>
    </div>
  );
}
```

---

## Snippet 11 — Lenis smooth scroll (전역 inertia)

<!-- motion-snippet: name=lenis-smooth stack=lenis -->

```tsx
"use client";

import { useEffect } from "react";
import Lenis from "lenis";

export function SmoothScrollProvider({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    // mobile 에서는 touch hijacking 방지 위해 disable
    if (window.matchMedia("(max-width: 768px)").matches) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    const lenis = new Lenis({
      duration: 1.2,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smoothWheel: true,
    });

    function raf(time: number) {
      lenis.raf(time);
      requestAnimationFrame(raf);
    }
    requestAnimationFrame(raf);

    return () => { lenis.destroy(); };
  }, []);

  return <>{children}</>;
}
```

**ScrollTrigger 와 동시 사용 시**: Lenis 의 scroll event 를 ScrollTrigger 에 동기화 — `ScrollTrigger.update` 를 Lenis raf 안에서 호출.

---

## Snippet 12 — prefers-reduced-motion full gate (JS + CSS 양 layer)

<!-- motion-snippet: name=reduced-motion stack=mixed -->

JS gate (Framer):

```tsx
import { useReducedMotion } from "motion/react";

const reduce = useReducedMotion();
if (reduce) return;  // 모든 motion init skip
```

CSS gate (모든 컴포넌트 root style 에 박힘):

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
  .split-char { transform: none !important; opacity: 1 !important; }
}
```

**Category E — 양쪽 모두 박지 않으면 fail.** JS gate 만으로는 CSS transition / keyframe 이 안 막힘.

---

## Snippet 13 — Variable font weight hover (nav links)

<!-- motion-snippet: name=variable-font-hover stack=css -->

```tsx
const variableWeightHover: CSSProperties = {
  fontVariationSettings: '"wght" 400',
  transition:
    "font-variation-settings 220ms cubic-bezier(0.86,0,0.07,1), color 220ms cubic-bezier(0.86,0,0.07,1)",
};

// CSS:
.nav-link:hover {
  font-variation-settings: 'wght' 510 !important;
  color: var(--brand-accent) !important;
}
```

Inter Variable / Geist Variable / Söhne Variable 등 variable font 가 import 되어 있어야 동작.

---

## Snippet 14 — Flip layout transition (project grid → detail)

<!-- motion-snippet: name=flip-layout stack=gsap -->

```tsx
"use client";

import { gsap } from "gsap";
import { Flip } from "gsap/Flip";

// 1. Capture before state
const state = Flip.getState(".project-tile, .project-tile img");

// 2. Mutate DOM (navigate, move element, change classes)
//    예: Next.js Link click → 별도 detail page 진입
//    실제로는 layout 변경 시점에 호출

// 3. Animate from captured state
Flip.from(state, {
  duration: 0.8,
  ease: "expo.inOut",
  absolute: true,
  onEnter: (elements) => gsap.fromTo(elements, { opacity: 0 }, { opacity: 1, duration: 0.5 }),
  onLeave: (elements) => gsap.to(elements, { opacity: 0, duration: 0.3 }),
});
```

---

## Snippet 15 — Ken Burns slow zoom (image hero on-load only)

<!-- motion-snippet: name=ken-burns-zoom stack=gsap -->

```tsx
"use client";

import { useEffect, useRef } from "react";
import { gsap } from "gsap";
import { useReducedMotion } from "motion/react";
import Image from "next/image";

export function KenBurnsHero({
  src,
  alt,
  duration = 2.0,
  scale = 1.05,
}: {
  src: string;
  alt: string;
  duration?: number;
  scale?: number;
}) {
  const ref = useRef<HTMLDivElement | null>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !ref.current) return;
    const wrap = ref.current.querySelector<HTMLElement>(".ken-burns-inner");
    if (!wrap) return;

    // Marketing hero exception — single playback, NO loop.
    // DSP rule: scale 1.0 → 1.05 over ≤2000ms ease-out.
    gsap.fromTo(
      wrap,
      { scale: 1.0 },
      { scale, duration, ease: "power2.out" },
    );
  }, [reduce, duration, scale]);

  return (
    <div
      ref={ref}
      aria-hidden
      style={{
        position: "absolute",
        inset: 0,
        overflow: "hidden",
        // z-index 0 (NOT negative) — negative z-index puts the wrapper
        // BELOW the parent's solid background and the image disappears.
        // Stacking order is controlled by sibling content using
        // position: relative + zIndex: 1+ (typography, CTAs, meta blocks).
        zIndex: 0,
      }}
    >
      <div className="ken-burns-inner" style={{ position: "absolute", inset: 0 }}>
        <Image
          src={src}
          alt={alt}
          fill
          priority
          sizes="100vw"
          style={{ objectFit: "cover" }}
        />
      </div>
    </div>
  );
}
```

**MUST USE**: hero photographic / video poster 자리에 slow Ken Burns 가 cinematic immersion 시그니처. K-pop / automotive / museum DSP 에서 활용. 단 loop 금지 — 단발 single playback. Marketing hero exception 외에는 자제.

---

## Snippet 16 — Horizontal scroll carousel (ScrollTrigger pin + horizontal translate)

<!-- motion-snippet: name=horizontal-scroll-carousel stack=gsap -->

```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

export function HorizontalCarousel({ children }: { children: React.ReactNode }) {
  const sectionRef = useRef<HTMLDivElement | null>(null);
  const trackRef = useRef<HTMLDivElement | null>(null);
  const reduce = useReducedMotion();

  useGSAP(
    () => {
      if (reduce) return;
      if (!sectionRef.current || !trackRef.current) return;

      const section = sectionRef.current;
      const track = trackRef.current;

      const getScrollDistance = () => {
        const totalWidth = track.scrollWidth;
        const visibleWidth = section.clientWidth;
        return Math.max(0, totalWidth - visibleWidth);
      };

      gsap.to(track, {
        x: () => -getScrollDistance(),
        ease: "none",
        scrollTrigger: {
          trigger: section,
          start: "top top",
          end: () => `+=${getScrollDistance()}`,
          pin: true,
          scrub: 1,
          invalidateOnRefresh: true,
        },
      });
    },
    { scope: sectionRef, dependencies: [reduce] },
  );

  return (
    <section
      ref={sectionRef}
      style={{ height: "100vh", overflow: "hidden", position: "relative" }}
    >
      <div
        ref={trackRef}
        style={{
          display: "flex",
          height: "100%",
          alignItems: "center",
          gap: "24px",
          paddingInline: "64px",
          willChange: "transform",
        }}
      >
        {children}
      </div>
    </section>
  );
}
```

**MUST USE**: cinematic immersion DSP (K-pop discography, automotive lineup, museum collection) 에서 vertical grid batch 대신 horizontal scroll-driven carousel 로 차별화. Section 자체가 viewport 100vh 차지 + scroll = horizontal pan.

---

## Snippet 17 — 3D tilt card hover (Framer Motion useSpring + mouse position)

<!-- motion-snippet: name=tilt-3d-hover stack=framer -->

```tsx
"use client";

import { useRef, type MouseEvent as ReactMouseEvent } from "react";
import { motion, useMotionValue, useSpring, useTransform, useReducedMotion } from "motion/react";

export function TiltCard({
  children,
  intensity = 10,
}: {
  children: React.ReactNode;
  intensity?: number;
}) {
  const ref = useRef<HTMLDivElement | null>(null);
  const reduce = useReducedMotion();
  const x = useMotionValue(0);
  const y = useMotionValue(0);

  const rotateY = useTransform(x, [-100, 100], [-intensity, intensity]);
  const rotateX = useTransform(y, [-100, 100], [intensity, -intensity]);

  const spring = { stiffness: 150, damping: 20, mass: 0.5 };
  const sx = useSpring(rotateX, spring);
  const sy = useSpring(rotateY, spring);

  const handleMouseMove = (e: ReactMouseEvent<HTMLDivElement>) => {
    if (reduce || !ref.current) return;
    const rect = ref.current.getBoundingClientRect();
    const cx = rect.left + rect.width / 2;
    const cy = rect.top + rect.height / 2;
    x.set(e.clientX - cx);
    y.set(e.clientY - cy);
  };

  const handleMouseLeave = () => {
    x.set(0);
    y.set(0);
  };

  return (
    <motion.div
      ref={ref}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      style={{
        rotateX: reduce ? 0 : sx,
        rotateY: reduce ? 0 : sy,
        transformPerspective: 1000,
        transformStyle: "preserve-3d",
      }}
    >
      {children}
    </motion.div>
  );
}
```

**MUST USE**: roster / member / artist card hover signature. K-pop / e-sports / artist platform DSP. agency-portfolio 의 scale 1.03 simple hover 와 명확히 차별 — 3D depth perception.

---

## Snippet 18 — Real-time countdown ticker (setInterval Mono caps)

<!-- motion-snippet: name=countdown-ticker stack=react -->

```tsx
"use client";

import { useEffect, useState, type CSSProperties } from "react";

export function CountdownTicker({
  target,
  style,
  ariaLabel,
}: {
  target: Date | string;
  style?: CSSProperties;
  ariaLabel?: string;
}) {
  const targetMs = typeof target === "string" ? new Date(target).getTime() : target.getTime();
  const [now, setNow] = useState<number>(() => Date.now());

  useEffect(() => {
    // 1s tick — Mono caps tabular-nums ticker
    const id = window.setInterval(() => setNow(Date.now()), 1000);
    return () => window.clearInterval(id);
  }, []);

  const diff = Math.max(0, targetMs - now);
  const days = Math.floor(diff / 86_400_000);
  const hours = Math.floor((diff / 3_600_000) % 24);
  const minutes = Math.floor((diff / 60_000) % 60);
  const seconds = Math.floor((diff / 1_000) % 60);

  return (
    <span
      role="timer"
      aria-label={ariaLabel}
      style={{
        fontVariantNumeric: "tabular-nums",
        fontFeatureSettings: '"tnum"',
        ...style,
      }}
    >
      {String(days).padStart(2, "0")}D{" "}
      {String(hours).padStart(2, "0")}:{String(minutes).padStart(2, "0")}:{String(seconds).padStart(2, "0")}
    </span>
  );
}
```

**MUST USE**: K-pop comeback countdown / album release / event countdown 시그니처. SSR-safe (initial Date.now() in lazy initializer, hydration mismatch 우려 시 `suppressHydrationWarning`).

---

## Snippet 19 — Sequenced staggered hero load (multi-element timeline)

<!-- motion-snippet: name=sequenced-hero-load stack=gsap -->

```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { useReducedMotion } from "motion/react";

// agency-portfolio 의 "all-at-once stagger 30ms" 와 차별 — 명확한 sequence 단계
// 각 element 가 timing label 로 정확한 시점에 등장.

const heroRef = useRef<HTMLDivElement | null>(null);
const reduce = useReducedMotion();

useGSAP(
  () => {
    if (reduce) return;

    // Multi-stage timeline — 각 stage 가 명확히 다른 element + timing
    const tl = gsap.timeline({ defaults: { ease: "brand" } });

    // Stage 1 (t=0.2s): eyebrow
    tl.from(".hero-eyebrow", { opacity: 0, y: -8, duration: 0.5 }, 0.2);

    // Stage 2 (t=0.4s): 한글 아티스트명 word stagger (한글 jamo 분해 방지)
    tl.from(".hero-title-ko .split-word", {
      opacity: 0,
      yPercent: 100,
      duration: 0.8,
      stagger: 0.08,  // 80ms — slow & deliberate
    }, 0.4);

    // Stage 3 (t=0.7s): 영문 italic char stagger
    tl.from(".hero-title-en .split-char", {
      opacity: 0,
      yPercent: 100,
      duration: 0.7,
      stagger: 0.04,  // 40ms
    }, 0.7);

    // Stage 4 (t=1.0s): tagline + bottom info strip stagger
    tl.from([".hero-tagline", ".hero-info-strip > *"], {
      opacity: 0,
      y: 12,
      duration: 0.7,
      stagger: 0.1,
    }, 1.0);

    // Stage 5 (t=1.3s): CTA spring scale-in (NOT magnetic — that's agency signature)
    tl.from(".hero-cta", {
      opacity: 0,
      scale: 0.95,
      duration: 0.5,
      ease: "back.out(1.2)",
      stagger: 0.08,
    }, 1.3);
  },
  { scope: heroRef, dependencies: [reduce] },
);
```

**MUST USE**: K-pop / editorial / cinematic immersion DSP — sequential 8-stage load 가 brand-driven story telling. agency 의 chars-stagger-only 패턴 과 명확히 차별.

---

## Pre-commit motion stack audit (designer agent 의무)

코드 생성 완료 후 다음 grep 실행해 motion stack 실제 사용 검증. 0 매치면 abstract 텍스트만 보고 CSS keyframes 로 fallback 한 것 → re-generate:

```bash
PROJECT_DIR=<project>/app
# A. GSAP 실사용 (DSP 가 motion-heavy 면 필수)
grep -rE "useGSAP|gsap\.(to|from|fromTo|set|timeline)|ScrollTrigger" "$PROJECT_DIR"
# B. SplitText / DrawSVG / CustomEase 의무 (agency-portfolio / editorial-magazine 톤)
grep -rE "SplitText|DrawSVG|CustomEase" "$PROJECT_DIR"
# C. anime.js v4 (path morph 가 DSP 에 박혀있으면)
grep -rE "createTimeline|svg\.morphTo" "$PROJECT_DIR"
# D. Framer Motion spring (magnetic CTA)
grep -rE "useMotionValue|whileTap.*spring|stiffness:" "$PROJECT_DIR"
# E. 단순 CSS keyframes 만 등장 + 위 grep 모두 0 매치 = FAIL
grep -rE "@keyframes" "$PROJECT_DIR" | wc -l
```

**판정 룰** (motion-heavy DSP 적용 시):
- 위 A-D 중 ≥ 2 카테고리 매치 = pass
- A-D 모두 0 매치 + E 만 매치 = **FAIL — re-generate**, snippet 2-7 verbatim 박을 것
- 한쪽만 적용 (예: GSAP 만 + Framer 없음) = motion-heavy DSP 라면 충돌 — 본 카탈로그 의도 (각 책임 분리) 확인

---

## DSP 별 권장 snippet matrix

| DSP | 권장 snippet | 우선순위 |
|---|---|---|
| agency-portfolio | 2 (register) + 3 (SplitText) + 4 (pin scrub) + 5 (progress bar) + 6 (DrawSVG) + 7 (batch) + 8 (magnetic) + 10 (anime morph) + 12 (reduced motion) | **MANDATORY** all 9 |
| editorial-magazine | 2 + 3 + 4 + 6 + 12 + 13 (variable font) | high |
| corporate-b2b | 2 + 3 + 4 + 7 + 12 | medium |
| fintech-saas (Magic UI 톤) | 8 + 9 (marquee) + 12 | medium — GSAP optional |
| wellness-platform | 12 만 (Section 3 의 "안정적" 룰 — GSAP 미권장) | low |
| kpop-entertainment | 2 + 3 + 4 + 7 + 11 (Lenis) + 12 | high |
| automotive-mobility | 2 + 4 + 11 + 12 | high |

DSP 본문 의 Section 3 (Animation) 에 위 권장 snippet 번호 명시. designer agent 가 코드 생성 시 그대로 박음.

---

# v1.9.4 — gsap.com/showcase verbatim snippets (#20-#32)

2026-05-20 gsap.com/showcase 15-site reverse-engineering 분석 (`13-Wiki/research/2026-05-20-gsap-showcase-research.md`) 기반. 각 snippet 의 **verbatim 출처** (사이트 + Codrops/Awwwards case study URL) 명시. abstract motion library 명세를 넘어 **cluster-specific brand signature** 박음.

---

## Snippet 20 — Italic asterisk inline emphasis (Studio375 / DAVINCII / Victor Furuya)

<!-- motion-snippet: name=italic-asterisk-emphasis stack=css -->

**출처**: Studio375 (https://375.studio/) hero text `*creative* *meet* *375*`, DAVINCII `_Intelligence_`, Victor Furuya '26 manifesto inline.

**Use case**: brutalist agency / portfolio / editorial — inline emphasis 가 italic asterisk wrapped words. SplitText chars stagger 의 대안.

```tsx
import type { CSSProperties } from "react";

// React JSX: 문장 안의 emphasis words 를 *asterisk* 또는 _underscore_ 로 wrap
// → CSS 가 italic + accent color + variable font weight 상승

export function ItalicEmphasis({ children }: { children: string }) {
  // *word* 를 italic span 으로 transform, _word_ 도 동일
  const parts = children.split(/(\*[^*]+\*|_[^_]+_)/g);
  return (
    <>
      {parts.map((part, i) => {
        const matchAst = /^\*([^*]+)\*$/.exec(part);
        const matchUnd = /^_([^_]+)_$/.exec(part);
        const word = matchAst?.[1] ?? matchUnd?.[1];
        if (!word) return part;
        return (
          <span
            key={i}
            className="italic-emphasis"
            style={{
              fontStyle: "italic",
              fontVariationSettings: '"wght" 500',
              transition: "font-variation-settings 220ms ease-out, color 220ms ease-out",
              paddingRight: "0.06em",        // italic glyph overshoot (Guardrail Category A)
              display: "inline-block",
            }}
          >
            {word}
          </span>
        );
      })}
    </>
  );
}

// 사용:
// <h1>A practice in <ItalicEmphasis>*form* and *care*</ItalicEmphasis>.</h1>
```

```css
.italic-emphasis:hover {
  font-variation-settings: 'wght' 620 !important;
  color: var(--brand-accent);
}
```

---

## Snippet 21 — Numerology chapter framework (DAVINCII)

<!-- motion-snippet: name=numerology-chapter stack=gsap -->

**출처**: DAVINCII (https://davincii.com/) — Fibonacci-adjacent 1/2/3/5/13/23/33/60 chapter numbering, scroll-driven progress dot HUD on right edge.

**Use case**: cinematic immersion / editorial / agency portfolio — chapter-numbered storytelling. Aboutluca `1/23`, Luke Baffait `V3.0` 변형 가능.

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

const chapters = [1, 2, 3, 5, 13, 23, 33, 60];  // DAVINCII Fibonacci-adjacent

// JSX (right edge fixed HUD):
<div
  aria-hidden
  style={{
    position: "fixed",
    right: 24,
    top: "50%",
    transform: "translateY(-50%)",
    display: "flex",
    flexDirection: "column",
    gap: 16,
    zIndex: 50,
  }}
>
  {chapters.map((n) => (
    <div
      key={n}
      className="chapter-dot"
      data-chapter={n}
      style={{
        fontFamily: "var(--font-mono)",
        fontSize: 11,
        letterSpacing: "0.08em",
        color: "var(--color-ink-muted)",
        cursor: "pointer",
        transition: "color 200ms ease-out, transform 200ms ease-out",
      }}
    >
      {String(n).padStart(2, "0")}
    </div>
  ))}
</div>;

// useGSAP — ScrollTrigger 가 각 chapter section 의 view 진입 시 dot 활성화
useGSAP(() => {
  chapters.forEach((n) => {
    const section = document.querySelector(`[data-chapter-section="${n}"]`);
    const dot = document.querySelector(`[data-chapter="${n}"]`);
    if (!section || !dot) return;
    ScrollTrigger.create({
      trigger: section,
      start: "top 50%",
      end: "bottom 50%",
      onEnter: () => gsap.to(dot, { color: "var(--brand-accent)", scale: 1.4, duration: 0.3 }),
      onLeave: () => gsap.to(dot, { color: "var(--color-ink-muted)", scale: 1, duration: 0.3 }),
      onEnterBack: () => gsap.to(dot, { color: "var(--brand-accent)", scale: 1.4, duration: 0.3 }),
      onLeaveBack: () => gsap.to(dot, { color: "var(--color-ink-muted)", scale: 1, duration: 0.3 }),
    });
  });
}, []);
```

---

## Snippet 22 — Entry gate (loading + [enter] click)

<!-- motion-snippet: name=entry-gate stack=react -->

**출처**: Aboutluca (https://www.aboutluca.com/) — `_loading_` interstitial gate, 사용자 `[ enter ]` 클릭 후 main timeline play.

**Use case**: brutalist architecture / portfolio / editorial — 진입 자체가 ritual. Cluster A subset signature.

```tsx
"use client";

import { useState, useEffect } from "react";

export function EntryGate({ onEnter, children }: {
  onEnter: () => void;
  children: React.ReactNode;
}) {
  const [phase, setPhase] = useState<"loading" | "ready" | "entered">("loading");

  useEffect(() => {
    // 800ms 후 [enter] button 활성화
    const id = window.setTimeout(() => setPhase("ready"), 800);
    return () => window.clearTimeout(id);
  }, []);

  if (phase === "entered") return <>{children}</>;

  return (
    <div
      role="dialog"
      aria-modal="true"
      style={{
        position: "fixed",
        inset: 0,
        backgroundColor: "var(--color-canvas)",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        gap: 32,
        zIndex: 100,
      }}
    >
      <span
        style={{
          fontFamily: "var(--font-mono)",
          fontSize: 12,
          letterSpacing: "0.14em",
          textTransform: "uppercase",
          color: "var(--color-ink-muted)",
        }}
      >
        {phase === "loading" ? "_loading_" : "_ready_"}
      </span>
      {phase === "ready" && (
        <button
          type="button"
          onClick={() => {
            setPhase("entered");
            onEnter();
          }}
          style={{
            border: "1.5px solid currentColor",
            background: "transparent",
            color: "var(--color-ink-primary)",
            fontFamily: "var(--font-mono)",
            fontSize: 13,
            letterSpacing: "0.14em",
            textTransform: "uppercase",
            padding: "14px 32px",
            cursor: "pointer",
            borderRadius: 0,
          }}
        >
          [ enter ]
        </button>
      )}
    </div>
  );
}
```

---

## Snippet 23 — ASCII matrix hero (text-only)

<!-- motion-snippet: name=ascii-matrix-hero stack=gsap -->

**출처**: KVS Studio (https://kvs.studio/) — Hero 가 monospace alphabetic matrix 만으로 구성. Image 0개.

**Use case**: brutalist architecture / minimal gallery / typographic studio — image 0 의 hero.

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { useReducedMotion } from "motion/react";

const ROWS = 13;
const COLS = 60;
const CHARS = "█▓▒░·.    ABCDEFGHIJKLMNOPQRSTUVWXYZ";

function randomMatrix(): string[][] {
  return Array.from({ length: ROWS }, () =>
    Array.from({ length: COLS }, () => CHARS[Math.floor(Math.random() * CHARS.length)])
  );
}

export function AsciiMatrixHero({ brandWord }: { brandWord: string }) {
  const reduce = useReducedMotion();
  const matrix = randomMatrix();

  // brand word 를 matrix 중심에 stamp
  const centerRow = Math.floor(ROWS / 2);
  const centerCol = Math.floor((COLS - brandWord.length) / 2);
  for (let i = 0; i < brandWord.length; i++) {
    matrix[centerRow][centerCol + i] = brandWord[i].toUpperCase();
  }

  useGSAP(() => {
    if (reduce) return;
    // 각 cell 을 ease "none" 으로 random delay 후 fade-in
    gsap.from(".ascii-cell", {
      opacity: 0,
      duration: 0.4,
      stagger: { each: 0.005, from: "random" },
      ease: "none",
    });
  }, [reduce]);

  return (
    <pre
      aria-label={brandWord}
      style={{
        fontFamily: "var(--font-mono)",
        fontSize: "clamp(10px, 1.1vw, 14px)",
        lineHeight: 1.1,
        color: "var(--color-ink-primary)",
        margin: 0,
        padding: 0,
        userSelect: "none",
        whiteSpace: "pre",
      }}
    >
      {matrix.map((row, ri) => (
        <span key={ri} style={{ display: "block" }}>
          {row.map((char, ci) => (
            <span key={`${ri}-${ci}`} className="ascii-cell" style={{ display: "inline-block" }}>
              {char}
            </span>
          ))}
        </span>
      ))}
    </pre>
  );
}
```

---

## Snippet 24 — JOYCO Scramble effect (Sazabi / AI SaaS)

<!-- motion-snippet: name=joyco-scramble stack=gsap -->

**출처**: Sazabi (JOYCO open-source registry pattern). 2026 AI observability SaaS 트렌드.

**Use case**: AI observability / SaaS / brand statement — text scramble reveal. agency 의 chars stagger 와 차별.

```tsx
"use client";

import { useEffect, useRef } from "react";
import { useReducedMotion } from "motion/react";

const SCRAMBLE_CHARS = "!<>-_\\/[]{}—=+*^?#________";

export function ScrambleText({
  children,
  duration = 1200,
  cycles = 2,
}: {
  children: string;
  duration?: number;
  cycles?: number;
}) {
  const ref = useRef<HTMLSpanElement | null>(null);
  const reduce = useReducedMotion();
  const target = children;

  useEffect(() => {
    if (reduce || !ref.current) {
      ref.current!.textContent = target;
      return;
    }
    const el = ref.current;
    const startTime = performance.now();
    let raf = 0;

    const tick = (now: number) => {
      const t = Math.min(1, (now - startTime) / duration);
      const revealCount = Math.floor(t * target.length);
      let out = "";
      for (let i = 0; i < target.length; i++) {
        if (i < revealCount) {
          out += target[i];
        } else {
          // scramble — random char from set
          out += SCRAMBLE_CHARS[Math.floor(Math.random() * SCRAMBLE_CHARS.length)];
        }
      }
      el.textContent = out;
      if (t < 1) raf = requestAnimationFrame(tick);
      else el.textContent = target;
    };
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [target, duration, cycles, reduce]);

  return <span ref={ref} aria-label={target}>{target}</span>;
}
```

---

## Snippet 25 — R3F + GSAP 3D camera scroll-pin (Škoda Vision)

<!-- motion-snippet: name=r3f-camera-scroll stack=gsap -->

**출처**: Škoda Vision Concept (Doan Bao Nam, https://vision.doanbao.com/) — ScrollTrigger pin + scrub heavy lazy + R3F camera tween.

**Use case**: cinematic-immersion-auto / luxury hardware / 3D product configurator.

```tsx
"use client";

import { useRef } from "react";
import { useFrame } from "@react-three/fiber";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Vector3 } from "three";
import { useReducedMotion } from "motion/react";

export function R3FCameraScrollPin({ sectionRef }: {
  sectionRef: React.RefObject<HTMLDivElement | null>;
}) {
  const cameraPos = useRef(new Vector3(0, 1.5, 8));
  const cameraTarget = useRef(new Vector3(0, 0.5, 0));
  const reduce = useReducedMotion();

  useFrame(({ camera }) => {
    camera.position.lerp(cameraPos.current, 0.1);
    camera.lookAt(cameraTarget.current);
  });

  useGSAP(() => {
    if (reduce || !sectionRef.current) return;

    const tl = gsap.timeline({
      scrollTrigger: {
        trigger: sectionRef.current,
        start: "top top",
        end: "+=300%",      // hero 3배 핀 구간
        scrub: 1.5,         // heavy lazy — cinema 감각
        pin: true,
        pinSpacing: true,
        invalidateOnRefresh: true,
      },
    });

    // Stage 1 (0 → 33%): camera dolly-in
    tl.to(cameraPos.current, { z: 4, y: 1.2, duration: 1 }, 0);

    // Stage 2 (33 → 66%): orbit right
    tl.to(cameraPos.current, { x: 3, z: 3, duration: 1 }, 1);
    tl.to(cameraTarget.current, { x: 0.5, duration: 1 }, 1);

    // Stage 3 (66 → 100%): orbit back, dolly out
    tl.to(cameraPos.current, { x: 0, y: 1.8, z: 6, duration: 1 }, 2);
  }, [reduce]);

  return null;
}
```

---

## Snippet 26 — Draggable + Inertia sticker physics (Hypefluency, pin-LESS)

<!-- motion-snippet: name=draggable-inertia-sticker stack=gsap -->

**출처**: Hypefluency (https://hypefluency.com/) — Draggable + Inertia 핵심, pin/scrub 없음. Cluster C interactive playground.

**Use case**: interactive playground DSP / portfolio / agency easter-egg layer. agency-portfolio 의 pin+scrub 시그니처와 정반대.

```tsx
"use client";

import { useEffect, useRef } from "react";
import { gsap } from "gsap";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";
import { useReducedMotion } from "motion/react";

if (typeof window !== "undefined") {
  gsap.registerPlugin(Draggable, InertiaPlugin);
}

export function DraggableSticker({
  children,
  initialX = 0,
  initialY = 0,
}: {
  children: React.ReactNode;
  initialX?: number;
  initialY?: number;
}) {
  const ref = useRef<HTMLDivElement | null>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !ref.current) return;

    const instance = Draggable.create(ref.current, {
      type: "x,y",
      inertia: true,         // throw physics
      throwResistance: 1500,
      maxDuration: 1.6,
      edgeResistance: 0.65,
      bounds: window,        // 또는 specific element
      onDrag() {
        this.target.style.cursor = "grabbing";
      },
      onDragEnd() {
        this.target.style.cursor = "grab";
      },
    })[0];

    return () => instance.kill();
  }, [reduce]);

  return (
    <div
      ref={ref}
      style={{
        position: "absolute",
        left: initialX,
        top: initialY,
        cursor: "grab",
        userSelect: "none",
        touchAction: "none",
      }}
    >
      {children}
    </div>
  );
}
```

---

## Snippet 27 — MorphSVG elastic CTA (Maxima Therapy)

<!-- motion-snippet: name=morphsvg-elastic-cta stack=gsap -->

**출처**: Maxima Therapy (Codrops 2026-04-06 case study) verbatim.

```js
// VERBATIM from Maxima Therapy / Codrops 2026-04-06
function onEnter() {
  gsap.to('.cta-rect', {
    duration: 0.9,
    morphSVG: '.cta-circle-shape',
    ease: 'elastic.out(0.8, 0.8)'
  });
}
function onLeave() {
  gsap.to('.cta-rect', {
    duration: 0.9,
    morphSVG: '.cta-rec',
    ease: 'elastic.out(1.2, 1)'
  });
}
```

**Use case**: playful illustrated DSP (therapy / health / kids platform). CTA 한정 — 모든 hover 에 elastic 적용 금지 (production-hostile, studiomeyer 2026 reality check).

---

## Snippet 28 — Horizontal scroll track (Bottega53)

<!-- motion-snippet: name=horizontal-scroll-track stack=gsap -->

**출처**: Bottega53 (wedding/photography editorial) — horizontal scroll primary. Cluster D editorial slow horizontal.

**Use case**: editorial-horizontal-photo / portfolio reveal / spec table panning. Snippet #16 의 variant (#16 은 K-pop discography 한정).

```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

export function HorizontalScrollTrack({ children }: { children: React.ReactNode }) {
  const sectionRef = useRef<HTMLDivElement | null>(null);
  const trackRef = useRef<HTMLDivElement | null>(null);

  useGSAP(
    () => {
      if (!sectionRef.current || !trackRef.current) return;
      const track = trackRef.current;

      gsap.to(track, {
        x: () => -(track.scrollWidth - window.innerWidth),
        ease: "none",
        scrollTrigger: {
          trigger: sectionRef.current,
          start: "top top",
          end: () => `+=${track.scrollWidth - window.innerWidth}`,
          pin: true,
          scrub: 0.8,        // K-pop 의 1.0 보다 가벼움 (editorial pace)
          invalidateOnRefresh: true,
        },
      });
    },
    { scope: sectionRef },
  );

  return (
    <section ref={sectionRef} style={{ height: "100vh", overflow: "hidden" }}>
      <div ref={trackRef} style={{ display: "flex", height: "100%", alignItems: "stretch", willChange: "transform" }}>
        {children}
      </div>
    </section>
  );
}
```

---

## Snippet 29 — Variable font weight on hover (2026 typography trend)

<!-- motion-snippet: name=variable-font-weight-hover stack=css -->

**출처**: fontfyi.com / cssshowcase 2026 — `font-variation-settings: 'wght' N` 연속 값.

**Use case**: brutalist-architecture / editorial-magazine / minimal portfolio — link/nav hover signature. Snippet #13 의 확장.

```tsx
import type { CSSProperties } from "react";

export const variableFontWeightHover: CSSProperties = {
  fontVariationSettings: '"wght" 400',
  transition:
    "font-variation-settings 220ms cubic-bezier(0.86,0,0.07,1), color 220ms cubic-bezier(0.86,0,0.07,1)",
  willChange: "font-variation-settings",
};
```

```css
.weight-hover:hover {
  font-variation-settings: 'wght' 620 !important;  /* 또는 'wght' 510 더 subtle */
}
.weight-hover:hover {
  color: var(--brand-accent);
}
```

**Critical**: Variable font import 필수 (Inter Variable / Söhne Variable / Geist / Pretendard Variable). Static weight 만 import 시 작동 안 함.

---

## Snippet 30 — `autoSplit: true` responsive SplitText (Joffrey Spitzer)

<!-- motion-snippet: name=autosplit-responsive stack=gsap -->

**출처**: Joffrey Spitzer (Codrops case study) verbatim: "so the text can re-split responsively if the layout changes. In that case, the animation must be created inside the `onSplit()` callback and returned so GSAP can properly revert and rebuild it on resize."

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { SplitText } from "gsap/SplitText";

useGSAP(() => {
  if (!headlineRef.current) return;

  const split = SplitText.create(headlineRef.current, {
    type: "lines,words",
    mask: "lines",            // line-level mask for clean reveal
    autoSplit: true,          // resize 시 re-split
    onSplit(self) {
      // Resize 마다 timeline rebuild — revert + rebuild 안전
      return gsap.from(self.lines, {
        opacity: 0,
        yPercent: 100,
        duration: 1.0,
        stagger: 0.08,
        ease: "expo.out",
      });
    },
  });

  return () => split.revert();
}, { scope: headlineRef });
```

**Use case**: 모든 production-grade SplitText 사용처. 정적 SplitText 보다 책임 있는 선택.

---

## Snippet 31 — Lenis + GSAP ticker sync (NeuralVox / Maxima)

<!-- motion-snippet: name=lenis-gsap-ticker stack=lenis -->

**출처**: DarsLab NeuralVox case study verbatim: "Lenis handles smooth native scrolling, piping scroll events into GSAP's ticker to maintain perfect synchronisation."

```tsx
"use client";

import { useEffect } from "react";
import Lenis from "lenis";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

export function LenisGSAPSync() {
  useEffect(() => {
    if (window.matchMedia("(max-width: 768px)").matches) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    const lenis = new Lenis({
      duration: 1.2,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smoothWheel: true,
    });

    // Pipe Lenis scroll → GSAP ticker → ScrollTrigger.update
    lenis.on("scroll", ScrollTrigger.update);
    gsap.ticker.add((time) => {
      lenis.raf(time * 1000);
    });
    gsap.ticker.lagSmoothing(0);

    return () => {
      lenis.destroy();
    };
  }, []);

  return null;
}
```

**Use case**: 모든 cluster 에서 Lenis + ScrollTrigger 동시 사용 시. Snippet #11 의 확장 (단순 raf 가 아닌 GSAP ticker 통합).

---

## Snippet 32 — `gsap.matchMedia` reduced-motion (2026 표준)

<!-- motion-snippet: name=gsap-matchmedia-reduce stack=gsap -->

**출처**: 2026 award sites 표준 — line25.com / 3str.net 2026-04 verbatim: "All major animations are duplicated with reduced-motion versions."

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";

useGSAP(() => {
  const mm = gsap.matchMedia();

  // Full motion variant
  mm.add("(prefers-reduced-motion: no-preference)", () => {
    gsap.to(".hero-headline", {
      opacity: 1,
      y: 0,
      duration: 1.0,
      ease: "expo.out",
    });

    gsap.to(".tile", {
      scrollTrigger: { trigger: ".tile-grid", start: "top 80%" },
      opacity: 1,
      y: 0,
      stagger: 0.1,
      duration: 0.8,
    });

    return () => {
      // cleanup
    };
  });

  // Reduced motion variant — 즉시 정적 표시
  mm.add("(prefers-reduced-motion: reduce)", () => {
    gsap.set(".hero-headline", { opacity: 1, y: 0 });
    gsap.set(".tile", { opacity: 1, y: 0 });

    return () => {
      // cleanup
    };
  });
}, []);
```

**Use case**: 모든 motion-heavy DSP. Snippet #12 의 보강 — JS gate + CSS gate 외에 `gsap.matchMedia` 로 timeline 자체를 reduced variant 분기. 2026 production-grade 표준.

---

## v1.9.4 cluster matrix (snippet 매핑)

| Cluster | Mandatory snippets | Banned snippets |
|---|---|---|
| Cluster A Brutalist agency (sub-variants) | #2 + #20 italic asterisk + #21 numerology + #22 entry gate + #23 ASCII + #29 variable font + #11 Lenis + #12 + #32 | #3 chars stagger / #4 pin+scrub / #8 magnetic / #10 morph / #15 Ken Burns / #16 horizontal / #17 tilt / #18 countdown / #25 R3F / #26 Draggable / #27 elastic / #24 scramble |
| Cluster B Cinematic immersion auto | #2 + #25 R3F camera + #11 Lenis + #31 sync + #12 + #32 + (#15 Ken Burns optional) | #3 / #8 / #10 / #17 / #18 / #16 / #26 / #24 / #23 |
| Cluster C Interactive playground | #2 + #26 Draggable Inertia + #22 entry gate + #11 + #12 + #32 | #3 / #4 / #8 / #15 / #16 / #17 / #18 / #25 / #23 |
| Cluster D Editorial horizontal photo | #2 + #28 horizontal track + #29 variable font + #11 + #12 + #32 (+ #30 autoSplit if SplitText used) | #3 / #4 / #8 / #15 / #17 / #18 / #25 / #26 / #24 / #23 |
| Cluster E AI Observability SaaS | #2 + #24 scramble + #9 marquee (compliance ribbon) + #12 + #32 | #3 / #4 / #15 / #17 / #18 / #25 / #26 |
| Cluster F Playful illustrated | #2 + #27 MorphSVG elastic CTA + Lottie + #11 + #12 + #32 | #3 / #4 / #15 / #17 / #18 / #23 / #25 |
| Cluster G ASCII typography only | #2 + #23 ASCII matrix + #22 entry gate + #29 variable font + #12 + #32 | All other snippets — minimalism is the rule |

---

# v1.9.6 — gap audit snippets (#33-#40)

2026-05-21 gsap-bp-audit 2nd pass 기반. 1차 (v1.9.4 #20-#32) 가 cluster identity 의 hero/scroll/cursor 카탈로그였다면, 본 batch 는 **page-level orchestration** (page transition / scroll anchor / WebGL bridge / interruptible toggle / state pages) 보강.

---

## Snippet 33 — MorphSVG → DrawSVG sequential reveal

<!-- motion-snippet: name=morphsvg-drawsvg-sequential stack=gsap -->

**출처**: Sazabi (JOYCO open-source registry) — MorphSVG + DrawSVG + Flip 조합. AI observability data viz signature.

**Use case**: AI SaaS / data viz / dev tool — abstract data flow diagram 의 reveal. 단순 fade 가 아닌 path morph 후 stroke draw.

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { DrawSVGPlugin } from "gsap/DrawSVGPlugin";
import { MorphSVGPlugin } from "gsap/MorphSVGPlugin";

if (typeof window !== "undefined") {
  gsap.registerPlugin(useGSAP, ScrollTrigger, DrawSVGPlugin, MorphSVGPlugin);
}

useGSAP(() => {
  if (reduce) return;
  const tl = gsap.timeline({
    scrollTrigger: { trigger: "#data-flow", start: "top 70%", once: true },
  });

  // 1. Initial shape morph (rect → ellipse → final shape)
  tl.to("#flow-path", { duration: 0.6, morphSVG: "#shape-stage-1", ease: "expo.out" });
  tl.to("#flow-path", { duration: 0.6, morphSVG: "#shape-final", ease: "expo.out" }, "+=0.15");

  // 2. Stroke draw (after morph completes)
  tl.fromTo(
    "#flow-path",
    { drawSVG: "0%" },
    { drawSVG: "100%", duration: 1.2, ease: "power2.inOut" },
    "-=0.3"
  );

  // 3. Connecting nodes pop-in after stroke
  tl.fromTo(
    ".flow-node",
    { scale: 0, opacity: 0 },
    { scale: 1, opacity: 1, duration: 0.4, stagger: 0.08, ease: "back.out(1.6)" },
    "-=0.4"
  );
}, [reduce]);
```

---

## Snippet 34 — CustomEase × ScrollTo anchor navigation

<!-- motion-snippet: name=customease-scrollto stack=gsap -->

**출처**: DAVINCII (Fibonacci chapter framework — chapter dot click → smooth scroll to section) + Bottega53 horizontal scroll anchor.

**Use case**: 대용량 single-page site 의 anchor nav — Lenis 와 동시 작동, scroll behavior smooth + CustomEase 로 cinematic. native `scrollIntoView` 와 차별.

```tsx
import { gsap } from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { CustomEase } from "gsap/CustomEase";

if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollToPlugin, CustomEase);
  if (!CustomEase.get("anchor")) {
    CustomEase.create("anchor", "M0,0 C0.32,0 0.08,1 1,1");
  }
}

export function scrollToSection(targetSelector: string, offset = 0) {
  // Lenis 와 동시 사용 시: Lenis instance.scrollTo 호출 권장 — gsap.to(window, scrollTo) 가 Lenis 의 raf 와 충돌 가능.
  gsap.to(window, {
    duration: 1.2,
    scrollTo: { y: targetSelector, offsetY: offset, autoKill: true },
    ease: "anchor",
  });
}

// Usage:
// <a onClick={() => scrollToSection("#chapter-3", 80)}>03</a>
```

---

## Snippet 35 — GSAP timeline → WebGL uniform bridge

<!-- motion-snippet: name=gsap-webgl-uniform stack=gsap -->

**출처**: Thibault Guignand portfolio (Codrops 2026-05-06 "From Shader Uniforms to Clip-Path Wipes: How GSAP Drives My Portfolio") verbatim.

**Use case**: 포트폴리오 / cinematic-immersion-auto / WebGL shader-driven hero — GSAP timeline 의 scrub progress 를 shader uniform 으로 직접 piping.

```tsx
"use client";

import { useEffect, useRef } from "react";
import { useFrame } from "@react-three/fiber";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import * as THREE from "three";

// Shader material uniform
const material = new THREE.ShaderMaterial({
  uniforms: {
    uProgress: { value: 0 },
    uTime: { value: 0 },
  },
  vertexShader: /* ... */,
  fragmentShader: /* uniform float uProgress; ... */,
});

// GSAP timeline drives uProgress
const progressTarget = { value: 0 };
gsap.to(progressTarget, {
  value: 1,
  ease: "none",
  scrollTrigger: {
    trigger: "#hero-canvas",
    start: "top top",
    end: "+=200%",
    scrub: 1.2,
  },
  onUpdate() {
    material.uniforms.uProgress.value = progressTarget.value;
  },
});

// useFrame from R3F 에서 uTime 만 RAF 갱신
function ShaderPlane() {
  useFrame((state) => {
    material.uniforms.uTime.value = state.clock.elapsedTime;
  });
  return <mesh material={material}>{/* geometry */}</mesh>;
}
```

**중요**: `onUpdate` 안에서 uniform 직접 set — React state 우회. `lerp` 또는 `smoothstep` 은 shader 내부에서 처리.

---

## Snippet 36 — gsap.matchMedia() with prefers-reduced-motion

<!-- motion-snippet: name=matchmedia-reduced-motion stack=gsap -->

**출처**: Arnaud Rocca / Codrops 2026-04 — `gsap.matchMedia()` 가 v3.11+ 부터 가장 권장되는 reduced-motion 패턴.

**Use case**: 모든 motion-heavy DSP. snippet #12 (manual JS gate) 보다 강력 — matchMedia 가 viewport / preference 변경 시 자동 cleanup + rebuild.

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";

useGSAP(() => {
  const mm = gsap.matchMedia();

  // 1. 정상 motion variant (preference: no-preference)
  mm.add("(prefers-reduced-motion: no-preference)", () => {
    const tl = gsap.timeline();
    tl.from(".hero-title .word", {
      yPercent: 100,
      opacity: 0,
      stagger: 0.04,
      duration: 0.9,
      ease: "expo.out",
    });
    tl.from(".hero-cta", { y: 24, opacity: 0, duration: 0.6, ease: "expo.out" }, "-=0.3");

    // matchMedia cleanup 시 자동 revert
    return () => {
      tl.kill();
    };
  });

  // 2. Reduced-motion variant — parallel design (NOT just disable)
  mm.add("(prefers-reduced-motion: reduce)", () => {
    // 단순 disable 이 아니라 "다른 acceptable visual variant" 제공:
    // - hero title 즉시 표시 (opacity 1, no stagger)
    // - subtle color tint cross-fade 만 사용 (0.3s linear)
    gsap.set(".hero-title .word", { yPercent: 0, opacity: 1 });
    gsap.set(".hero-cta", { y: 0, opacity: 1 });

    const accentFade = gsap.to(".hero-cta", {
      backgroundColor: "var(--brand-accent-soft)",
      duration: 0.3,
      ease: "none",
      yoyo: true,
      repeat: -1,
      repeatDelay: 2.0,
    });

    return () => {
      accentFade.kill();
    };
  });
}, []);
```

**핵심 paradigm shift** (Cassie Evans via Thibault Guignand): reduced motion = "motion 끔" 이 아니라 **"동등한 정보 전달 + 다른 visual layer"**. 색·typography·layout 만 으로 brand identity 전달 가능해야.

---

## Snippet 37 — Lenis × GSAP ticker sync (lag smoothing off)

<!-- motion-snippet: name=lenis-gsap-ticker-v2 stack=lenis -->

**출처**: Maxima Therapy (Codrops 2026-04-06) verbatim.

**Use case**: snippet #31 의 강화 버전 — `gsap.ticker.lagSmoothing(0)` 추가로 frame skip 시 보간 비활성화. cinematic 에서는 lag smoothing 이 motion drift 유발.

```tsx
"use client";

import { useEffect } from "react";
import Lenis from "lenis";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

export function LenisGSAPTicker() {
  useEffect(() => {
    // Mobile / reduced-motion 에서 disable (touch hijacking + a11y)
    if (window.matchMedia("(max-width: 768px)").matches) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    const lenis = new Lenis({
      duration: 1.2,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smoothWheel: true,
      autoRaf: false,  // GSAP ticker 가 raf 담당 — autoRaf false 의무
    });

    // Lenis scroll → ScrollTrigger.update
    lenis.on("scroll", ScrollTrigger.update);

    // GSAP ticker → Lenis raf
    gsap.ticker.add((time) => {
      lenis.raf(time * 1000);
    });

    // lagSmoothing 0 — frame skip 시 보간 X (cinematic accuracy)
    gsap.ticker.lagSmoothing(0);

    return () => {
      lenis.destroy();
      gsap.ticker.lagSmoothing(500, 33);  // restore default
    };
  }, []);

  return null;
}
```

**Use case difference** vs snippet #31: snippet #31 은 default lagSmoothing. 본 #37 는 cinematic-immersion-auto / editorial slow horizontal 처럼 scrub 정확도 중요한 cluster 한정.

---

## Snippet 38 — Barba.js + clip-path page transition

<!-- motion-snippet: name=barba-clippath-transition stack=barba -->

**출처**: R—K '26 portfolio (Codrops 2026-04 case study).

**Use case**: brutalist-architecture / editorial-slow — 페이지 전환이 brand identity. clip-path wipe 으로 hard-edge transition.

```tsx
// app/layout.tsx 또는 _app.tsx
"use client";

import { useEffect } from "react";
import barba from "@barba/core";
import { gsap } from "gsap";

export function BarbaProvider({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    barba.init({
      transitions: [
        {
          name: "clip-wipe",
          leave({ current }) {
            return gsap.to(current.container, {
              duration: 0.6,
              clipPath: "inset(0 0 100% 0)",   // bottom-to-top wipe out
              ease: "expo.inOut",
            });
          },
          enter({ next }) {
            // 새 페이지는 hidden 상태로 들어옴 — wipe in
            gsap.set(next.container, { clipPath: "inset(100% 0 0 0)" });
            return gsap.to(next.container, {
              duration: 0.6,
              clipPath: "inset(0 0 0 0)",
              ease: "expo.inOut",
            });
          },
        },
      ],
    });

    return () => barba.destroy();
  }, []);

  return <>{children}</>;
}
```

**중요**: Barba.js 는 Next.js App Router 와 충돌 가능 — `next/link` 의 default prefetch + soft navigation 과 race. brutalist-architecture 처럼 traditional MPA 톤에서 적용 우선. SPA 톤은 snippet #42-#44 View Transitions API 권장.

---

## Snippet 39 — Flip cross-page shared element transition

<!-- motion-snippet: name=flip-cross-page stack=gsap -->

**출처**: Better Off Lookback project (Codrops 2026 case study).

**Use case**: 작품 리스트 → detail 이동 시 thumbnail 이 hero 로 morph. agency-portfolio / editorial 톤. Next.js App Router + parallel routes 와 결합.

```tsx
"use client";

import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";
import { Flip } from "gsap/Flip";
import { useRouter } from "next/navigation";

if (typeof window !== "undefined") {
  gsap.registerPlugin(Flip);
}

export function ProjectThumbnail({ id, src, alt }: { id: string; src: string; alt: string }) {
  const router = useRouter();

  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    e.preventDefault();

    // 1. Capture current Flip state
    const state = Flip.getState(`[data-flip-id="${id}"]`);

    // 2. Add temporary class for cross-page persistence
    const el = document.querySelector<HTMLElement>(`[data-flip-id="${id}"]`);
    if (el) el.classList.add("flip-transitioning");

    // 3. Navigate (Next.js soft nav)
    router.push(`/projects/${id}`);

    // 4. 새 페이지 마운트 후 Flip.from 으로 reposition (useGSAP 또는 useEffect 안에서)
    requestAnimationFrame(() => {
      Flip.from(state, {
        duration: 0.8,
        ease: "expo.inOut",
        absolute: true,
        targets: `[data-flip-id="${id}"]`,
      });
    });
  };

  return (
    <a href={`/projects/${id}`} onClick={handleClick}>
      <img data-flip-id={id} src={src} alt={alt} />
    </a>
  );
}
```

**Use case**: 동일 `data-flip-id` 가 list page 와 detail page 양쪽에 존재해야 — shared element identity 핵심. View Transitions API 의 `view-transition-name` 과 호환 (snippet #42-#43 참고).

---

## Snippet 40 — easeReverse for menu / drawer interruptible toggle

<!-- motion-snippet: name=ease-reverse-toggle stack=gsap -->

**출처**: GSAP 3.15 release note + Codrops 2026-04-22 "A Playful Clip Menu with GSAP's easeReverse".

**Use case**: nav menu open/close, drawer, accordion — 사용자가 mid-animation 에 reverse 클릭 해도 자연스럽게 되돌아가는 패턴. 기존 `tl.reverse()` 는 ease 가 mirror 안 되어 어색.

```tsx
"use client";

import { useRef, useState } from "react";
import { useGSAP } from "@gsap/react";
import { gsap } from "gsap";

export function ClipMenu() {
  const tlRef = useRef<gsap.core.Timeline | null>(null);
  const [isOpen, setIsOpen] = useState(false);

  useGSAP(() => {
    // ease + easeReverse 둘 다 명시 — reverse 시 다른 ease 적용
    const tl = gsap.timeline({ paused: true });
    tl.to(".clip-menu", {
      clipPath: "inset(0 0 0 0)",
      duration: 0.6,
      ease: "expo.out",
      easeReverse: "expo.in",  // GSAP 3.15+ — reverse direction 의 ease
    });
    tl.from(
      ".menu-item",
      {
        y: 20,
        opacity: 0,
        stagger: 0.05,
        duration: 0.4,
        ease: "power2.out",
        easeReverse: "power2.in",
      },
      "-=0.2"
    );
    tlRef.current = tl;
  }, []);

  const toggle = () => {
    if (!tlRef.current) return;
    setIsOpen((prev) => {
      const next = !prev;
      if (next) tlRef.current!.play();
      else tlRef.current!.reverse();
      return next;
    });
  };

  return (
    <>
      <button onClick={toggle} aria-expanded={isOpen}>
        {isOpen ? "Close" : "Menu"}
      </button>
      <div className="clip-menu" style={{ clipPath: "inset(100% 0 0 0)" }}>
        {/* menu items */}
      </div>
    </>
  );
}
```

**중요**: `easeReverse` 는 GSAP 3.15+ (2026 release). 그 이전 버전은 `reversed: false` + 별도 timeline pair 패턴 필요.

---

## v1.9.6 cluster matrix 업데이트

| Cluster | 신규 추가 권장 snippet |
|---|---|
| A Brutalist agency | #36 matchMedia + #38 Barba transition |
| B Cinematic immersion auto | #35 GSAP→WebGL bridge + #37 Lenis ticker v2 |
| C Interactive playground (DSP 신규 필요) | #36 + #40 easeReverse + #26 Draggable |
| D Editorial horizontal (DSP 신규 필요) | #34 ScrollTo + #38 Barba + #39 Flip |
| E AI Observability SaaS (DSP 신규 필요) | #33 MorphSVG→DrawSVG + #36 + #39 Flip |
| F Playful illustrated (DSP 신규 필요) | #27 elastic CTA + #40 easeReverse |
| G ASCII typography only | #36 (모든 cluster 공통) |


---

# v1.10.1 — Scroll-driven WebGL fidelity snippets (#41-#45)

2026-05-21 BP research 기반. oryzo.ai 류 cinematic WebGL scroll-driven 사이트 motion fidelity 가능하게 하는 production-grade 패턴 5개. analyze-reference skill 의 Phase 3 build 에서 canvas count 따라 tier 분기:

| canvas count | Tier | 적용 snippet |
|---|---|---|
| 0 | DOM-only | 기존 #1-#40 |
| 1-3 | Tier A image sequence | **#41** imageSequenceScrub (Apple AirPods 패턴, 80% fidelity) |
| 4+ + 3D 모델 추정 | Tier B R3F + GLTF | **#42 + #43** (95% fidelity, heavy bundle) |
| Lusion-tier signature | Tier C Lusion-Scroll-Sync | **#44** (정확한 pattern, MIT, 315 stars) |
| Fast prototype | Tier D Spline | **#45** (no-code 3D, mobile fallback 의무) |

---

## Snippet 41 — GSAP imageSequenceScrub (Apple AirPods Pro 패턴)

<!-- motion-snippet: name=image-sequence-scrub stack=gsap -->

**출처**: GSAP official helper https://gsap.com/docs/v3/HelperFunctions/helpers/imageSequenceScrub. Apple AirPods Pro 마케팅 페이지 = 132 frames PNG scrub. GSAP **Webflow acquisition (2024+) 으로 완전 무료**.

**Use case**: cinematic product showcase (oryzo.ai / Apple AirPods / Polestar) — pre-rendered 3D scene frame sequence 를 scroll 따라 canvas 에 draw. 80% Apple-tier fidelity, R3F 대비 훨씬 가벼움 (no Three.js bundle).

**Frame source 옵션**:
1. AI video (Veo3 / Sora) → ffmpeg PNG sequence (`ffmpeg -i input.mov -vf fps=30 frame_%04d.png`)
2. R3F headless render → frame export
3. After Effects / Blender → frame export
4. Codex `gpt-image-1` 12-30장 photographic angles (cheap fallback)

```tsx
"use client";

import { useEffect, useRef } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger);
}

/**
 * GSAP imageSequenceScrub helper (verbatim from GSAP docs).
 * Frames preloaded → drawn to canvas on scroll position.
 * Apple AirPods Pro 패턴 — 132 frames, scrub: 0.5 smoothing.
 */
function imageSequence(config: {
  urls: string[];
  canvas: HTMLCanvasElement;
  scrollTrigger: ScrollTrigger.Vars;
  paused?: boolean;
  fps?: number;
  onUpdate?: (state: { frame: number }) => void;
}) {
  const playhead = { frame: 0 };
  const canvas = config.canvas;
  const context = canvas.getContext("2d");
  if (!context) return;

  const images: HTMLImageElement[] = [];
  const updateImage = () => {
    const img = images[Math.round(playhead.frame)];
    if (!img) return;
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.drawImage(img, 0, 0, canvas.width, canvas.height);
  };

  // Preload all images
  Promise.all(
    config.urls.map((url, i) => {
      return new Promise<void>((resolve) => {
        const img = new Image();
        img.onload = () => {
          images[i] = img;
          if (i === 0) updateImage();
          resolve();
        };
        img.onerror = () => resolve();
        img.src = url;
      });
    }),
  ).then(() => {
    gsap.to(playhead, {
      frame: images.length - 1,
      ease: "none",
      onUpdate: updateImage,
      scrollTrigger: config.scrollTrigger,
    });
  });
}

export function ImageSequenceHero({ frames }: { frames: string[] }) {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    if (!canvasRef.current) return;
    const canvas = canvasRef.current;
    // HiDPI 대응
    const dpr = Math.min(2, window.devicePixelRatio || 1);
    canvas.width = window.innerWidth * dpr;
    canvas.height = window.innerHeight * dpr;
    canvas.style.width = "100%";
    canvas.style.height = "100%";

    imageSequence({
      urls: frames,
      canvas,
      scrollTrigger: {
        trigger: canvas,
        start: "top top",
        end: "+=3000",        // scroll 거리 3000px = 132 프레임
        scrub: 0.5,           // 부드러운 smoothing
        pin: true,
        snap: 1 / (frames.length - 1),  // half-frame 방지
        invalidateOnRefresh: true,
      },
    });
  }, [frames]);

  return (
    <canvas
      ref={canvasRef}
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        width: "100vw",
        height: "100vh",
        zIndex: 0,
      }}
    />
  );
}
```

**Frame size budget** (Apple AirPods Pro reference):
- 132 frames × 1920×1080 JPEG q75 = 50-80KB/frame = **~10MB total**
- Mobile 변형: 132 frames × 720×1280 = ~3-5MB
- Reduced motion fallback: first frame only (`if reduce → context.drawImage(images[0])` after preload)

**MUST USE**: oryzo.ai / Apple-style 사이트 적용 시 R3F 대신 image sequence 가 더 가볍고 fidelity 비슷. 단 frames 가 production-quality 여야 (low-res frames = cheap look).

---

## Snippet 42 — R3F ScrollControls + drei (Tesla walkthrough 패턴)

<!-- motion-snippet: name=r3f-scrollcontrols stack=r3f -->

**출처**: `@react-three/drei` official `<ScrollControls>` + `<Scroll>` + `useScroll()` API. Production: `ashgole/r3f_walkthrough` Tesla showcase (Next.js + R3F). Builder.io 2025-10 tutorial.

**Use case**: 사용자 own 3D scene (GLTF model 로딩 + scroll-camera path). image sequence 보다 무겁지만 (R3F ~150KB + Three.js ~600KB + GLTF model varies) **fidelity 95%**, interaction 가능.

**의존성 추가 필요** (현재 plugin demo 미포함):
```bash
npm install three @react-three/fiber @react-three/drei
```

```tsx
"use client";

import { Suspense } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import {
  ScrollControls,
  Scroll,
  useScroll,
  useGLTF,
  Environment,
  PreloadAll,
} from "@react-three/drei";
import * as THREE from "three";
import { useRef } from "react";

function CoasterModel() {
  // GLTF model from Poly Pizza CC0 또는 자체 .glb
  const { scene } = useGLTF("/models/coaster.glb");
  const meshRef = useRef<THREE.Group>(null);
  const scroll = useScroll();

  useFrame(() => {
    if (!meshRef.current) return;
    // scroll.offset = 0 to 1 (전체 페이지 scroll progress)
    // scroll.range(start, length) = 특정 구간만 normalize
    const r1 = scroll.range(0 / 4, 1 / 4);    // 0-25%
    const r2 = scroll.range(1 / 4, 1 / 4);    // 25-50%
    const r3 = scroll.range(2 / 4, 1 / 4);    // 50-75%
    const r4 = scroll.range(3 / 4, 1 / 4);    // 75-100%

    // 각 구간마다 다른 transform
    meshRef.current.rotation.y = r1 * Math.PI * 2;   // 0-25% — 한 바퀴 회전
    meshRef.current.position.y = -r2 * 0.5;           // 25-50% — 아래로 0.5 이동
    meshRef.current.scale.setScalar(1 + r3 * 0.3);    // 50-75% — 30% 확대
    meshRef.current.rotation.x = r4 * Math.PI * 0.5;  // 75-100% — 90° tilt
  });

  return <primitive ref={meshRef} object={scene} />;
}

useGLTF.preload("/models/coaster.glb");  // SSR-safe preload

export function R3FProductHero() {
  return (
    <Canvas camera={{ position: [0, 0, 4], fov: 35 }} dpr={[1, 2]}>
      <Suspense fallback={null}>
        <Environment preset="studio" />  {/* HDRI for realistic material */}
        <ScrollControls pages={4} damping={0.15}>
          <CoasterModel />
          <Scroll html>
            {/* DOM content overlay synced with scroll */}
            <div style={{ height: "400vh", position: "relative" }}>
              <div style={{ position: "absolute", top: "10vh" }}>
                <h1>ORYZO</h1>
              </div>
              <div style={{ position: "absolute", top: "110vh" }}>
                <h2>ISN'T JUST A COASTER.</h2>
              </div>
              {/* ... */}
            </div>
          </Scroll>
        </ScrollControls>
      </Suspense>
    </Canvas>
  );
}
```

**Performance budget**:
- R3F + drei + Three.js: ~600KB-1MB gzipped runtime
- GLTF model: 50KB-500KB (low-poly preferred)
- Mobile fallback 의무 (`matchMedia("(max-width: 768px)")` → static image)
- DPR cap `[1, 2]` (3+ retina 에서 over-render 차단)

---

## Snippet 43 — GLTF model preload + scroll-camera tween

<!-- motion-snippet: name=gltf-preload-camera stack=r3f -->

**출처**: `@react-three/drei` `useGLTF.preload()` + Codrops Theatre.js camera fly-through tutorial.

**Use case**: 무료 3D 모델 사용 + scroll 따라 카메라가 model 주변 orbital path 이동. 정적 model 회전 (snippet #42) 보다 cinematic.

```tsx
"use client";

import { useEffect, useRef } from "react";
import { useThree } from "@react-three/fiber";
import { useScroll } from "@react-three/drei";
import * as THREE from "three";

// Pre-defined camera path (key frames)
const cameraPath = [
  { position: [0, 0, 4], lookAt: [0, 0, 0] },        // start
  { position: [3, 1, 3], lookAt: [0, 0, 0] },        // orbit right
  { position: [0, 2, 2], lookAt: [0, 0, 0] },        // top down
  { position: [-3, 1, 3], lookAt: [0, 0, 0] },       // orbit left
  { position: [0, 0, 4], lookAt: [0, 0, 0] },        // return
];

export function ScrollCameraRig() {
  const { camera } = useThree();
  const scroll = useScroll();

  useFrame(() => {
    const t = scroll.offset;  // 0-1 dampened scroll progress
    const idx = Math.floor(t * (cameraPath.length - 1));
    const localT = (t * (cameraPath.length - 1)) % 1;

    const from = cameraPath[idx];
    const to = cameraPath[Math.min(idx + 1, cameraPath.length - 1)];

    // Lerp between key positions
    camera.position.lerpVectors(
      new THREE.Vector3(...from.position),
      new THREE.Vector3(...to.position),
      localT,
    );
    camera.lookAt(
      new THREE.Vector3(...to.lookAt).lerp(
        new THREE.Vector3(...from.lookAt),
        1 - localT,
      ),
    );
  });

  return null;
}

// Free 3D model sources (commercial-acceptable):
// - Poly Pizza (poly.pizza/u/Quaternius) — CC0 1411 models, no login
// - Sketchfab Free 3D filtered CC0
// - Quaternius packs (ultimatespacekit / ultimateweaponskit / etc)
```

---

## Snippet 44 — Lusion WebGL-Scroll-Sync pattern (oryzo.ai 정확한 패턴)

<!-- motion-snippet: name=lusion-scroll-sync stack=webgl -->

**출처**: https://github.com/lusionltd/WebGL-Scroll-Sync (MIT, 315 stars, 2025-04) — Lusion Studio 본인이 공개한 production pattern. 본 패턴이 oryzo.ai 같은 사이트의 핵심 기술.

**Use case**: cinematic immersion DSP cluster B 의 진짜 ground truth. R3F 보다 더 low-level — single fullscreen canvas + DOM bbox sync 으로 scroll-jacking 없이 native scroll 유지.

**핵심 아이디어 verbatim from Lusion**:
> "Create a single fullscreen WebGL canvas, fixed to the viewport, and render everything there. Then, during each rAF, you get the bounding box of your DOM elements and scroll position (window.scrollY) to position your 3D objects accordingly"

```tsx
"use client";

import { useEffect, useRef } from "react";
import * as THREE from "three";

export function LusionScrollSync() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const rafRef = useRef<number | null>(null);

  useEffect(() => {
    if (!canvasRef.current) return;
    const canvas = canvasRef.current;

    // 1. Setup fullscreen WebGL canvas (fixed viewport)
    const renderer = new THREE.WebGLRenderer({ canvas, antialias: true, alpha: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(Math.min(2, window.devicePixelRatio));

    const scene = new THREE.Scene();
    const camera = new THREE.OrthographicCamera(
      -window.innerWidth / 2, window.innerWidth / 2,
      window.innerHeight / 2, -window.innerHeight / 2,
      -1000, 1000,
    );

    // 2. Find DOM placeholders (e.g., <div data-webgl="coaster"></div>)
    const placeholders = Array.from(
      document.querySelectorAll<HTMLElement>("[data-webgl]"),
    );

    const meshes = placeholders.map((el) => {
      const id = el.dataset.webgl;
      const geometry = new THREE.PlaneGeometry(1, 1);
      const material = new THREE.MeshBasicMaterial({ color: 0xffaa00 });
      // 실제로는 GLTF / shader material 등 id 별 다른 mesh 생성
      const mesh = new THREE.Mesh(geometry, material);
      scene.add(mesh);
      return { el, mesh };
    });

    // 3. Per-frame: sync mesh position to DOM bbox
    const tick = () => {
      meshes.forEach(({ el, mesh }) => {
        const rect = el.getBoundingClientRect();
        // Convert DOM coordinate to WebGL world coordinate
        const x = rect.left + rect.width / 2 - window.innerWidth / 2;
        const y = -(rect.top + rect.height / 2 - window.innerHeight / 2);
        mesh.position.set(x, y, 0);
        mesh.scale.set(rect.width, rect.height, 1);
      });
      renderer.render(scene, camera);
      rafRef.current = requestAnimationFrame(tick);
    };
    rafRef.current = requestAnimationFrame(tick);

    // 4. Resize handler
    const onResize = () => {
      renderer.setSize(window.innerWidth, window.innerHeight);
      camera.left = -window.innerWidth / 2;
      camera.right = window.innerWidth / 2;
      camera.top = window.innerHeight / 2;
      camera.bottom = -window.innerHeight / 2;
      camera.updateProjectionMatrix();
    };
    window.addEventListener("resize", onResize);

    return () => {
      if (rafRef.current) cancelAnimationFrame(rafRef.current);
      window.removeEventListener("resize", onResize);
      renderer.dispose();
    };
  }, []);

  return (
    <canvas
      ref={canvasRef}
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        width: "100vw",
        height: "100vh",
        zIndex: 0,
        pointerEvents: "none",
      }}
    />
  );
}

// Usage in JSX:
// <LusionScrollSync />  (fixed background WebGL layer)
// ...
// <h1>ORYZO</h1>
// <div data-webgl="coaster" style={{ width: 500, height: 500 }} />  {/* Mesh fills this bbox */}
// <p>...</p>
```

**중요**:
- Lusion 본인이 production 에 사용하는 패턴
- Native scroll 유지 (scroll-jacking 없음)
- DOM 은 정상 작동 (a11y / SEO 정상)
- WebGL 은 visual layer 만
- 우리 plugin 의 cinematic-immersion-auto cluster B 의 정확한 reference pattern

---

## Snippet 45 — Spline embed (no-code 3D fast prototype)

<!-- motion-snippet: name=spline-embed stack=spline -->

**출처**: https://docs.spline.design/exporting-your-scene/web/exporting-as-code + Next.js integration `@splinetool/react-spline/next`.

**Use case**: 빠른 prototyping — 사용자가 Spline editor 에서 3D scene 만든 후 React embed. **단, scene 크기 2-5MB + Spline runtime 부담** (mobile 에서 GPU 무겁) — production cinematic 적용 시 R3F 권장.

**Trade-off**:
- ✅ Fast authoring (no Three.js code)
- ✅ Built-in Spline interactions / animations
- ❌ 2-5MB scene bundle
- ❌ Mobile GPU 부담
- ❌ Animation event export 는 Vanilla JS / React only — Three.js / R3F export 시 geometry/materials 만

```bash
npm install @splinetool/react-spline
```

```tsx
"use client";

import dynamic from "next/dynamic";
import { Suspense } from "react";

// SSR-safe lazy load + Spline runtime mobile fallback
const Spline = dynamic(() => import("@splinetool/react-spline/next"), {
  ssr: false,
  loading: () => (
    <div style={{
      width: "100%",
      height: "100vh",
      background: "var(--canvas)",
      display: "grid",
      placeItems: "center",
    }}>
      <span style={{ color: "var(--ink-quiet)" }}>Loading 3D scene...</span>
    </div>
  ),
});

export function SplineHero() {
  // Mobile fallback — static image
  if (typeof window !== "undefined" && window.matchMedia("(max-width: 768px)").matches) {
    return (
      <div style={{ width: "100%", height: "100vh", position: "relative" }}>
        <img src="/oryzo/hero-stilllife.png" alt="" style={{ objectFit: "cover", width: "100%", height: "100%" }} />
      </div>
    );
  }

  return (
    <Suspense fallback={null}>
      <Spline
        scene="https://prod.spline.design/your-scene-id/scene.splinecode"
        style={{ width: "100%", height: "100vh" }}
      />
    </Suspense>
  );
}
```

**MUST USE only**:
- Spline pro-tier 사용 시
- Scene size ≤ 2MB
- Desktop primary (mobile fallback static)
- Cinematic scroll-driven NOT 필요한 경우 (Spline 의 scroll 통합은 R3F 보다 제한적)

---

## v1.10.1 cluster matrix 업데이트

| Cluster | Tier A (image seq) | Tier B (R3F GLTF) | Tier C (Lusion sync) | Tier D (Spline) |
|---|---|---|---|---|
| A Brutalist agency | optional decorative | NO (overkill) | NO | NO |
| **B Cinematic immersion auto** | **#41 권장** (Apple AirPods 패턴) | **#42 + #43** (full 3D) | **#44 (정확한 BP, Lusion 본인 pattern)** | optional |
| C Interactive playground | NO | optional | NO | OK fast proto |
| D Editorial horizontal | optional | NO | NO | NO |
| E AI Observability SaaS | optional data viz | optional | NO | NO |
| F Playful illustrated | Lottie 대체 | NO | NO | OK fast proto |
| G ASCII typography | NO | NO | NO | NO |

**analyze-reference skill auto-detection logic**:
```
canvas count === 0:  Tier 0 (DOM only)
canvas count 1-3:    Tier A (image sequence — #41)
canvas count 4+:     Tier C (Lusion sync — #44) 권장, Tier B (R3F + GLTF — #42/#43) 도 가능
명시적 Spline:       Tier D (#45)
```


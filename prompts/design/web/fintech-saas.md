---
name: fintech-saas
type: design-system-prompt
domain: Fintech / B2B Financial SaaS (payments infra, data analytics, risk management)
tone: precision, trustworthy, technical, dense, monochrome-with-single-accent
reference: Stripe (Söhne), Mercury (Arcadia), Linear (Inter Variable 510 + Berkeley Mono), Vercel (Geist), Ramp (Lausanne ss01)
version: "3.0.0"
vault-source: "Intellieffect-Vault 08-Resources/Marketing/랜딩페이지 레퍼런스/00-패턴 요약.md"
---

# Design System Prompt — Fintech SaaS (v2)

> 사용 패턴: designer agent 호출 시 spec body에 본 파일 verbatim 인용. 결과물은 **award-grade** 수준이어야 함 — "잘 만든 SaaS template" 수준은 failure.

첨부된 레퍼런스를 분석하여 풀-와이드 섹션을 디자인하라. 본 DSP는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Fintech / B2B Financial SaaS** — Stripe·Mercury·Linear·Vercel·Ramp 수준의 정밀한 craft signal을 목표로 한다.

**중요 (v2.0 추가):** 본 DSP의 약 70%는 **banned 패턴 명시 (negative constraint)** 다. LLM이 학습 corpus의 median ("Inter 700 + purple gradient + 3-card bento + 7:5 split hero")으로 수렴하는 걸 적극 차단한다. Positive spec만 따르면 award-grade가 안 나온다.

---

## 1. Design System Definition

### 1.1 Color (strict ratio)

- **Canvas:** `#FBFBFB` (near-white paper — pure `#FFFFFF` 금지)
- **Ink:** `#0E1014` (heading · 핵심 수치 — pure `#000000` 금지)
- **Body:** `#62656A` (보조 라벨 · 본문)
- **Hairline:** `rgba(14, 16, 20, 0.08)` (border · divider 전용)
- **Accent:** `#1E4DB7` (deep ink blue) — **page surface의 5-10%만 차지 강제** (CTA · brand mark · 핵심 highlight 한정. Section title이나 일반 link에는 사용 금지)
- **Negative semantic:** `#B7281E` (loss · chargeback · error 한정. UI 장식에 사용 금지)
- **Positive semantic:** `#1E7A4A` (gain · success 한정. 같은 룰)

### 1.2 Typography (3-family, 비-표준 weight + tracking 기반 hierarchy)

**Display:** `Söhne` 또는 `Inter Display` 또는 `Geist` (grotesk display)
**Body:** `Inter Variable` (Linear-style 510 weight) 또는 `Geist 400/500`
**Mono:** `Berkeley Mono` 또는 `Geist Mono` — 모든 numeric · transaction ID · API key · code snippet 강제

**Weight scale (좁게 강제):**
- Display: `400` 또는 `500` (Mercury/Stripe-style — heavy weight 금지)
- Body emphasis: `510` (Inter Variable 비-표준 weight) 또는 `590`
- Body regular: `400`
- **`font-weight: 700`/`800` 일체 금지** (가장 강한 AI-template 시그널)

**Tracking (size별 progressive 강제):**
- `48px+` display → `letter-spacing: -0.05em` (= `-2.4px@48px`)
- `32px` → `-0.04em` (-1.28px)
- `24px` → `-0.04em` (-0.96px)
- `16px` → `-0.02em` (-0.32px)
- `14px` 이하 → `normal`

**OpenType features (글로벌 mandatory):**

```css
body, [data-numeric] {
  font-feature-settings: "tnum", "ss01", "cv01", "ss03";
  font-variant-numeric: tabular-nums slashed-zero;
}
```

모든 숫자가 자동으로 tabular 정렬 + slashed-zero. 누락 = AI-template 시그널.

**Headline casing:** **sentence-case only.** Title Case ("The Best Platform For Modern Teams") 절대 금지. 좋은 예: "Banking — redesigned from the ground up" (Mercury), "Develop. Preview. Ship." (Vercel), "Payments infrastructure for the internet" (Stripe).

### 1.3 Border Radius (restraint)

- Buttons: `6-8px` (절대 `rounded-2xl` 16px 이상 금지)
- Cards: `8-12px`
- Inputs: `4-6px`
- Pills (badge · marketing CTA 한정): `999px` 허용
- 이외 모든 element는 sharp edge 또는 위 token

### 1.4 Shadow (3-layer stack, single drop 금지)

```css
/* 모든 elevated surface 표준 */
box-shadow:
  0 0 0 1px rgba(14, 16, 20, 0.08),    /* hairline ring */
  0 2px 2px rgba(14, 16, 20, 0.04),    /* soft drop */
  inset 0 0 0 1px rgba(250, 250, 250, 1);  /* inner highlight */
```

- Hover 시 두 번째 layer 강화: `0 8px 24px -8px rgba(14, 16, 20, 0.08)` 추가
- **`shadow-lg` / `shadow-xl` 단일 drop 금지** (가장 흔한 AI-template 시그널)
- 카드에 backdrop-blur 일체 금지 (nav 한정 허용)

### 1.5 Icon Style

- Monoline stroke `1.5px`, 단색 (`#0E1014` 또는 `#62656A`), 배경 없음
- Phosphor Light 또는 Lucide 기반
- **컬러 아이콘 · 3D 아이콘 · gradient stroke · emoji 일체 금지**
- 카테고리 icon은 동일한 24×24 또는 20×20 viewbox 강제

---

## 2. Layout & Structure

### 2.1 Banned hero layouts (반드시 회피)

다음은 모두 LLM의 default median — 어느 페이지에도 사용 금지:

- ❌ **Split 7:5 with text-left + product-mock-right** — 가장 흔한 AI-template fintech hero
- ❌ **Centered hero with stacked CTA pair (Primary + Ghost 중앙 정렬)** — SaaS default
- ❌ **3-up uniform feature grid** (icon + title + 2-line desc × 3)
- ❌ **3-tier identical pricing card** (Standard / Pro / Enterprise 동일 너비)
- ❌ **6-up uniform bento** (모든 셀 같은 크기)

### 2.2 Allowed hero patterns (다음 중 commit)

다음 4가지 중 페이지마다 **1개 선택**, 사이트 전체 일관성 유지:

**Option A — Asymmetric single-column left-aligned:**
- 좌측 60% 콘텐츠 (eyebrow + headline + sub + Primary CTA) + 우측 40% generous whitespace
- 우측에 작은 mono caption block 또는 single metric (선택)
- Product mock은 hero 아래 별도 섹션

**Option B — Full-bleed cinematic atmosphere → text-only below:**
- 상단 60% full-bleed gradient mesh 또는 atmospheric photography
- 하단 40% text-only (display headline + sub + Primary CTA)
- Mercury 패턴

**Option C — Editorial single-column with side meta:**
- 좌측 main column 8-col (headline + drop cap intro + body)
- 우측 4-col에 mono meta (issue number, date, byline, page folio)
- Magazine 패턴, Stripe Press 스타일

**Option D — Magazine spread with asymmetric bento:**
- 12-col grid, 1 dominant cell (8 col × 2 row) + smaller cells (4 col × 1 row each)
- Dominant cell에 hero copy, smaller cells에 metric / chart / illustration / testimonial 혼합
- 모든 셀 다른 콘텐츠 type — 동일 콘텐츠 type 반복 금지

### 2.3 Grid

- 12-column grid, gutter `24px`
- Desktop padding `64px` (시각적 generous), Mobile `24px`
- Max-width `1280px` (콘텐츠) — full-bleed visual은 max-width 없음
- Responsive: `<1024px` vertical stack, asymmetric balance 유지

### 2.4 Negative space (mandatory)

- Section vertical spacing: `120-200px` desktop (답답한 `64px` 금지)
- Hero 하단 `160px` 이상 여백
- Body line-height `1.55-1.65` (cramped `1.2-1.4` 금지)

---

## 3. UI Elements & Animation

### 3.1 Button variants (cva + cn(twMerge+clsx) 강제)

- **Primary:** `#1E4DB7` solid, text `#FBFBFB`, radius `6px`, padding `10px 18px`, weight `500`, font-feature-settings 활성. Hover: `filter: brightness(1.04)` only — scale/translate 금지.
- **Ghost:** transparent, border `1px rgba(14,16,20,0.14)`, text `#0E1014`. Hover: background `rgba(14,16,20,0.04)`.
- **Tertiary (inline link):** text `#1E4DB7`, underline on hover only with `4px` offset.
- **Marketing CTA (hero 전용):** `100px` pill 허용, padding `14px 28px`, weight `500`.

페이지당 **Primary 1개**, Ghost 최대 1개, Tertiary 자유. 3 CTA 이상 horizontal stacking 금지.

### 3.2 Card (3-layer shadow + hairline)

```css
.card {
  background: #FFFFFF;
  border-radius: 10px;
  padding: 28px;
  box-shadow:
    0 0 0 1px rgba(14, 16, 20, 0.08),
    0 2px 2px rgba(14, 16, 20, 0.04),
    inset 0 0 0 1px #fafafa;
  transition: box-shadow 200ms cubic-bezier(0.2, 0, 0, 1);
}
.card:hover {
  box-shadow:
    0 0 0 1px rgba(14, 16, 20, 0.12),
    0 8px 24px -8px rgba(14, 16, 20, 0.08),
    inset 0 0 0 1px #fafafa;
}
```

### 3.3 Badge (mono uppercase pill)

```css
.badge {
  font-family: var(--font-mono);
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  background: rgba(30, 77, 183, 0.08);
  color: #1E4DB7;
  padding: 4px 10px;
  border-radius: 999px;
}
```

### 3.4 Keyboard shortcut display (`⌘ K` pattern)

Command-driven action에 강제 — 검색·shortcuts·dialog:

```css
.kbd {
  font-family: var(--font-mono);
  font-size: 11px;
  font-weight: 500;
  color: #62656A;
  padding: 2px 6px;
  border: 1px solid rgba(14, 16, 20, 0.10);
  border-radius: 4px;
  background: #FFFFFF;
  box-shadow: inset 0 -1px 0 rgba(14, 16, 20, 0.06);
}
```

예: `<kbd>⌘ K</kbd> to search`

### 3.5 Navigation

- Height `64px`, sticky top
- Background `rgba(251, 251, 251, 0.85)` + `backdrop-filter: saturate(180%) blur(8px)` (nav 한정 허용)
- Hairline bottom border on scroll only
- Logo + 4-6 menu items (lowercase 또는 sentence-case) + Sign in tertiary + Primary CTA
- Active state: ink color + 2px bottom border accent

### 3.6 Animation (Framer Motion / Motion One)

- Duration `150-200ms`, easing `cubic-bezier(0.2, 0, 0, 1)` (Linear-style)
- **Transform · opacity only.** Filter blur · color · width/height animation 금지
- Hero 진입: text staggered reveal, `y: 8px → 0`, opacity `0 → 1`, stagger `40ms`
- Variable font weight transition on hover: `400 → 510` over 150ms — Linear-style craft signal
- View Transitions API for route changes (Chrome 111+)
- Scroll-driven typography reveal with `clip-path` mask (CSS Scroll-driven animations)
- **Bouncy spring · overshoot · elastic 일체 금지**
- **Parallax · scroll-hijacking · marquee 일체 금지**

### 3.7 Visual hook (페이지 전체에 단일 선택)

다음 5가지 중 **정확히 1개** 선택. 2개 이상 mix는 AI-template 시그널 → failure:

1. **Gradient mesh art** — DSP brand color 안에서만 (purple→blue 절대 금지). 예: `radial-gradient(ellipse at 80% 0%, rgba(30,77,183,0.08), transparent 60%)`. Hero 상단에만 isolate.
2. **Cinematic photography** — single subject + dramatic lighting + atmospheric. Mercury 패턴. Stock photography 금지 (art-directed commissioned only).
3. **3D card/product render** — Spline 또는 R3F. Brex 패턴. AI-generated 3D 금지.
4. **Branded illustration system** — Bento-style graphic system (Ramp 패턴) 또는 hand-drawn editorial illustration.
5. **Pure typography (visual hook 0)** — display headline + generous whitespace + minimal supporting type만. Vercel 패턴.

---

## 4. Consistency Mandate

### 4.1 적용 범위

이후 제작되는 모든 섹션 (Features · Customer logos · Use cases · Pricing · Docs preview · Footer) 및 서브 페이지 (Product · Pricing · Customers · Docs · Changelog · Blog) 위 Design System Definition을 엄격 준수.

### 4.2 Banned patterns (필수 회피 — failure 사유)

**Typography:**
- ❌ Inter weight 700 또는 800 헤드라인 (가장 강한 AI-template 시그널)
- ❌ 단일 family (Inter only) 사용 — display + body + mono 3-family 강제
- ❌ Title Case headlines ("The Best Platform For Modern Teams")
- ❌ `letter-spacing: normal` on 48px+ display
- ❌ `font-feature-settings` 누락 (tnum/ss01 글로벌 활성화 필수)
- ❌ Gradient text on headline/metric

**Color:**
- ❌ Tailwind `indigo-500` (`#6366f1`), `violet-*`, `purple-*`, `sky-*`
- ❌ Purple → blue gradient background (Stripe mimicry)
- ❌ Pure `#000000` / `#ffffff`
- ❌ 다중 saturated accent (rainbow palette)
- ❌ Neon accent · saturated cyan/magenta

**Layout:**
- ❌ Split 7:5 hero (text-left + UI screenshot right)
- ❌ Centered hero with stacked Primary + Ghost CTA pair
- ❌ 3-up uniform feature card grid
- ❌ 3-tier identical pricing cards (모든 tier 같은 너비)
- ❌ 6-up uniform bento (모든 cell 같은 크기)
- ❌ Glassmorphism cards (`backdrop-filter: blur` on content)

**Shadow / Radius:**
- ❌ `shadow-lg` / `shadow-xl` 단일 drop
- ❌ `rounded-2xl` (16px) 이상 buttons/cards
- ❌ Bouncy spring / overshoot / elastic easing

**Copy:**
- ❌ "Move money, ship faster"
- ❌ "The all-in-one platform for X"
- ❌ "Built for modern teams"
- ❌ "Powerful, simple, secure"
- ❌ Generic action-verb pair ("Build. Ship. Scale.") 같은 templated

**Icons & visual:**
- ❌ Generic Lucide/Heroicons without customization
- ❌ 3D illustration of "handshake" · "rocket" · "abstract globe"
- ❌ Stock photography
- ❌ Decorative emoji
- ❌ Gradient stroke icons

### 4.3 Required craft signal (모든 페이지에 자동 적용)

- ✅ Tabular-nums on all numeric (counts, amounts, latency, dates, percentages)
- ✅ Single accent strict ratio 5-10% page surface
- ✅ Sentence-case headlines
- ✅ Mono eyebrow + sans headline pairing (eyebrow 11-12px monospace uppercase tracking 0.05em above headline)
- ✅ Asymmetric layout (의도된 visual weight imbalance)
- ✅ Keyboard shortcut display `⌘ K` for command-driven action
- ✅ Inter Variable weight 510 (또는 Söhne weight 360-480) for body emphasis
- ✅ Negative tracking progressively (48px → -0.05em)
- ✅ 3-layer shadow stack (hairline + soft drop + inset highlight)
- ✅ Visual hook 정확히 1개 (선택 후 사이트 전체 일관 적용)

### 4.4 Copy voice patterns (다음 3가지 중 선택)

**Pattern 1 — Brand-specific noun-metaphor + em-dash (Mercury-style):**
- "Banking — redesigned from the ground up"
- "Treasury — for companies that move quickly"

**Pattern 2 — Triple-imperative declarative (Vercel-style):**
- "Develop. Preview. Ship."
- "Build. Test. Deploy."

**Pattern 3 — Single-concept dramatic noun phrase (Stripe-style):**
- "Payments infrastructure for the internet"
- "Settlement, reconciliation, and risk — in one ledger"

위 3 patterns 외의 카피 voice는 사용자 prompt에 명시된 brand voice가 있을 때만 허용. Generic SaaS cliché는 모두 reject.

### 4.5 Data integrity 시그널

- 모든 숫자(금액, 퍼센트, latency, count, ratio)는 mono family + `font-variant-numeric: tabular-nums`
- 천 단위 separator 일관성: `$2,400,000` 또는 `$2.4M` 중 페이지 전체 통일
- Negative value `#B7281E` 또는 mono red — never gradient
- Currency symbol은 amount보다 weight 100-200 낮게 (예: `$2.4M`에서 `$` 는 weight 400, `2.4M` 은 weight 500)

### 4.6 70/30 원칙

본 DSP의 약 70%가 banned 패턴 (negative constraint). 30%가 positive spec. 사용자가 결과물에서 "AI 느낌 난다"고 평가하면, banned list가 부족한 것이지 positive spec이 부족한 것이 아니다. 더 구체적 negative constraint 추가 필요.

이 DSP를 기준으로 전체 사이트의 craft signal을 일관 확장하라. 결과물은 **Stripe·Mercury·Linear·Vercel 수준의 award-grade**여야 한다 — "잘 만든 SaaS template" 수준은 failure.

---

## 5. Interactive Patterns (v2.1 추가 — motion layer)

**Award-grade의 진짜 차이는 motion에서 옴.** Static 텍스트만으로는 절대 도달 불가능. 본 섹션의 spec은 모든 marketing/dashboard 페이지에 강제 적용.

### 5.1 라이브러리 분담 (역할 분리, 충돌 없음)

| 영역 | 라이브러리 | 예시 |
|---|---|---|
| Component lifecycle / gesture / layout | **Framer Motion (motion)** | `useScroll`, `useTransform`, `AnimatePresence`, `layoutId`, `whileTap` |
| Scroll-triggered / timeline / SplitText | **GSAP** | `ScrollTrigger pin/scrub`, `SplitText chars/lines`, complex sequencing |
| Smooth scroll | **Lenis** | root level 1회 init, mobile auto-disable |
| Page navigation | **View Transitions API** (Next.js 15+ `unstable_ViewTransition`) | shared element morph, route crossfade |
| Microinteractions | **CSS-only** | `font-variation-settings` transition, `:hover`, `@keyframes` |
| Avoid | **R3F / Rive / Lottie** | bundle 비용 대비 ROI 낮음. Marketing 페이지에 박지 말 것 (product UI animation은 별개) |

### 5.2 AI-template motion fingerprint (필수 회피 — failure 사유)

다음 5개는 LLM의 motion default — 결과물에 등장 시 즉시 reject:

1. ❌ **모든 element에 0.3s linear fade-in on mount** — Lovable/v0 시그너처. 핵심 hero element만 stagger 적용.
2. ❌ **`scale(1.05) + shadow-lg + transition-all` hover** — generic Tailwind default.
3. ❌ **Bouncy spring buttons** (`stiffness 100 damping 10`) — 모든 버튼에 spring overshoot.
4. ❌ **데코 cursor-follower / meteor / sparkle / 페이지 따라가는 라인** — "the animation was capturing all their attention while the actual product messaging went unread"
5. ❌ **`0.3s ease-in-out` 또는 `linear` everywhere** — easing curve `cubic-bezier(0.22, 1, 0.36, 1)` 또는 `expo.out` 권장

### 5.3 Award-grade interactive spec — 18개 actionable

#### A. Typography motion (5개)

**A1. Variable font weight 400→510 hover transition** (Linear craft signal, fintech-saas 시그너처)
```css
.nav-link, .button-text, .link {
  font-variation-settings: 'wght' 400;
  transition: font-variation-settings 180ms ease-out;
}
.nav-link:hover { font-variation-settings: 'wght' 510; }
```
Library: **CSS-only**. Inter Variable / Geist Variable 필수. `font-weight` 직접 transition은 stepped — `font-variation-settings`만 부드러움.

**A2. Hero headline은 GSAP SplitText chars + scroll-trigger reveal (once)**
```javascript
import { gsap } from 'gsap';
import { SplitText, ScrollTrigger } from 'gsap/all';
gsap.registerPlugin(SplitText, ScrollTrigger);

const split = SplitText.create('.hero-h1', { type: 'chars' });
gsap.from(split.chars, {
  opacity: 0, y: 40, duration: 0.6, stagger: 0.02, ease: 'expo.out',
  scrollTrigger: { trigger: '.hero-h1', start: 'top 85%', once: true }
});
```
Library: **GSAP + SplitText (3.13+ free)**.

**A3. Metric 숫자 count-up (`useInView` 트리거, no bouncy spring — 정확하게 land)**
```jsx
import { useMotionValue, useTransform, animate, useInView } from 'motion/react';
// onInView: animate(count, target, { duration: 1.2, ease: [0.22, 1, 0.36, 1] })
```
Library: **Framer Motion**.

**A4. Logo cloud marquee (가로 무한 스크롤, `ease: 'linear'`, pause on hover)**
```jsx
<motion.div
  animate={{ x: ['0%', '-50%'] }}
  transition={{ duration: 30, ease: 'linear', repeat: Infinity }}
  className="hover:[animation-play-state:paused]"
/>
```
Library: **Framer Motion**.

**A5. Section eyebrow는 mono uppercase tracking-wider, 정적 (no animation)**
```jsx
<p className="font-mono text-xs uppercase tracking-[0.15em] text-neutral-500">
  — 04 / Integrations
</p>
```
Library: **CSS-only**.

#### B. Cursor / hover (3개)

**B1. Primary CTA에만 magnetic button** (spring 150 / damping 15 / mass 0.1, **모든 버튼에 박지 말 것**)
```jsx
import { motion, useState, useRef } from 'motion/react';

const ref = useRef(null);
const [pos, setPos] = useState({ x: 0, y: 0 });
const handleMouse = (e) => {
  const { clientX, clientY } = e;
  const { left, top, width, height } = ref.current.getBoundingClientRect();
  setPos({ x: clientX - (left + width / 2), y: clientY - (top + height / 2) });
};

<motion.button
  ref={ref}
  onMouseMove={handleMouse}
  onMouseLeave={() => setPos({ x: 0, y: 0 })}
  animate={{ x: pos.x, y: pos.y }}
  transition={{ type: 'spring', stiffness: 150, damping: 15, mass: 0.1 }}
/>
```
Library: **Framer Motion**. 페이지당 magnetic button 최대 1개.

**B2. Card hover는 `scale(1.02) + translateY(-2px)` + border-color shift** (NOT `scale(1.05) + shadow-lg`)
```css
.card {
  transition: transform 200ms cubic-bezier(0.22, 1, 0.36, 1), border-color 200ms;
  border: 1px solid theme(neutral.200);
}
.card:hover {
  transform: translateY(-2px) scale(1.02);
  border-color: theme(brand.500);
}
```
Library: **CSS-only**.

**B3. Mouse-move tilt는 의도된 곳 1-2개에만** (3D pin / 직접 만지는 product mock UI 한정)
```jsx
const x = useMotionValue(0);
const y = useMotionValue(0);
const rotateX = useTransform(y, [-100, 100], [10, -10]);
const rotateY = useTransform(x, [-100, 100], [-10, 10]);
```
Library: **Framer Motion**.

#### C. Scroll-driven (4개)

**C1. Page top scroll progress bar** (1px height, brand color)
```jsx
const { scrollYProgress } = useScroll();
<motion.div
  style={{ scaleX: scrollYProgress, transformOrigin: 'left' }}
  className="fixed top-0 inset-x-0 h-px bg-brand-500 z-50"
/>
```
Library: **Framer Motion**.

**C2. "How it works" 3-step은 GSAP pin + scrub 가로 슬라이드**
```javascript
gsap.timeline({
  scrollTrigger: { trigger: '.howit', start: 'top top', end: '+=2000', scrub: 1, pin: true }
})
  .to('.step-1', { autoAlpha: 0 })
  .from('.step-2', { autoAlpha: 0 }, '<')
  .to('.step-2', { autoAlpha: 0 }, '+=0.5')
  .from('.step-3', { autoAlpha: 0 }, '<');
```
Library: **GSAP ScrollTrigger**.

**C3. Feature illustration SVG path scroll-draw** (`pathLength` 0→1)
```jsx
const { scrollYProgress } = useScroll({
  target: svgRef,
  offset: ['start 80%', 'end 20%']
});
<motion.path style={{ pathLength: scrollYProgress }} d="M0,50 ..." />
```
Library: **Framer Motion**.

**C4. Lenis smooth scroll root, mobile auto-disable** (touch hijacking은 평가절하 신호)
```jsx
import { ReactLenis } from 'lenis/react';
<ReactLenis root options={{ lerp: 0.1, smoothTouch: false }}>
  {children}
</ReactLenis>
```
Library: **lenis/react**.

#### D. Page / route transitions (2개)

**D1. Case study / pricing detail은 View Transitions API shared element morph** (Next.js 15+)
```jsx
import { unstable_ViewTransition as ViewTransition } from 'next';

<ViewTransition>
  <Image
    src={card.image}
    style={{ viewTransitionName: `card-${card.id}` }}
  />
</ViewTransition>
```
Library: **Next.js 15+ View Transitions API**.

**D2. Modal / drawer는 `AnimatePresence mode="wait"` + spring 300/24**
```jsx
<AnimatePresence mode="wait">
  {open && (
    <motion.div
      initial={{ y: 20, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      exit={{ y: 20, opacity: 0 }}
      transition={{ type: 'spring', stiffness: 300, damping: 24 }}
    />
  )}
</AnimatePresence>
```
Library: **Framer Motion**.

#### E. Microinteractions (2개)

**E1. Button press는 `whileTap={{ scale: 0.97 }}` + brightness hover** (NOT bouncy spring scale)
```jsx
<motion.button
  whileTap={{ scale: 0.97 }}
  transition={{ duration: 0.1 }}
  className="transition-[filter] hover:brightness-110"
/>
```
Library: **Framer Motion**.

**E2. Loading skeleton shimmer, prefers-reduced-motion에서 정적 회색**
```css
.skeleton {
  background: linear-gradient(90deg, #1a1a1a 0%, #2a2a2a 50%, #1a1a1a 100%);
  background-size: 200% 100%;
  animation: shimmer 1.5s linear infinite;
}
@keyframes shimmer { to { background-position: -200% 0; } }
@media (prefers-reduced-motion: reduce) {
  .skeleton { animation: none; background: #1a1a1a; }
}
```
Library: **CSS-only**.

#### F. 3D / WebGL (1개, 강한 절제)

**F1. Hero gradient mesh — Stripe minigl 패턴 1개만, IntersectionObserver로 viewport 밖 RAF 정지**
```javascript
// stripe-gradient.js (Kevin Hufnagl 패턴, kevinhufnagl/thelevicole 출처)
import { Gradient } from './stripe-gradient.js';
const gradient = new Gradient({
  canvas: '#hero-gradient',
  colors: ['#1E4DB7', '#5C7CF0', '#A3B8F5', '#0E1014']  // DSP brand color 4개만
});

// viewport 가드
const observer = new IntersectionObserver(([entry]) => {
  entry.isIntersecting ? gradient.play() : gradient.pause();
});
observer.observe(canvas);
```
Library: **vanilla JS (kevinhufnagl/thelevicole stripe-gradient)**. **R3F 금지** — bundle 200KB+ ROI 낮음.

#### G. Live data / pulse (1개)

**G1. Live status indicator (실시간 가격·status) 2s breathing pulse**
```css
@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.6; transform: scale(0.9); }
}
.live-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #10b981;
  animation: pulse 2s ease-in-out infinite;
}
@media (prefers-reduced-motion: reduce) {
  .live-dot { animation: none; }
}
```
Library: **CSS-only**.

### 5.4 prefers-reduced-motion 무조건 대응 (accessibility ABSOLUTE)

모든 motion 컴포넌트는 `@media (prefers-reduced-motion: reduce)` fallback 제공. 위반 시 failure.

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

Framer Motion은 자동으로 `useReducedMotion` hook 활용:
```jsx
const shouldReduceMotion = useReducedMotion();
<motion.div transition={shouldReduceMotion ? { duration: 0 } : springConfig} />
```

### 5.5 Motion 디자인 원칙 (verbatim from medium/ketanmk 2026-04-22)

> "the animation was in service of the message. It made you understand the product better. It wasn't decoration for decoration's sake."

본 DSP의 motion 룰 = **purpose-bound only**. Decoration은 자른다. 모든 motion이 "이게 왜 필요한가"에 답할 수 있어야 한다.

---

## 6. Copy Voice & Headline (vault 메타 통합 — v1.5.0 추가)

> 출처: IntelliEffect vault `08-Resources/Marketing/랜딩페이지 레퍼런스/00-패턴 요약.md`. 17개 글로벌+한국 사이트 분석 결과를 fintech-saas DSP에 verbatim 통합.

fintech-saas 톤은 7가지 헤드라인 공식 중 **A (카테고리 재정의)** 또는 **F (행동 동사)** 우선. 다른 공식 (선언/부정/통합)도 사용 가능하되 commit해서 사이트 전체 일관성 유지.

### 6.1 fintech-saas 권장 headline 패턴

**Pattern A — 카테고리 재정의 (Stripe 패턴):**
- "Financial infrastructure to grow your revenue" (Stripe)
- "Payments infrastructure for the internet" (Stripe legacy)
- "Settlement infrastructure, written in plain English." (v3 적용 예)

**Pattern B — 페르소나 격상 (Linear 패턴):**
- "Powering the world's best product teams" (Linear)
- "The platform for treasury teams that move at startup speed"

**Pattern F — 행동 동사 (Vercel 패턴):**
- "Build and deploy the best web experiences" (Vercel)
- "Develop. Preview. Ship." (Vercel)
- "Reconcile. Settle. Audit."

### 6.2 Banned 카피 (vault 안티패턴 8가지 — fintech-saas 강제)

위 SKILL.md 글로벌 룰 적용 + fintech 도메인 특화:

- ❌ "혁신적인 결제 솔루션" / "최고의 핀테크 플랫폼" — 모호한 헤드라인
- ❌ "실시간 분석 / 대시보드 / API 연동 / 자동화" 기능 나열 — 모든 SaaS 공통어
- ❌ "Move money, ship faster" / "Built for modern teams" / "Powerful, simple, secure" — SaaS cliché
- ❌ "A사 CFO" 익명 인용 — 실명 + 직함 + 회사 + 금액/% 결과 필수
- ❌ "Learn more" CTA — "Start in sandbox" / "Read the API reference" 등 행동 동사
- ❌ "X 대비 30% 빠름" 직접 비교 — "Goodbye legacy gateways" 식 카테고리 부정으로

### 6.3 fintech 도메인 cliché 추가 banned

- ❌ "Banking, reimagined" / "The future of payments"
- ❌ "Empower your business"
- ❌ "Seamlessly integrated" — 의미 없는 형용사
- ❌ "Enterprise-grade" without specific cert (SOC 2 Type II, PCI DSS Level 1 등 verbatim)
- ❌ "Trusted by millions" without 회사 logo + 수치

### 6.4 Korean fintech 카피 (한국 시장 deployment 시)

한국 시장 fintech (토스/카카오뱅크/우리은행 OpenAPI 톤) 적용 시:

- "1분 만에 정산 완료" — "~분 만에" 시간 수치화
- "224,221개 기업이 신뢰하는 결제 인프라" — 반올림 안 한 구체 수치
- "ISMS + ISO 27001 인증 완료" — 한국 보안 인증 우선
- CTA: "도입 상담" > "문의하기" / "샌드박스 시작" > "무료 체험"
- Social proof: "윤천상, 부스터스 CFO" 같은 실명 + 직급 + 회사 (익명 절대 금지)

---

## 7. Reference Sites (vault 자산 — 17개 큐레이션)

본 DSP가 참조하는 award-grade fintech/SaaS 사이트. 각 reference의 craft signal을 시각으로 확인 후 DSP token + section ordering에 반영. vault 노트 위치: `Intellieffect-Vault/08-Resources/Marketing/랜딩페이지 레퍼런스/`.

### 7.1 fintech 핵심 reference (필수 검토)

| # | 회사 | URL | Vault 노트 | 핵심 craft signal |
|---|---|---|---|---|
| 06 | **Stripe** | https://stripe.com | `06-Stripe.md` | Söhne weight 300 large display, gradient mesh hero (purple→cream 단 verbatim mimicry 금지 — 패턴만), tabular-nums everywhere, gradient text 자제 |
| 02 | **Linear** | https://linear.app | `02-Linear.md` | Inter Variable weight 510, Berkeley Mono pairing, keyboard shortcut display (`⌘ K`), tabular-nums sidebar, variable font hover transition |
| 01 | **Vercel** | https://vercel.com | `01-Vercel.md` | Geist font, -2.4px tracking @48px, monochrome black/white precision, 3-layer shadow stack |
| 14 | **Sendbird** | https://sendbird.com | `14-센드버드.md` | AI 서비스 + B2B fintech-adjacent 톤 |

### 7.2 한국 시장 reference (한국 deployment 시)

| # | 회사 | URL | Vault 노트 | 한국 시장 craft signal |
|---|---|---|---|---|
| 11 | **토스 (Toss)** | https://toss.im | `11-토스.md` | 한국어 선언형 headline, "1분 만에" 시간 수치, 구체적 % (소수점 포함), 실명 인용 |
| 10 | **채널톡** | https://channel.io/ko | `10-채널톡.md` | "고객상담의 미래는 AI 입니다" 패턴 C 선언형, 80.9% 같은 반올림 안 한 수치 |
| 12 | **플렉스 (flex)** | https://flex.team | `12-플렉스.md` | "모든 X를 하나로" 패턴 E 통합형, B2B HR 톤 (fintech 외 도메인이지만 한국 SaaS 카피 voice 참고) |

### 7.3 AI 서비스 reference (AI fintech 시)

| # | 회사 | URL | Vault 노트 | AI craft signal |
|---|---|---|---|---|
| 13 | **Claude (Anthropic)** | https://claude.ai | `13-Claude.md` | "The AI for problem solvers" 페르소나 격상 패턴 B, editorial typography, terracotta accent |
| 04 | **Jasper** | https://www.jasper.ai | `04-Jasper.md` | "Put AI agents to work" 행동 동사 패턴 F |
| 05 | **Copy.ai** | https://www.copy.ai | `05-Copy.ai.md` | "Goodbye AI Copilots" 부정 패턴 D, "$16M saved this year alone" 금액 인용 |

### 7.4 보조 reference (기타 SaaS / 개발도구)

| # | 회사 | URL | Vault 노트 |
|---|---|---|---|
| 03 | Notion | https://www.notion.com | `03-Notion.md` |
| 07 | Zapier | https://zapier.com | `07-Zapier.md` |
| 08 | Retool | https://retool.com | `08-Retool.md` |
| 09 | Figma | https://www.figma.com | `09-Figma.md` |
| 15 | Toptal | https://toptal.com | `15-Toptal.md` |
| 16 | LeewayHertz | https://leewayhertz.com | `16-LeewayHertz.md` |
| 17 | Upstage | https://upstage.ai | `17-Upstage.md` |

### 7.5 사용 패턴

작업 시작 전:

1. fintech-saas 도메인 매칭되면 위 7.1 (Stripe/Linear/Vercel/Sendbird) 최소 2개 라이브 확인 — 실제 craft signal 시각화
2. 한국 시장 작업이면 7.2 (토스/채널톡/플렉스) 추가 확인
3. AI fintech 작업이면 7.3 (Claude/Jasper/Copy.ai) 추가 확인
4. vault 노트 (`08-Resources/Marketing/랜딩페이지 레퍼런스/<번호-회사>.md`) Read해서 IntelliEffect 팀 자체 분석 노트 참고

vault 노트는 단순 URL이 아니라 IntelliEffect 팀이 각 사이트의 craft signal을 분석한 내부 자산. DSP보다 더 상세한 도메인 지식 포함.

### 7.6 Reference mimicry 금지

위 reference는 craft signal **패턴 분석**용. **Verbatim mimicry는 금지**:

- ❌ Stripe gradient mesh를 똑같이 복사 → AI-template
- ❌ Linear의 정확한 `oklch(0.62 0.16 280)` violet 사용 → Linear-mimic
- ❌ Vercel의 "Develop. Preview. Ship." 카피 동일 → 표절

대신 패턴만 추출:
- ✅ Gradient mesh **개념** 적용하되 brand color (`#1E4DB7`)로
- ✅ Variable font hover transition **패턴** 적용
- ✅ Triple-imperative declarative **공식** 적용 (다른 단어로)

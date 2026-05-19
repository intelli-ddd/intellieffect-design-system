---
name: fintech-saas
type: design-system-prompt
domain: Fintech / B2B Financial SaaS (payments infra, data analytics, risk management)
tone: precision, trustworthy, technical, dense, monochrome-with-single-accent
reference: Stripe (Söhne), Mercury (Arcadia), Linear (Inter Variable 510 + Berkeley Mono), Vercel (Geist), Ramp (Lausanne ss01)
version: "2.0.0"
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

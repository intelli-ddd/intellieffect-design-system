---
name: ecommerce-luxury
type: design-system-prompt
domain: Luxury / Premium e-commerce (한정판 제품, niche fragrance, atelier furniture, 고가 시계)
tone: refined, hushed, generous, museum-grade, calm
reference: Aesop, MR PORTER, Hermès, COS, Acne Studios
---

# Design System Prompt — Ecommerce Luxury

> 사용 패턴: designer agent 호출 시 spec body 에 verbatim 인용.

editorial 잡지 같은 정적 진열과 atelier 의 절제된 톤을 그대로 디지털로 옮긴 premium e-commerce 디자인 시스템이다. 시각적 음량을 낮추고 여백·hairline·serif typography 로 제품 자체가 말하도록 한다.

## 1. Design System Definition
- **Primary Color:** `#F4F0E8` 또는 `#F7F4ED` (warm paper cream, page background)
- **Accent Color:** `oklch(0.42 0.06 142)` deep sage / `oklch(0.62 0.08 25)` dusty rose / `oklch(0.55 0.10 75)` deep ochre 중 **단 하나만** 선택. CTA·핵심 link underline·edition tag 한정.
- **Text Color:** `#1F1B16` (headline), `#5A544C` (body / muted caption)
- **Typography:** Serif display (Cormorant, Tiempos, Hoefler) + sans body (Söhne, Inter, GT America). **NO sans display.** Italic 은 highlight·book title·material name 강조에만. Mono caption (Söhne Mono, Berkeley Mono) 은 price·edition number·SKU 한정. Display weight 400-500, NOT 700+.
- **Border Radius:** `0` 기본 (rounded-none for product cards, dialog, image frames). Pill button 은 `999px` 만 허용. 그 외 모든 radius 금지.
- **Shadow:** 거의 사용 안 함. 제품 still-life 컷에 한해 `0 8px 16px rgba(0,0,0,0.06)` (2× rule — 두 단계만, 그 이상 stack 금지). Card·button·CTA 에는 shadow 금지.
- **Icon Style:** 단색, monoline 1px stroke, decorative restraint. SVG illustration (제품 단면도, atelier mark, hairline botanical) 을 icon 보다 우선. Filled icon, duotone, multi-color icon set 금지.

## 2. Layout & Structure
- Editorial product showcase. Single-product hero with large still-life image (SVG illustration or photography), 좌측 generous margin (≥ 80px desktop) + 우측 metadata column 의 비대칭 구조.
- 모든 frame 은 hairline border 1px `#1F1B16` at 12-15% opacity 로 구획. background fill·card shadow 로 면을 나누지 않는다.
- 12-col grid, gutter 24-32px. Headline 은 7-8col, image 는 4-5col 식 비대칭 배치. Centered hero 금지.
- Generous white space — 섹션 vertical padding 최소 120px desktop, 80px mobile.
- Masthead: 좌측 wordmark, 중앙 nav (≤ 5 items, all-caps tracking 0.08em), 우측 cart counter (mono 숫자).
- Footer 는 4-column editorial — atelier address, contact, policy, newsletter (single line input + arrow submit, NO button background).

## 3. UI Elements & Animation
- **Primary CTA:** text + thin underline + small arrow glyph. Background fill button 은 accent color 한정으로만 허용하되, radius 0, padding 16/28, no shadow, no gradient.
- **Secondary CTA:** text-only with 1px underline. Hover 시 underline offset 2 → 4px transition.
- **Product card:** image + 1px hairline divider + serif title + mono price. No card border, no card shadow, no card hover lift.
- **Add-to-bag:** full-width text button with hairline top/bottom border, label "ADD TO BAG" 또는 "ADD TO CART" (all caps, tracking 0.12em). AI-generic rounded large CTA 금지.
- **Animation:** 매우 calm.
  - Fade-in ≤ 300ms ease-out only.
  - Hover: underline offset transition, text color shift ≤ 200ms. **Scale, rotation, lift, glow 일체 금지.**
  - Image: cross-fade between angles (≤ 400ms). 슬라이드 캐러셀 auto-rotate 금지.
  - Scroll: native smooth scroll 만. Parallax·scroll-jack·reveal-stagger 모두 금지.

## 4. Consistency Mandate
- 모든 섹션 (Hero, Product detail, Collection grid, Editorial story, Cart, Account, Checkout) 과 서브 페이지는 위 Design System Definition 을 엄격히 준수.
- 새 color·radius·shadow·font family 임의 추가 금지. Accent 는 처음 선택한 단일 색상 외 추가 도입 금지.
- AI-generic banned 패턴:
  - Glossy gradient button, drop-shadow on CTA, glassmorphism, backdrop-blur on card
  - Gradient text, gradient background section, gradient border
  - "Buy now!", "Limited!", "Shop now →" 같은 high-pressure CTA copy — "Add to bag", "View piece", "Read the story" 같은 절제된 voice 만 허용
  - Sticker badge (Sale!, New!, Hot!, -30%), ribbon, burst graphic
  - AI-generic "Add to cart" rounded large pill button with shadow
  - 3-up identical feature card with icon + heading + body
  - Centered hero with gradient blob background
  - Lifestyle stock photo collage, AI-rendered product render with plastic sheen

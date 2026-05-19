---
name: ecommerce-mobile-kr
type: design-system-prompt
domain: 한국 대형 유통 mobile commerce — 백화점·가전·패션·종합 쇼핑몰 product-photo-driven 화면
tone: product-photo-driven, dense-category, fast-checkout, membership-integrated, conversion-optimized, vertical-scroll-heavy
reference: 롯데하이마트, 더현대Hi (지디웹 2026), 수협쇼핑, 노블레스닷컴, 무신사, 29CM, 신세계백화점, SSG.COM, 마켓컬리
platform: mobile
---

# Design System Prompt — E-commerce Mobile (KR)

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준 (iPhone SE 3rd ~ Pro Max). 한 화면이 한 task를 책임지는 product-photo-driven 구조 — Home·Category·Product detail·Cart·Checkout이 각 화면의 주인공.

본 시스템은 한국 mobile commerce의 sharp edge magazine tone(luxury 매거진 무신사·29CM 톤)과 대형 유통의 dense category + fast checkout 양 축을 동시에 만족시킨다. 무신사·29CM·신세계·SSG·마켓컬리·롯데의 mobile 패턴이 베이스라인. 제품 사진은 sacred — 1:1 ratio, sharp edge, hairline border only.

## 1. Design System Definition

- **Primary Color:** `oklch(0.985 0.004 80)` warm white default (light theme background, 카드·시트·시스템 영역 공통). Dark theme 옵션 (luxury 매거진 mode).
- **Accent Color:** brand별 commit (단일 hue commit, 이후 추가 금지). default는 monochrome + 무채색 + 단일 brand color. **AI-generic indigo/violet 영구 금지**:
  - 무신사 black `oklch(0.16 0.008 240)` (사실상 monochrome)
  - 29CM cream + 진한 가지색 `oklch(0.32 0.10 320)`
  - 마켓컬리 보라 `oklch(0.45 0.16 320)` (단, 브랜드 명시 시에만 — AI cliché 회피)
  - 롯데 red `oklch(0.55 0.20 22)`
  - 신세계 cream + black
- **Sale/Discount Color:** 단일 빨간색 `oklch(0.58 0.22 22)` — discount 표시 한정 (Sale 라벨, percent off badge). 일반 accent 사용 금지.
- **Text Color:** `oklch(0.16 0.008 240)` deep charcoal (headline·brand name·product name·가격), `oklch(0.42 0.010 240)` (body·meta·review), `oklch(0.60 0.012 240)` (tertiary·timestamp).
- **Typography:** 3-family stack
  - Headline + product name: SF Pro Display (iOS) / Pretendard (한국어 우선). Weight 700 for 가격, 600 for product name, 500 for brand name.
  - Body: SF Pro Text / Pretendard / Inter (영문 fallback). Weight 400 body, 500 list item title.
  - Numerics: SF Mono with `font-variant-numeric: tabular-nums` — **MANDATORY** for 가격·SKU·적립금·포인트·할인율. Non-tabular price는 reject.
  - Brand name typography: mono caps tracked uppercase 11pt tracking 0.06em.
  - Body min 14pt, 가격 min 16pt, large price display 24pt+. 12pt는 caption(timestamp·meta)만 허용.
- **Border Radius:** **0-8px products** (한국 mobile commerce는 sharp edge — luxury 매거진 톤). Buttons 10-12px. Pills 999px (sale badge, filter chip). Product image sharp 0px (raw photo 강조). Card 8px (max).
- **Shadow:**
  - 거의 없음. 제품 사진의 raw quality가 우선.
  - Product card: 1px hairline border `1px rgba(22,22,22,0.06)` 대신 사용.
  - Sticky bottom CTA: `0 -4px 12px rgba(0,0,0,0.06)` — 장바구니·바로구매 sticky bar 전용.
  - Sheet/modal: `0 8px 24px rgba(0,0,0,0.08)` — overlay 한정.
  - 그 외 elevation 금지. drop-shadow 남발 금지.
- **Icon Style:**
  - Navigation / action icon: monoline stroke 1.5px, `oklch(0.16 0.008 240)` 또는 `oklch(0.42 0.010 240)`
  - Category icon: simple line drawing 1.5px stroke, no fill, no container. 한국 mobile commerce는 minimal custom monoline.
  - **금지**: Generic Lucide cart/heart icons, 3D rotating product preview, gradient-filled icon, emoji 대용.

## 2. Layout & Structure (Mobile)

- **Viewport**: 375-430px width 기준. iOS safe area top 44-59px + Android status bar 24px 자동 반영. Bottom safe area + bottom nav 56pt + 가끔 sticky "장바구니에 담기" CTA 56pt 누적.
- **Grid**: 4-column logical grid, 16px gutter, 16px outer padding. Product grid는 2-column with 12px gutter.
- **Home**:
  - 상단 sticky 검색 bar — 48pt height, 8px radius, `oklch(0.96 0.004 80)` fill + placeholder "검색어를 입력하세요" 14pt.
  - 검색 bar 아래 카테고리 horizontal scroll — 28-32pt height chips, 999px pill, hairline border.
  - 큰 promo banner carousel — 16:9 ratio, snap, 8px radius, no auto-play (user control only).
  - 추천 상품 grid 2-column — section header 18pt weight 600 + "더보기" text link right.
  - Section header sticky, 13pt uppercase tracking 0.04em `oklch(0.42 0.010 240)`.
- **Product List (Category / Search results)**:
  - 상단 sticky filter chip row + sort dropdown.
  - 2-column grid (375px viewport reasonable), 각 card:
    - [product image 1:1 sharp 0px radius] [brand name 11pt mono caps tracked] [product name 14pt weight 500 2-line max] [가격 16pt weight 700 tabular + discount badge inline]
  - Discount badge inline pill 999px red bg + white text mono caps "-30%".
  - Original price strike-through `oklch(0.60 0.012 240)` 13pt + sale price red 16pt weight 700.
  - Card hairline border on press `1px rgba(22,22,22,0.06)`.
- **Product Detail**:
  - Full-width image carousel snap — 1:1 또는 4:5 ratio, 페이지 indicator dots 하단 center.
  - 아래 brand name 11pt mono caps + product name 20pt weight 600 + 가격 24pt weight 700 tabular.
  - Discount section: original strike + sale + discount % badge.
  - 옵션 picker — color chip / size chip horizontal scroll, 32pt height 999px pill.
  - 리뷰 section: avg star + count + recent 3 reviews.
  - 하단 sticky dual CTA: "장바구니" ghost 50% + "바로구매" primary 50%, **56-64pt height** each.
- **Cart**:
  - List rows with quantity stepper + remove button.
  - 각 row: [product thumbnail 80px 1:1] [brand mono caps 11pt + product name 14pt + option 12pt meta] [가격 16pt tabular right] [stepper − [숫자] + 24px buttons mono tabular].
  - 하단 sticky "총 결제금액 ₩ 142,800 + 결제하기" — 56-64pt height, full-width primary.
- **Checkout**:
  - 단일 스크롤 form — 배송지 → 결제수단 → 적립금 사용 → 약관 동의 → 결제 순서 강제.
  - Form section header 13pt uppercase tracking 0.04em + hairline divider 8px below.
  - 결제수단 cards: 카카오페이 · 네이버페이 · 토스 · 카드 · 무통장 한국 시장 우선 노출.
  - 적립금/포인트 입력 mono tabular-nums.
  - 하단 sticky "결제하기" primary CTA full-width.
- **Bottom Tab Bar**: 5 tabs (홈 / 카테고리 / 검색 / 장바구니 / 마이). 56pt height + safe area. Active tab = filled icon + accent color label, inactive = stroke icon + `oklch(0.42 0.010 240)`. Cart tab은 badge dot (count) 가능.
- **Sheets**: bottom sheet 28px top radius. Drag handle 36×4px `oklch(0.16 0.008 240 / 0.20)` top center 8px margin. 3-snap (peek 25% / half 50% / full 92%). 옵션 picker·필터 등에 사용.
- **Gesture**: pull-to-refresh native. Image carousel snap (native). Add to cart flying-to-cart animation 한정.

## 3. UI Elements & Animation

- **Button**:
  - Primary (장바구니 담기·바로구매·결제하기): accent solid fill, white label, 14pt weight 600, **height 56-64pt** sticky bottom, radius 10px, full-width by default. Pressed state opacity 0.88, no scale.
  - Secondary / Ghost: surface `oklch(0.95 0.004 80)` + dark text `oklch(0.16 0.008 240)` + border 1px `oklch(0.16 0.008 240 / 0.12)`, same dimension.
  - Dual CTA (product detail 장바구니 + 바로구매): 50% / 50% split bottom sticky.
- **Product Card**:
  - Image 1:1 ratio sharp 0px radius, raw photo.
  - Card 8px radius (text area), hairline border on press.
  - Brand name mono caps 11pt tracked uppercase `oklch(0.16 0.008 240)`.
  - Product name 14pt weight 500 2-line max.
  - 가격 16pt weight 700 tabular-nums.
  - Sale badge pill 999px inline.
- **Price Display**:
  - Original price strike-through `oklch(0.60 0.012 240)` 13pt.
  - Sale price red `oklch(0.58 0.22 22)` 16pt weight 700 tabular.
  - Discount % badge: 999px pill, red bg + white text, mono caps "-30%".
- **Filter Chip**: 28-32pt height, 999px pill, hairline border `oklch(0.16 0.008 240 / 0.12)`, 12pt label. Active state filled `oklch(0.16 0.008 240)` + white text.
- **Quantity Stepper**: − [숫자] + 24px round buttons, mono tabular 14pt center. Hairline border container.
- **Sticky Bottom CTA**: 56-64pt height, full-width, accent solid 또는 dual button (장바구니 ghost + 바로구매 primary), 좌우 16px padding + bottom safe area.
- **Sheet**: 위 layout 정의 동일.
- **Animation library**: iOS native UIKit spring 우선, React Native Reanimated 3 / Framer Motion (web hybrid 시).
  - Image carousel: snap native, no auto-play (user control only).
  - Pull-to-refresh: native.
  - Add to cart: brief flying-to-cart animation 300ms ease-out — product thumbnail flies to cart tab icon, only when adding. 1회 light haptic.
  - Sheet present: spring damping 22, stiffness 280 — snappy.
  - Page transition: iOS push native (right slide) / Android shared axis X 250ms.
  - List enter: stagger 30ms per row, fade + 4px translateY, 200ms ease-out. 10+ items는 stagger off.
  - **Duration cap**: interactive ≤300ms.
  - **Banned**: bouncy spring on price changes, parallax product image, particle/sparkle on add-to-cart, auto-rotating carousel without user control, 3D rotating product preview.
- **Haptic**:
  - Light (UIImpactFeedbackStyle.light): product tap, filter chip, quantity stepper, option select
  - Medium (.medium): add to cart, primary CTA
  - Heavy (.heavy): 결제 실패·재고 부족 confirm
  - Notification.success: 결제 완료 (단 1회, 화면 진입 시점)
  - Notification.error: 재고 부족·결제 실패
- **Skeleton**: shimmer 1.2s loop `oklch(0.94 0.004 80)` → `oklch(0.97 0.004 80)`. Product card skeleton: image 1:1 block + 2-line text 60-80% width random.

## 4. Consistency Mandate

이후 제작되는 모든 화면(Home / Category / Search / Product detail / Cart / Checkout / Order / My / Review / 위시리스트)과 모든 서브 화면은 위 Design System Definition을 엄격하게 준수.

새로운 색상 hue·다른 Radius·다른 아이콘 스타일·다른 typography family의 임의 추가 절대 금지. Accent는 프로젝트 진입 시 commit한 brand color 1 hue + sale red 1 hue만 사용.

한국 mobile commerce 정보 위계 — **brand name → product name → price → option → review 순서 강제**. 카테고리 navigation은 한글 + 영문 stacked 또는 한글만 (영문 위주 금지).

결제 흐름: 카카오페이 · 네이버페이 · 토스 · 카드 · 무통장 한국 시장 결제수단 우선 노출. 적립금/포인트 표기는 mono tabular-nums 필수.

AI 생성물처럼 보이는 시각적 패턴 배제:

- **AI-generic ecommerce "modern" purple-pink gradient 금지** — 가장 흔한 cliché. 단일 brand color + sale red commit.
- **Glassmorphism on product card 금지** — `backdrop-blur` 어떤 강도도 product card·sheet·tab bar에 사용 금지. 제품 사진은 sacred, blur는 product photo의 raw quality를 죽인다.
- **3D rotating product preview 금지** — early-2010s skeuomorph cliché. Static 1:1 image carousel만 허용.
- **Stock illustration of "shopping cart with confetti" 금지** — 빈 상태는 monoline icon + 1-line copy로. Gradient blob 모두 reject.
- **Auto-play product video with sound 금지** — user control only. Sound 자동 재생 reject.
- **빨간 "오늘만!" / "마지막 기회!" floating banner 금지** — high-pressure copy reject. Sale 정보는 inline badge + sale price로만.
- **Generic Lucide cart/heart icons 금지** — 한국 mobile commerce는 monoline simple custom icon. Lucide default look은 AI cliché.
- **다중 saturated accent (rainbow promo banner) 금지** — single brand color + sale red commit. Banner도 brand color 톤 내에서.
- **Particle confetti on purchase 금지** — quiet success notification.success haptic만.
- **Non-tabular nums on 가격 금지** — non-tabular price는 자동 reject 사유.
- **영문 위주 typography 금지** — 한글 product name이 secondary로 밀리는 구조 reject. 한글 우선 + 영문 brand name mono caps.
- **Bouncy spring on price changes 금지** — 가격 transition은 instant 또는 ease-out only.

이 product-photo-driven 구조를 기준으로 전체 앱의 톤앤매너·정보 위계·motion 규칙을 일관되고 의도적으로 확장하라.

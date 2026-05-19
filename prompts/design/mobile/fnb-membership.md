---
name: fnb-membership
type: design-system-prompt
domain: F&B Membership / 카페·베이커리 모바일 앱 (사이렌오더 패턴 — 주문 + 적립 + 쿠폰 + 매장 찾기 + 기프트카드)
tone: warm hospitality, brand-photography-driven, membership-rewarding, scan-and-pay-first, single-hand operable, premium friendly
reference: 이디야멤버스, 영커피 (지디웹 2026 수상작), 그랑핸드 GRANHAND, 스타벅스 코리아, 메가커피, 컴포즈커피, 폴바셋, 투썸플레이스, 파리바게뜨, 던킨, 베스킨라빈스
platform: mobile
---

# Design System Prompt — F&B Membership App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준, iOS Safe Area + Android edge-to-edge. 한국 사이렌오더 패턴 — 매장 선택 → 메뉴 → 옵션 → 결제 → 주문 진행 status 흐름을 brand의 환대 (hospitality) 톤으로 감싼다.

타겟 상태 — 한 손으로 카페 카운터 앞 / 출근 길 / 점심 직후, brand 컬러 멤버십 카드를 즉시 뽑아 QR 스캔하거나 사이렌오더로 주문 → 적립 → 매장 픽업. 모든 결정은 "brand 환대를 살리는가 / thumb-zone 한 손에 잡히는가 / 멤버십 카드가 1초 안에 열리는가"로 검증.

## 1. Design System Definition

- **Theme:** Light default (warm cream, brand 카페 톤). Dark variant는 베이커리/dessert brand night-mode 한정 1급 지원.
- **Background — Light theme:**
  - Base `oklch(0.97 0.014 80)` (warm cream, brand 카페 톤)
  - Elevated surface `oklch(0.99 0.010 80)` (메뉴 카드 / 시트)
  - Subtle divider tint `oklch(0.93 0.014 80)`
- **Background — Dark theme (베이커리/dessert brand 한정):**
  - Base `oklch(0.14 0.008 60)` (deep umber night)
  - Elevated surface `oklch(0.18 0.010 60)`
  - Overlay sheet `oklch(0.22 0.012 60)`
- **Accent — brand별 single commit (purple/violet 금지):**
  - 스타벅스 green `oklch(0.32 0.10 155)` deep
  - 이디야 blue `oklch(0.42 0.16 230)`
  - 메가 yellow `oklch(0.85 0.18 90)` (단, 본문 대비 black text 강제)
  - 컴포즈 cream + black duotone
  - **brand 자체 signature color 따라가는 게 옳음**. Default 가이드: warm cream surface + single deep brand color.
  - **Multi-accent / gradient blending / brand 외 컬러 임의 추가 금지**.
- **Reward color (포인트·스탬프·등급 한정):**
  - `oklch(0.72 0.16 80)` warm gold — 별/스탬프/등급 강조 한정. CTA·body·divider에는 사용 금지.
- **Text — Light:**
  - Heading `oklch(0.18 0.012 60)` (deep umber, NOT black)
  - Body `oklch(0.42 0.014 60)`
  - Caption `oklch(0.58 0.012 60)`
- **Text — Dark:**
  - Heading `oklch(0.95 0.010 80)` (warm off-white, NOT pure white)
  - Body `oklch(0.80 0.010 80)`
  - Caption `oklch(0.62 0.010 80)`
- **Typography:**
  - Body / heading 한국어: **Pretendard** (display+body 모두) — 한국어 우선
  - Body / heading 영문: **Inter** 또는 **SF Pro Text** (iOS native pairing)
  - Display serif 옵션 (brand statement headline 한정): **Cormorant Garamond** — "오늘의 한 잔" 같은 emotional 카피에만
  - Mono (필수 tabular-nums): **JetBrains Mono** 또는 **SF Mono** — **가격 / 적립 별 / 쿠폰 코드 / 매장 거리 / 잔액**은 무조건 mono + `font-variant-numeric: tabular-nums`
  - Heading weight **500-600** (700+ bold는 멤버십 카드 잔액 1곳에서만 예외 허용)
  - Body 15-16px, line-height 1.55
  - 가격 / 잔액 / 별 카운트는 tabular-nums **mandatory**
- **Border Radius:**
  - Cards 14-20px (warm friendly)
  - Product image 12px
  - CTA buttons 16-20px
  - Pills (status / badge / chip) 999px
  - Bottom sheet top corners 28px
  - Membership card 20-24px (sacred element, 다른 카드보다 살짝 generous)
- **Shadow:**
  - Subtle card — `0 6px 16px oklch(0.18 0.012 60 / 0.05)`
  - Sticky bottom CTA — `0 -4px 12px oklch(0.18 0.012 60 / 0.06)` (above home indicator)
  - **Floating membership card / QR sheet** — `0 12px 32px oklch(0.18 0.012 60 / 0.08)` (강조용, sacred에 한정)
  - Dark theme — drop shadow 거의 invisible. Active membership card에 한해 brand color glow `0 0 24px <brand>/0.18`
- **Icon Style:**
  - **Monoline stroke 1.5px** + rounded line caps/joins, 24px standard
  - Active tab / selected state는 **filled variant** 1급 허용 (stroke→fill swap)
  - 메뉴 카테고리 icon은 **small line illustration** (coffee bean, croissant, ice cream cone, sandwich — 1.5px line drawing only)
  - **3D illustration / Lucide generic coffee-heart / clip-art emoji 금지**. brand custom monoline.

## 2. Layout & Structure (Mobile)

- **Safe area:**
  - iOS Safe Area + bottom home indicator 존중. Sticky CTA는 home indicator 위 16-20pt 띄움.
  - Android edge-to-edge, status bar transparent with brand color tint (light icon on warm cream / dark icon on deep brand color).
  - Viewport 375-430px 기준, 한 손 thumb-zone (하단 1/3) 안에 primary action 강제.

- **Home (Today):**
  - 최상단 — 사용자 인사 + 멤버십 등급 1줄 ("안녕하세요, 동진님 · 골드 회원 · ★ 32 / 50")
  - **Membership card (sacred, hero element)** — 상단 30-40% 영역 차지, brand color full bg, 흰색/black QR + 바코드 중앙, "★ 32 / 50" stamp 진척, 회원명 mono caps, 잔액 mono tabular large
  - 추천 메뉴 horizontal carousel — 1.2개씩 보이는 peek, native snap, auto-play OFF
  - 가까운 매장 list 2-3개 + 작은 지도 미리보기 (right thumbnail 96×96pt)
  - 진행 중 쿠폰/이벤트 2-column grid (max 4 visible, 더보기는 page 이동)

- **Order (사이렌오더 패턴):**
  - Step 1 — **매장 선택** sheet/screen: GPS 가까운 순 default, search 가능, "지금 영업 중" 필터 chip
  - Step 2 — **메뉴 카테고리 tab**: horizontal scroll sticky tab (커피 / 디카페인 / 라떼 / 티 / 베이커리 / MD)
  - Step 3 — **메뉴 grid 2-column**: photo (1:1, radius 12px) + name (15pt weight 500) + price mono tabular + 인기/신메뉴 badge pill
  - Step 4 — **옵션 customize bottom sheet** (top radius 28px): 사이즈 chip row (S/M/L) · 샷 chip (+1/+2) · 시럽 chip multi-select · 휘핑 toggle · 얼음 양 segmented control · 수량 stepper mono
  - Step 5 — **장바구니**: list with thumbnail + customize summary + qty stepper + 라인 총액 mono. 하단 sticky 총액 + "결제하기" CTA.

- **Payment:**
  - 결제수단 우선순위 (한국 시장): 멤버십 카드 잔액 → 카카오페이 → 네이버페이 → 토스 → 신용/체크카드 → 기프트카드
  - 적립금 / 쿠폰 사용 toggle row (each 56pt tap area)
  - 영수증 mono tabular (수량 / 단가 / 합계)
  - 최종 CTA — "₩ 6,500 결제하기" sticky bottom, brand color solid

- **Order progress (Magic stripe):**
  - 상단 sticky strip — 주문 status 3-stage pill ("접수 → 제조 → 픽업 대기")
  - Estimated ready time mono ("픽업 예상 09:42")
  - State 변경 시 pill cross-fade 200ms (slide / bounce 금지)
  - 픽업 완료 push notification은 quiet voice ("음료가 준비됐어요" — exclamation 금지)

- **Store finder:**
  - Map view ↔ List view top-right toggle (segmented control)
  - Map: brand color pin, 현재 위치 dot, 매장 cluster
  - List 매장 카드: photo (square 88pt) · name · 거리 mono ("0.4 km") · 운영시간 · 좌석 여부 pill ("좌석 있음" / "혼잡")
  - GPS 권한 거부 시 — 지역 검색 fallback (e.g. "강남구")

- **Gift card:**
  - brand 컬러 grid (1-2 column), 카드 thumbnail은 actual brand 카드 디자인
  - 보낼 사람 (연락처/카카오톡 친구) + 메시지 (textarea 200자) + 금액 (preset chip 5,000 / 10,000 / 30,000 / 50,000 + custom)
  - 미리보기 — 받는 사람 화면 그대로 렌더

- **Coupon list:**
  - mono dashed border tear-line top/bottom, brand color accent strip left, expiry date mono right
  - 사용 가능 / 사용 완료 / 만료 3-tab
  - 탭 시 큰 QR 바코드 sheet + "매장에서 보여주세요" caption

- **My / Profile:**
  - 멤버십 등급 진척 (별 ★ 32 / 50 progress bar) — 작게, gamification 과시 금지
  - 거래 내역 list (date mono + 매장 + 금액 mono tabular)
  - 등록 결제수단 / 기프트카드 잔액 / 설정 / 고객센터

- **Bottom tab bar (5 tab):**
  - 홈 / 주문 / **멤버십 (center)** / 매장 / My
  - 멤버십이 center — 한 손 thumb-zone에서 즉시 access (sacred 강조)
  - Tab bar bg solid surface (no glassmorphism), 56pt height + safe area
  - Active tab: stroke→**filled** icon swap + brand color + label weight 600
  - Inactive: stroke + body color + label weight 500

- **Gestures:**
  - Pull-to-refresh: 매장 status / 추천 메뉴 refresh, native iOS spinner / Material slim circular
  - Swipe-down to dismiss bottom sheet (slow spring, damping 16)
  - Long-press 메뉴 카드 → "즐겨찾기 추가" with light haptic
  - QR/바코드 sheet는 fullscreen modal + 자동 brightness max (iOS `UIScreen.brightness`) — 카운터 스캔 OK
  - Force quit / background — 진행 중인 주문은 push notification으로 재진입

## 3. UI Elements & Animation

- **Button variants:**
  - **Primary CTA** — full-width, height 52-56pt, brand color solid, text 16pt weight 600, radius 16-20px. 한 화면 1개 원칙.
  - **Secondary** — outlined 1px brand color, transparent bg, same height/radius
  - **Tertiary text** — brand color text, 44pt tap area, underline 금지
  - **Icon button** — 44×44pt tap, 24px icon centered, ghost bg `oklch(... / 0.04)` on press
- **Membership card (sacred):**
  - Aspect ratio ~1.6:1 (신용카드 비례)
  - brand color full bg, radius 20-24px
  - 중앙 QR (square ~140pt) + 바코드 strip (full-width 32pt height) — 흰색 surface 위 black 패턴 강제 (스캐너 호환)
  - 회원명 mono caps top-left, 등급 badge top-right
  - "★ 32 / 50" stamp progress + 잔액 mono tabular bottom
  - Tap → fullscreen modal scale-up 250ms + auto brightness max
- **Menu card:**
  - Image 1:1 square radius 12px (brand-produced product photo only — stock 금지)
  - Name 15pt weight 500
  - Price 16pt mono tabular (e.g. `₩ 4,800`)
  - "신메뉴" / "BEST" badge pill top-left of image (caption 11pt)
  - Tap area minimum 88pt height
  - Press → scale 0.98 + opacity 0.95, 180ms ease-out
- **Customize sheet (bottom sheet):**
  - Top radius 28px, drag handle 36×4pt opacity 0.2
  - Snap points 50% / 95%
  - 옵션 row: label (15pt) + chip row (each chip 36pt height, radius 999px, 1px border)
  - Selected chip: brand color border + brand color text + bg `<brand>/0.08`
  - Stepper (수량): - / count mono / + (each 36pt tap)
  - Sticky bottom — 라인 합계 mono + "장바구니에 담기" CTA
- **Stamp / point indicator:**
  - ★ icon series (filled gold) + outline (unearned) — 10 per row 2 rows = 20 visible
  - Count mono `32 / 50` right-aligned
  - Earned animation — ★ scale 0.8→1.0 + fade in 300ms ease-out + medium haptic (brief celebration 허용, particle confetti 금지)
- **Coupon card:**
  - Dashed border tear-line (border-style dashed, 1.5px, opacity 0.4)
  - Brand color accent strip left (4pt wide)
  - Title 16pt weight 500 + discount mono ("3,000원 할인" / "1+1")
  - Expiry mono right ("~ 06.30" tabular)
- **Magic stripe (order progress):**
  - Top sticky strip, height 48pt, brand color tint bg `<brand>/0.08`
  - 3-stage pill (접수 / 제조 / 픽업 대기) — current stage filled brand color + 흰 text, others outline
  - Estimated time mono right
  - State change — pill cross-fade 200ms (slide / bounce / scale 금지)
- **List item:**
  - Min 56pt height (한국어 본문 + caption 2-line 기준)
  - Leading icon 24px (optional thumbnail 44pt)
  - Trailing chevron 16px or value mono
  - Divider `1px oklch(... / 0.06)` 또는 spacing-only 12pt
- **Bottom sheet (general):**
  - Drag handle 36×4pt pill, opacity 0.2
  - Snap 30% / 70% / 95%
  - Top corners 28px
  - Backdrop `oklch(0 0 0 / 0.4)` fade-in 200ms

- **Animation library:**
  - iOS native: SwiftUI `withAnimation(.easeInOut(duration: 0.25))` + `.spring(response: 0.4, dampingFraction: 0.85)` for sheets
  - React Native: **Reanimated 3** with `withSpring({ damping: 16, stiffness: 180 })`
  - Web view fallback: Framer Motion `transition={{ type: "spring", stiffness: 180, damping: 16 }}`
  - **Lottie**는 onboarding 일러스트 한정 (brand 마스코트). 메뉴 / 결제 / 멤버십에는 사용 금지.

- **Motion specs:**
  - Page transition — iOS push native / Android shared axis X 250ms ease-out
  - Tab switch — opacity crossfade 200ms (slide 금지)
  - Card press — scale 0.98 + opacity 0.95, 180ms ease-out
  - **Stamp earned** — ★ scale 0.8→1.0 + fade-in 300ms ease-out + medium haptic (brief celebration 허용)
  - **Order progress state change** — pill cross-fade 200ms ease-in-out
  - **Cart add** — small icon fly-to-cart curve 300ms ease-out (Bezier path from menu card to bottom tab cart badge)
  - Carousel snap — native, deceleration normal
  - Membership card open — fullscreen scale-up 250ms ease-out + auto brightness max
  - QR sheet dismiss — scale-down + fade-out 200ms
  - **Banned**: bouncy spring on price/quantity stepper (damping < 14), particle/sparkle effects on stamp earned, parallax menu image scroll, auto-play promo carousel, blur/filter animation

- **Haptic feedback:**
  - **Light** — chip select (사이즈/샷/시럽), menu card tap, quantity stepper, tab switch (낮)
  - **Medium** — add to cart, **stamp earned**, primary CTA press, membership card open
  - **Heavy** — 사용 안 함 (F&B 환대 톤)
  - **Notification.success** — 주문 완료, 결제 완료
  - **Notification.warning** — 재고 부족, 매장 영업 종료, 결제 실패
  - **Selection feedback** — segmented control toggle (map ↔ list)

- **Loading states:**
  - Shimmer skeleton with brand color tint at 0.08 opacity
  - 1.4-1.6s cycle (적당히 빠르되 jitter 없이)
  - 매장 list / 메뉴 grid는 skeleton placeholder (정확한 layout 그대로)
  - 결제 진행 — full-screen spinner with brand color, "결제 중..." caption (퍼센티지 / 진척 fake bar 금지)
  - 주문 status polling — silent (visible spinner 없음, magic stripe만 자연 업데이트)

## 4. Consistency Mandate (AI-generic & F&B cliché banned 패턴)

**금지 (재발 시 디자인 fail 처리):**

1. **AI-generic "modern cafe" purple-pink gradient** — 한국 카페 brand 톤과 정반대. brand signature color 단일 commit만.
2. **Glassmorphism on membership card** — 멤버십 카드는 sacred. brand color full solid bg 강제. `backdrop-blur + white/10 + border-white/20` 패턴 금지.
3. **3D illustration of coffee cup with steam** — cliché AI-tell. 메뉴 image는 actual brand-produced product photo만, 카테고리 icon은 1.5px monoline line drawing만.
4. **Stock photo of "barista smiling" / "person holding latte"** — Unsplash 클리셰. 매장 photo는 actual brand-shot (interior / signage), 인물 photo는 brand 공식 자산만.
5. **Particle confetti / sparkle on stamp earned** — visual restraint. ★ scale + fade + haptic으로 충분. "magical" particle 금지.
6. **Auto-rotating promo carousel with sound** — auto-play OFF, sound mute. 사용자 swipe만.
7. **빨간 "오늘만 50% 할인!" 큰 banner / 불꽃 이모지 / 흔들림 애니메이션** — 한국 카페는 quiet voice ("이벤트", "한정 메뉴", "신메뉴"). exclamation mark 본문 금지.
8. **Generic Lucide coffee / heart / star icons 그대로 사용** — brand custom monoline 1.5px로 재제작. open-source pack의 generic glyph 금지.
9. **다중 saturated accent** — 단일 brand color + warm gold reward 한정. 다른 accent 임의 추가 금지.
10. **Non-tabular-nums on 가격 / 포인트 / 거리 / 잔액** — `font-variant-numeric: tabular-nums` 강제. 숫자 폭 변동으로 layout shift 금지.
11. **Stock food photo carousel** — 각 메뉴는 brand-produced product photo. 외부 stock 금지.
12. **Bottom tab 6개 이상** — 5개 (홈 / 주문 / 멤버십 / 매장 / My) 강제. 멤버십 center 위치 sacred.
13. **Membership card에 glassmorphism / gradient mesh / 3D tilt** — solid brand color + QR + 바코드 + stamp + 잔액. 장식 금지.
14. **Bouncy spring on price/quantity stepper** — damping < 14는 환대 톤 파괴. damping 16+ 강제.
15. **Push notification overuse / 죄책감 카피** — "왜 안 오세요 ㅠㅠ" / "별이 만료돼요!! 빨리 쓰세요!!" 류 금지. quiet invitation ("음료가 준비됐어요" / "별 18개로 무료 음료 가능").
16. **Bold weight 700+ 남발** — 멤버십 카드 잔액 1곳 예외 외 weight 500-600.
17. **Pure white `#ffffff` / pure black `#000000`** — eye strain. 정의된 warm cream / deep umber 톤만. (QR 바코드 패턴 자체는 black/white 필수 — 스캐너 호환 예외)
18. **Slate / Zinc gray default** — 푸르딩딩 회색은 F&B 환대 톤과 정반대. Warm cream / umber surface만.
19. **Drop shadow heavy `shadow-2xl`** — 카드 그림자는 0.05-0.08 alpha. 멤버십 floating만 0.08-0.10.
20. **다국어 toggle 누락** — 한국어 default + 영어 + 일본어 toggle 권장 (카페는 외국인 손님 비율 높음). 누락 시 i18n 미흡 처리.
21. **결제수단 우선순위 미준수** — 멤버십 잔액 → 카카오페이 → 네이버페이 → 토스 → 카드 한국 시장 순서 강제. 외산 우선 layout 금지.
22. **매장 찾기 GPS-only / search-only** — GPS + 검색 + 지역 fallback 3-tier 강제.
23. **Center FAB** — bottom tab center는 멤버십 sacred 자리. floating FAB 추가 금지.
24. **Sans-only on brand statement headline** — "오늘의 한 잔" / "Today's brew" 같은 emotional copy는 Cormorant 등 serif 옵션 허용. (단, 본문 / 메뉴명 / 가격은 Pretendard/Inter sans 강제)
25. **`filter: blur(...)` animation** — GPU 폭발 + AI-tell. transform / opacity만.

**필수 검증:**
- 한 손 thumb-zone (하단 1/3) 안에서 멤버십 카드 열기 / 매장 선택 / 결제 CTA 가능한가
- 멤버십 카드가 home 진입 후 1초 안에 fullscreen QR sheet로 열리는가 (auto brightness max 포함)
- 가격 / 별 카운트 / 잔액 / 거리 모두 mono tabular-nums 렌더되는가 (layout shift 0)
- brand signature color 단일 commit + warm gold reward 외 다른 accent 등장 0건
- 메뉴 image가 brand-produced product photo인가 (stock 0건)
- 스탬프 earned 애니메이션이 brief celebration (300ms + medium haptic) 범위 안인가 — particle / confetti 0건
- 카피가 quiet voice인가 ("준비됐어요" / "한정 메뉴") — exclamation / 죄책감 0건
- 결제수단 ordering이 멤버십 잔액 → 카카오페이 → 네이버페이 → 토스 → 카드 순서인가
- 매장 찾기에 map ↔ list toggle + GPS + 검색 + 지역 fallback 모두 존재하는가
- 다국어 toggle (한국어 / 영어 / 일본어) 노출되는가
- Bottom tab 5개 + 멤버십 center 위치 sacred 준수하는가
- Dark theme이 베이커리/dessert brand에서 1급으로 작동하는가 (drop-in, 색 대비 검증)

## 5. Reference 시각 자료

- **이디야멤버스** — 멤버십 카드 hero pattern, blue brand color full bg, 별 stamp progress
- **영커피 (지디웹 2026 수상작)** — warm cream surface, brand-produced product photo, quiet typography
- **그랑핸드 GRANHAND** — premium dessert brand, serif statement headline + Pretendard body 조합
- **스타벅스 코리아 사이렌오더** — 매장 선택 → 메뉴 → 옵션 → 결제 → 픽업 status 흐름의 정전
- **메가커피 / 컴포즈커피** — yellow / cream+black 단일 brand color commit, 한국 가성비 카페 톤 (low-price, high-frequency)
- **폴바셋 / 투썸플레이스** — premium dessert + 디저트 product photo grid
- **파리바게뜨 / 던킨 / 베스킨라빈스** — 베이커리/dessert brand의 light + dark theme 듀얼 운용

- 핵심 visual cue verbatim:
  - "Home 진입 즉시 brand color full membership card가 hero 영역 30-40% 차지"
  - "QR + 바코드는 흰색 surface 위 black 패턴 강제 (스캐너 호환)"
  - "★ 32 / 50 stamp progress + 잔액 mono tabular bottom"
  - "주문 status magic stripe — 접수 → 제조 → 픽업 대기 cross-fade"
  - "결제수단 ordering — 멤버십 잔액 → 카카오페이 → 네이버페이 → 토스 → 카드"

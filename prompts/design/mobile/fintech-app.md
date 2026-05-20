---
name: fintech-app
type: design-system-prompt
domain: Fintech / Banking / Investment mobile app — 잔액 조회·송금·카드·투자 transaction-first 화면
tone: trustworthy, fast, dense-info, clear-hierarchy, transaction-first
reference: Toss, KakaoBank (한국 mobile fintech 표준), Robinhood, Wise, Revolut
platform: mobile
---

# Design System Prompt — Fintech App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준 (iPhone SE 3rd ~ Pro Max). 한 화면이 한 task를 책임지는 transaction-first 구조 — 잔액·송금·내역·카드·투자가 각 화면의 주인공.

본 시스템은 금융 신뢰감(legibility, tabular alignment, conservative motion)과 한국 fintech의 속도감(즉시 조회, 한 손 조작, dense list)을 동시에 만족시킨다. Toss/KakaoBank의 한국형 grid + Wise/Revolut의 글로벌 transaction UX가 베이스라인.

## 1. Design System Definition

- **Primary Color:** `oklch(0.98 0.004 250)` near-white (light theme background, 카드·시트·시스템 영역 공통)
- **Accent Color:** `oklch(0.62 0.18 250)` Toss-style blue — 단일 hue commit. CTA·active tab·focus ring·primary button 한정. **대안 선택 가능** (프로젝트 진입 시 1개만 commit, 이후 절대 추가 금지):
  - 한국 fintech: `oklch(0.62 0.18 250)` Toss blue / `oklch(0.88 0.16 95)` KakaoBank yellow
  - 글로벌: `oklch(0.74 0.18 142)` Wise green / `oklch(0.72 0.20 145)` Robinhood green
  - **purple/violet 영구 금지** (AI cliché)
- **Text Color:** `oklch(0.16 0.008 250)` deep charcoal (headline·amount), `oklch(0.48 0.010 250)` (body·meta·timestamp)
- **Semantic (financial 한정):** `oklch(0.68 0.16 145)` positive/gain green, `oklch(0.62 0.20 25)` negative/loss red — 금액 변동·수익률·실패 상태에만 사용. UI 장식 금지.
- **Typography:** 3-family stack
  - Headline + amount: SF Pro Display (iOS) / Pretendard (한국어 fallback). Weight 700 for amounts, 600 for screen titles.
  - Body: SF Pro Text / Pretendard. Weight 400 body, 500 list item title.
  - Numerics: SF Mono / SF Pro with `font-variant-numeric: tabular-nums` — **MANDATORY** for 모든 financial figure (잔액·송금액·내역·수익률·카드번호·계좌번호). Non-tabular financial number는 reject.
  - Body min 14pt, amount min 16pt. 12pt는 caption(timestamp)만 허용.
- **Border Radius:** 12-16px (cards, sheets body). Buttons 12px. Input 10px. Pills 999px (chips, badges, status tag). Account hero card 20px (1단계 강조).
- **Shadow:**
  - Base elevation: `0 1px 2px rgba(0,0,0,0.04)` — 리스트 row, 일반 card
  - Strong (account hero / floating CTA): `0 8px 20px rgba(0,0,0,0.06)` — 화면당 최대 1개 (2× rule)
  - 그 외 elevation 금지. drop-shadow 남발 금지.
- **Icon Style:**
  - Navigation / action icon: monoline stroke 1.5px, `oklch(0.16 0.008 250)` 또는 `oklch(0.48 0.010 250)`
  - Transaction category icon (식비·교통·쇼핑 등): filled + categorical color, 28-32px rounded-square container `oklch(0.96 0.008 H)` tint background — 카테고리 인지 우선
  - Brand/merchant logo: 원본 그대로, 정사각 32px container, 4px padding
  - **금지**: 3D glossy, gradient-filled icon, emoji 대용

## 2. Layout & Structure (Mobile)

- **Viewport**: 375-430px width 기준. iOS safe area top 44-59px + Android status bar 24px 자동 반영. Bottom safe area (Home Indicator 34px) 반드시 확보.
- **Grid**: 4-column logical grid, 16px gutter, 20px outer padding. Dense list는 16px outer로 통일.
- **Home (Dashboard)**:
  - Account hero card 화면 상단 1/3 occupy. 잔액 display 36-48pt tabular-nums, 통화 단위는 amount weight 400로 약하게.
  - Hero 아래 quick action row (송금·받기·결제·내역) 4 icon column.
  - Transaction list compact rows — 각 row 64-72px height: [category icon 32px] [merchant title 15pt + meta 12pt] [amount 16pt tabular right-aligned].
  - Section header sticky, 13pt uppercase tracking 0.04em `oklch(0.48 0.010 250)`.
- **Transaction Detail**:
  - Receipt-like vertical layout. 상단 merchant logo 56px + 금액 36pt center.
  - Breakdown table: label left / value right tabular-nums. Hairline divider `oklch(0.16 0.008 250 / 0.08)`.
  - Bottom action: "영수증 공유" ghost + "이의 제기" text link.
- **Send / Transfer**:
  - 화면 절반 amount display (48-56pt tabular-nums, accent color when valid).
  - 하단 절반 numeric keypad — 4×3 grid, 각 key 56-64px height, 24pt SF Pro Display weight 500.
  - Recipient chip 상단 sticky.
- **Card / Invest screens**: horizontal carousel of card visual (90% width swipe-snap), 아래 metric grid 2×2.
- **Bottom Tab Bar**: 4-5 tabs (Home / Cards / Send / Invest / Profile). 56pt height + safe area. Active tab = filled icon + accent color label, inactive = stroke icon + `oklch(0.48 0.010 250)`. Center "Send" tab은 FAB 형태로 8px raise + accent fill 허용 (옵션).
- **Sheets**: bottom sheet 28px top radius. Drag handle 36×4px `oklch(0.16 0.008 250 / 0.20)` top center 8px margin. 3-snap (peek 25% / half 50% / full 92%).
- **Gesture**: pull-to-refresh native iOS spinner. Swipe-left on list row → 카테고리 변경 / 메모 (red destructive swipe는 금융 데이터에 사용 금지).

## 3. UI Elements & Animation

- **Button**:
  - Primary: accent fill, white label (`oklch(0.98 0.004 250)`), 14pt weight 600, height 52pt, radius 12px, full-width by default. Pressed state opacity 0.88, no scale.
  - Secondary: surface `oklch(0.95 0.004 250)` + text `oklch(0.16 0.008 250)`, same dimension.
  - Ghost: text only with accent color, 44pt height min tap target.
  - Destructive: text-only red `oklch(0.62 0.20 25)`, confirmation sheet 필수.
- **Card**:
  - Standard: white surface, base shadow, 16px padding, 14px radius.
  - Account hero: 20px radius, strong shadow, 24px padding, optional subtle accent-tinted background `oklch(0.62 0.18 250 / 0.04)`.
  - Nested card 금지 — section 안 card는 hairline divider 또는 grouped list로 대체.
- **List row**: 64-72px height, 16px horizontal padding, hairline divider `oklch(0.16 0.008 250 / 0.06)` 1px bottom (마지막 row 제외).
- **Input**: 52pt height, 10px radius, hairline border `oklch(0.16 0.008 250 / 0.12)`, focus → accent border 1.5px + ring `oklch(accent / 0.16)` 3px. Inline error 12pt below.
- **Chip / Badge**: 999px pill, 24-28pt height, 12pt label, padding 10-14px. Status color는 semantic token만.
- **Sheet**: 위 layout 정의 동일.
- **Animation library**: iOS native UIKit spring 우선, React Native Reanimated 3 / Framer Motion (web hybrid 시).
  - Number count-up: 잔액 변동 시 300ms ease-out, tabular-nums 유지. 송금액 입력은 instant (count-up 금지 — 금융 confidence).
  - Keypad press: scale 0.95, 80ms in / 120ms out, no spring (tight feedback). Haptic light synchronous.
  - Sheet present: spring damping 22, stiffness 280 — snappy.
  - List enter: stagger 30ms per row, fade + 4px translateY, 200ms ease-out. 10+ items는 stagger off.
  - Pull-to-refresh: native.
  - Page transition: iOS push native (right slide) / Android shared axis X 250ms.
  - **Duration cap**: interactive ≤300ms. Hero balance reveal만 예외 (최대 500ms).
- **Haptic**:
  - Light (UIImpactFeedbackStyle.light): keypad tap, list select, toggle
  - Medium (.medium): send confirmation tap, primary CTA
  - Heavy (.heavy) / Notification.error: 송금 실패, 인증 실패
  - Notification.success: 송금 완료 (단 1회, 화면 진입 시점)
- **Skeleton**: shimmer 1.2s loop `oklch(0.94 0.004 250)` → `oklch(0.97 0.004 250)`. 텍스트 자리 60-80% width random.

## 4. Consistency Mandate

이후 제작되는 모든 화면(Home / Transaction Detail / Send / Card / Invest / Profile / Settings / Auth / Onboarding)과 모든 서브 화면은 위 Design System Definition을 엄격하게 준수.

새로운 색상 hue·다른 Radius·다른 아이콘 스타일·다른 typography family의 임의 추가 절대 금지. Accent는 프로젝트 진입 시 commit한 1 hue만 사용.

AI 생성물처럼 보이는 시각적 패턴 배제:

- **AI-generic "fintech" purple/violet gradient 금지** — 가장 흔한 cliché. 단일 hue accent로 commit.
- **Glassmorphism on cards 금지** — `backdrop-blur` 어떤 강도도 카드·sheet·tab bar에 사용 금지. 금융 정보는 legibility 1순위, blur는 숫자를 죽인다.
- **Bouncy spring on amount changes 금지** — 금액·잔액 transition은 instant 또는 ease-out only. Spring overshoot는 transaction confidence를 깎는다.
- **작은 amount typography 금지** — 모든 금액 표시는 16pt minimum. Hero 잔액은 36pt+. 단위(원·KRW·USD)도 weight 400로 약하게 하되 같은 family 유지.
- **Generic stock photography / 3D illustration 금지** — 빈 상태는 monoline icon + 1-line copy로. 가짜 보드 isometric illustration, gradient blob 모두 reject.
- **AI-generic Linear/Notion 비주얼 mimic 금지** — fintech는 fintech 답게. Productivity 톤(라일락·민트 페일톤)·streaming 톤(album art bleed) 절대 금지.
- **Tabular-nums 누락 금지** — non-tabular financial number는 자동 reject 사유.
- **Center-aligned long form text 금지** — receipt detail의 amount만 center, 나머지 본문은 left.

이 transaction-first 구조를 기준으로 전체 앱의 톤앤매너·정보 위계·motion 규칙을 일관되고 의도적으로 확장하라.


---

## v1.9.6 — Mobile accessibility tokens (cross-cutting)

```
touch_target_min: 44px (iOS HIG / WCAG 2.5.5 AAA)
touch_target_spacing: 8px between adjacent targets
bottom_tab_bar_height: 56-64px (4-5 items max)
hamburger_drawer_width: 80vw (full-screen overlay 권장)
safe_area_inset: env(safe-area-inset-*) 적용 의무
```

**규칙**:
- 모든 interactive element (button / link / chip / icon-button) 의 hit area ≥ 44×44px
- icon 자체는 작게 (24-28px) 두되 padding 으로 44×44 확보
- bottom tab bar 4-5 items 만 (UXPin / CreatorConcepts 2026 verbatim — 4 items sweet spot)
- iPhone notch / Dynamic Island / Android navigation bar 회피 — `env(safe-area-inset-top/bottom)` CSS 의무
- Snippet #47 `gsap.matchMedia() mobile breakpoint motion override` 적용 — desktop motion 의 mobile 변형 분기 필수

**MUST NOT**:
- iOS native scroll 의 `scroll-behavior: smooth` + Lenis 동시 적용 (충돌)
- bottom tab bar 6+ items (cognitive overload + 44px breach)
- ScrollTrigger pin 을 mobile 에 그대로 (Category G.8 fail)
- Custom cursor / magnetic CTA 를 mobile 에 (Category G.9 fail)

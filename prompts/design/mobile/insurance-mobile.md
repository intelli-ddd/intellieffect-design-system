---
name: insurance-mobile
type: design-system-prompt
domain: 한국 보험 모바일 가입·관리 — 자동차보험·손해보험·건강보험·자산운용·카드 인증·결제 transaction-first 화면
tone: transaction-confidence, form-heavy, dense-form-input, trust-signal-heavy, conservative-motion, premium-financial-neutral
reference: 삼성화재 CM 자동차보험 (지디웹 2026), AXA손해보험 CM프로젝트, 한화자산운용 모바일, KB국민카드 마이데이터 2.0, 롯데카드 CHECK iN SEOUL, 메리츠화재, 현대해상
platform: mobile
---

# Design System Prompt — Insurance Mobile (KR)

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준 (iPhone SE 3rd ~ Pro Max). 한 화면이 한 task를 책임지는 transaction-first 구조 — 보험 가입·견적·청구·결제·인증이 각 화면의 주인공.

본 시스템은 한국 보험사 CM(다이렉트) mobile UX의 trust signal(약관 footer, 다단계 stepper, 인증 화면, dense form)과 보수적 motion(spring overshoot 금지, instant feedback)을 동시에 만족시킨다. 삼성화재·한화·AXA·KB·메리츠·현대해상의 CM mobile 패턴이 베이스라인. 보험료·배상금·납입일 같은 financial figure는 sacred — tabular-nums + 16pt minimum.

## 1. Design System Definition

- **Primary Color:** `oklch(0.98 0.004 240)` cool near-white (light theme background, form·sheet·시스템 영역 공통). **Pure `#FFFFFF` 금지** — 차가운 tint가 보험 trust signal.
- **Accent Color:** brand별 commit (단일 hue commit, 이후 추가 금지). **purple/violet 영구 금지**:
  - `oklch(0.42 0.16 240)` Samsung navy (삼성화재 default)
  - `oklch(0.55 0.18 230)` Hanwha blue (한화)
  - `oklch(0.45 0.14 250)` AXA blue
  - `oklch(0.62 0.20 22)` KB yellow (KB국민카드)
  - 보험사 자체 brand color 외 추가 accent 금지.
- **Text Color:** `oklch(0.16 0.008 240)` deep charcoal (headline·보험료·약정·납입일), `oklch(0.45 0.010 240)` (body·meta·약관 본문)
- **Semantic (financial 한정):**
  - Positive: `oklch(0.62 0.14 145)` green — 보험료 납입 완료·청구 승인 상태
  - Negative: `oklch(0.58 0.18 25)` red — 청구 거절·연체·인증 실패 상태
  - UI 장식 금지 — semantic 상태에만.
- **Typography:** 3-family stack
  - Headline + 보험료 amount: SF Pro Display (iOS) / Pretendard (한국어 강제). Weight 700 for amounts, 600 for screen titles.
  - Body: SF Pro Text / Pretendard / Inter (영문 fallback). Weight 400 body, 500 form label.
  - Numerics: SF Mono with `font-variant-numeric: tabular-nums` — **MANDATORY** for 모든 보험료·배상금·납입일·증권번호·계약번호. Non-tabular financial number는 reject.
  - Body min 14pt, 보험료 min 16pt, large premium display 32pt+. 12pt는 caption(약관 footer·timestamp)만 허용.
- **Border Radius:** 10-14px medium-trust radius (cards, sheets body). Buttons 10-12px. Input 10px. Pills 999px (status badge, 보장 항목 chip). Insurance policy hero card 14px (1단계 강조 — 과한 라운드 금지, 신뢰감).
- **Shadow:**
  - Base elevation: `0 1px 2px rgba(0,0,0,0.04)` — 일반 card, list row. 매우 절제.
  - Policy emphasis: `0 8px 16px rgba(0,0,0,0.06)` — 보험 cards 강조 시 화면당 최대 1개.
  - Bottom sticky CTA: `0 -4px 12px rgba(0,0,0,0.06)` — 가입하기·결제·청구 제출 sticky bar 전용.
  - 그 외 elevation 금지. drop-shadow 남발 금지.
- **Icon Style:**
  - Navigation / action icon: monoline stroke 1.5px, `oklch(0.16 0.008 240)` 또는 `oklch(0.45 0.010 240)`
  - Insurance category icon (자동차·건강·재산·여행·연금): monoline 1.5px + categorical color tint container — 28-32px rounded-square `oklch(0.96 0.008 H)` tint background. 카테고리별 hue (자동차 blue / 건강 green / 재산 amber / 여행 teal).
  - **금지**: 3D shield illustration, gradient-filled icon, emoji 대용, "happy family protected by shield" cliché illustration.

## 2. Layout & Structure (Mobile)

- **Viewport**: 375-430px width 기준. iOS safe area top 44-59px + Android status bar 24px 자동 반영. Bottom safe area (Home Indicator 34px) 반드시 확보.
- **Grid**: 4-column logical grid, 16px gutter, 20px outer padding. Dense form section은 16px outer로 통일.
- **Home (가입 보험 dashboard)**:
  - 가입 보험 카드 stack 화면 상단 — 각 카드: [insurance category icon 32px] [보험명 15pt weight 600] [보험료 16pt tabular-nums + 단위 weight 400] [보장기간 12pt meta] [다음 결제일 12pt meta]
  - 카드 하단 status badge pill (납입 중 / 만기 임박 / 청구 진행 중).
  - 하단 "+ 보험 신규 가입" CTA — full-width ghost button + accent border.
  - Section header sticky, 13pt uppercase tracking 0.04em `oklch(0.45 0.010 240)`.
- **가입 흐름 (CM 자동차보험 다단계 stepper 패턴)**:
  - 상단 sticky progress bar — 5 step dot (●○○○○ 차량 정보 → 운전자 → 보장 옵션 → 견적 확인 → 결제) + 단계명 mono caps 12pt tracking 0.04em.
  - 각 step 진척률 명시 + 뒤로가기 항상 가능 (상단 좌측 chevron).
  - Form section header 13pt uppercase tracking 0.04em + hairline divider `oklch(0.16 0.008 240 / 0.08)`.
  - Form input dense — 약관 동의 · 개인정보 처리 · 보장 옵션 · 보험료 · 결제 정보 순서 강제.
- **견적 페이지**:
  - 상단 large premium display "월 ₩ 142,800" 32-40pt tabular-nums, 통화 단위(월·원·₩)는 weight 400로 약하게.
  - 아래 보장 항목 toggle list — 각 row 64pt: [보장명 15pt weight 500] [보장한도 13pt meta] [toggle switch right].
  - 실시간 보험료 update — toggle tap → premium count-up 300ms ease-out, tabular-nums 유지.
  - 하단 sticky "가입하기" full-width primary CTA.
- **청구 (claim) 페이지**:
  - 상단 claim category picker (chip row horizontal scroll).
  - 사고 정보 form — 발생 일시 · 장소 · 사고 내용 · 사진 업로드 grid (3-column thumbnail).
  - 사진 업로드 cell: 1:1 ratio, dashed border `oklch(0.16 0.008 240 / 0.16)`, center "+ 추가" 14pt.
  - 하단 sticky "청구 제출" primary CTA.
- **Insurance Policy Detail**:
  - Hero policy card 상단 — 가입 보험사 logo 32px + 보험명 18pt weight 600 + 증권번호 mono 12pt.
  - Breakdown table: 보장 항목 / 보장한도 — label left / value right tabular-nums. Hairline divider.
  - 약관 footer link 의무 — 보험약관 · 개인정보처리방침 · 보험금 청구 안내 (text link 13pt `oklch(0.45 0.010 240)`).
  - Bottom action: "약관 보기" ghost + "청구하기" primary.
- **인증 화면**: full-screen modal — 지문 / 얼굴 / 공동인증서 / 간편비밀번호 / 카카오 인증 / PASS.
  - System-native biometric prompt 우선 (Face ID · Touch ID · Android BiometricPrompt).
  - 간편비밀번호: 6-digit dot indicator + 키패드 4×3 grid 56-64pt height.
  - 인증 실패 → heavy haptic + 빈 dot shake 200ms.
- **Bottom Tab Bar**: 4-5 tabs (홈 / 보험 / 청구 / 더보기 + 옵션 인증). 56pt height + safe area. Active tab = filled icon + accent color label, inactive = stroke icon + `oklch(0.45 0.010 240)`.
- **Sheets**: bottom sheet 28px top radius. Drag handle 36×4px `oklch(0.16 0.008 240 / 0.20)` top center 8px margin. 3-snap (peek 25% / half 50% / full 92%).
- **Gesture**: pull-to-refresh native. Swipe-left on list 금지 (보험 데이터 destructive swipe 위험).

## 3. UI Elements & Animation

- **Button**:
  - Primary (가입하기·결제·청구 제출): accent solid fill, white label, 14pt weight 600, **height 52pt**, radius 10px, full-width by default. Pressed state opacity 0.88, no scale.
  - Critical 가입 confirm: 더블 confirm sheet — "정말로 가입하시겠습니까? 보험료 월 ₩142,800" + Primary "가입 확정" + Ghost "취소".
  - Secondary: surface `oklch(0.95 0.004 240)` + dark text `oklch(0.16 0.008 240)`, same dimension + border 1px `oklch(0.16 0.008 240 / 0.12)`.
  - Ghost: text only with accent color, 44pt height min tap target.
  - Destructive (해지·취소): text-only red `oklch(0.58 0.18 25)`, confirmation sheet 필수.
- **Card**:
  - Policy card: white surface, 14px radius, base shadow, 20px padding.
  - Hero policy: 14px radius, policy emphasis shadow, 24px padding.
  - Nested card 금지 — section 안은 hairline divider 또는 grouped list로 대체.
- **List row**: 64-72px height, 16px horizontal padding, hairline divider `oklch(0.16 0.008 240 / 0.08)` 1px bottom (마지막 row 제외).
- **Form input**: **height 52pt**, radius 10px, hairline border `oklch(0.16 0.008 240 / 0.12)`, focus → accent border 1.5px + ring `oklch(accent / 0.16)` 3px. Inline error 12pt red below. Label 13pt weight 500 above input.
- **Form section header**: 13pt uppercase tracking 0.04em `oklch(0.45 0.010 240)`, 24px top margin + hairline divider 8px below.
- **Chip / Badge**: 999px pill, 24-28pt height, 12pt label, padding 10-14px. Status color는 semantic token만 (납입 중·만기 임박·청구 진행 중).
- **Stepper (progress dot)**: 상단 sticky, 8px filled dot active + 6px hollow dot inactive + 단계명 mono caps 12pt tracking 0.04em.
- **Sheet**: 위 layout 정의 동일.
- **Animation library**: iOS native UIKit spring 우선, React Native Reanimated 3 / Framer Motion (web hybrid 시).
  - Premium count-up: 보장 옵션 toggle 시 보험료 변동 300ms ease-out, tabular-nums 유지.
  - Stepper transition: cross-fade 200ms ease-out. **Slide 금지** (다단계 가입 step 간 horizontal slide는 modal 깊이 혼동).
  - Keypad press: scale 0.95, 80ms in / 120ms out, no spring (tight feedback). Haptic light synchronous.
  - Sheet present: spring damping 22, stiffness 280 — snappy.
  - List enter: stagger 30ms per row, fade + 4px translateY, 200ms ease-out. 10+ items는 stagger off.
  - Pull-to-refresh: native.
  - Page transition: iOS push native (right slide) / Android shared axis X 250ms.
  - **Duration cap**: interactive ≤300ms.
  - **Banned**: bouncy spring on form / button (transaction confidence는 instant), elastic overshoot, parallax, premium amount bouncy.
- **Haptic**:
  - Light (UIImpactFeedbackStyle.light): form select, toggle, keypad tap
  - Medium (.medium): primary CTA, sheet confirm
  - Heavy (.heavy): 인증 실패, 보험료 변경 confirm
  - Notification.success: 가입 완료, 청구 접수 (단 1회, 화면 진입 시점)
  - Notification.error: 청구 거절·결제 실패
- **Skeleton**: shimmer 1.2s loop `oklch(0.94 0.004 240)` → `oklch(0.97 0.004 240)`. 텍스트 자리 60-80% width random.

## 4. Consistency Mandate

이후 제작되는 모든 화면(Home / 보험 detail / 가입 flow / 견적 / 청구 / 결제 / 인증 / Profile / Settings / 약관 / Onboarding)과 모든 서브 화면은 위 Design System Definition을 엄격하게 준수.

새로운 색상 hue·다른 Radius·다른 아이콘 스타일·다른 typography family의 임의 추가 절대 금지. Accent는 프로젝트 진입 시 commit한 보험사 brand color 1 hue만 사용.

한국 보험 form 정보 위계 — **약관 동의 · 개인정보 처리 · 보장 옵션 · 보험료 · 결제 정보 순서 강제**. 약관 footer link 의무 (보험약관 · 개인정보처리방침 · 보험금 청구 안내).

다단계 가입은 each step 진척률 명시 + 뒤로가기 항상 가능. 인증 화면은 system-native 우선 (지문 · 얼굴 · 공동인증서 · 카카오 인증 · PASS).

AI 생성물처럼 보이는 시각적 패턴 배제:

- **AI-generic "insurance modern" purple-blue gradient 금지** — 가장 흔한 cliché. 보험사 brand color 단일 hue commit.
- **Glassmorphism on policy card 금지** — `backdrop-blur` 어떤 강도도 policy card·sheet·tab bar에 사용 금지. 보험 정보는 sacred, blur는 보험료·보장한도를 죽인다.
- **3D illustration "happy family protected by shield" 금지** — 보험 cliché. 실제 policy detail UI 또는 monoline icon으로 대체.
- **Bouncy animation on premium amount changes 금지** — 보험료 transition은 instant 또는 ease-out only. Spring overshoot는 transaction confidence를 깎는다.
- **Generic stock photo "smiling family" hero 금지** — actual policy detail UI 또는 monoline icon으로 대체. Gradient blob 모두 reject.
- **작은 amount typography 금지** — 모든 보험료 표시는 16pt minimum. Large premium display는 32pt+. 단위(원·₩·월)도 weight 400로 약하게 하되 같은 family 유지.
- **Non-tabular nums on 보험료/배상금 금지** — non-tabular financial number는 자동 reject 사유.
- **빨간 "지금 가입!" high-pressure copy 금지** — "가입하기" / "견적 확인" 같은 quiet voice로. 보험은 trust 우선, 충동 marketing copy reject.
- **보험사 자체 brand color 외 추가 accent 금지** — accent는 1 hue commit.
- **Pure `#FFFFFF` background 금지** — `oklch(0.98 0.004 240)` cool tint 유지 (trust signal).

이 transaction-confidence 구조를 기준으로 전체 앱의 톤앤매너·정보 위계·motion 규칙을 일관되고 의도적으로 확장하라.

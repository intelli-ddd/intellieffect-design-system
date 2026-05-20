---
name: fitness-app
type: design-system-prompt
domain: Fitness / workout tracking mobile app — performance metrics, HR zones, activity streams
tone: kinetic, energetic, performance-driven, dark-mode-default, data-rich
reference: Strava, Whoop, Apple Fitness+, Peloton app
platform: mobile
---

# Design System Prompt — Fitness App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준 (iPhone 13 mini ~ iPhone 15 Pro Max). Strava / Whoop / Apple Fitness+ / Peloton 류의 athlete-grade tooling — 숫자가 주인공인 UI, 다크모드가 디폴트, 모션은 cardio처럼 빠르고 단호하게.

운동 중 사용자 — 땀, 흔들림, 직사광선, 한 손 조작, 1초 이내 glance. 모든 결정은 "달리면서 보이는가 / 한 손으로 누르는가"로 검증.

## 1. Design System Definition

- **Theme:** Dark mode default (light mode는 후순위 옵션). 운동 중 OLED 번-인 & 직사광선 대비 모두 충족.
- **Background:**
  - Base `oklch(0.10 0.012 250)` (near-black, 살짝 cool tint)
  - Elevated surface `oklch(0.14 0.014 250)` (카드)
  - Overlay sheet `oklch(0.17 0.016 250)`
- **Text:**
  - Headline `oklch(0.97 0.004 250)` (near-white, 순백 금지)
  - Body `oklch(0.65 0.012 250)` (mid-gray, 운동 중 대비 충분)
  - Tertiary / caption `oklch(0.48 0.010 250)`
- **Accent (2-accent system):**
  - **Primary activity** `oklch(0.72 0.18 142)` — vibrant green, "performance / safe zone / 진행 중"
  - **Secondary alert** `oklch(0.68 0.20 25)` — warm orange, "HR Zone 4-5 / PR 갱신 / 경고"
  - Cyan + magenta motion-friendly pair도 허용: `oklch(0.78 0.16 200)` + `oklch(0.68 0.22 340)` (브랜드가 더 nightlife-electric일 때)
- **Dynamic accent:** zone / effort에 따라 accent intensity 변동. Zone 1 → 채도 0.10, Zone 5 → 채도 0.22. Single HEX 박제 금지.
- **Typography:**
  - Display: **SF Pro Display (iOS) / Roboto Flex (Android)** weight **700-800** for metric numbers (BPM, pace, distance)
  - Body: SF Pro Text / Inter, weight 400-500
  - Mono: **SF Mono / JetBrains Mono** for time, HR, pace
  - **`font-variant-numeric: tabular-nums` mandatory** on every changing value — 숫자 폭이 흔들리면 운동 중 어지러움
  - Display size: 96-128px for hero metric (single page-dominant number)
  - Body 16px min (운동 중 가독)
- **Border Radius:**
  - Cards 16-20px
  - Buttons 12-16px
  - Pills / chips 999px (status / metric chips)
  - Bottom sheet top corners 24px
- **Shadow (다크모드는 glow):**
  - Default elevated card — `inset 0 1px 0 oklch(1 0 0 / 0.04)` (1px top inner light, depth 신호만)
  - Active / focused — `0 0 24px oklch(0.72 0.18 142 / 0.18)` (accent glow, drop shadow 아님)
  - Drop shadow 사용 금지 — 다크 위 검은 그림자는 안 보이고 AI-generic
- **Icon Style:** **SF Symbols 계열** — active 상태 filled, inactive 상태 stroke. 24px 일관. Custom icon도 SF Symbols 메트릭 (stroke 1.75px, rounded join) 따를 것.

## 2. Layout & Structure (Mobile)

- **Safe area:**
  - iOS: top safe area (notch / Dynamic Island) + bottom home indicator (34pt) 모두 존중
  - Android: edge-to-edge + system bar에 dark theme color matching, navigation bar 투명
- **Onboarding (3-4 step):**
  - Full-bleed motion photography or short looping video (running/cycling silhouette, abstract motion blur)
  - Bottom CTA stack — primary button full-width + skip text-button 위
  - 최소 텍스트: 단문 headline (8단어 이내) + body 1줄
  - Progress dots top (4개 max)
- **Home — Activity feed:**
  - Top: greeting + weekly summary chip row (horizontal scroll metric chips: 거리 / 시간 / 평균 HR / 칼로리)
  - Mid: vertical workout list cards
    - Card height ~120-140px
    - Left: activity icon (run / bike / swim) circle 44px
    - Right: title + date + 3-metric row (예: `10.2 km · 48:13 · 162 bpm`) tabular-nums
    - Trailing: small line chart sparkline 또는 PR badge
  - Pull-to-refresh: custom spinner with HR-style pulse, NOT iOS default
- **Workout Detail:**
  - Hero block: **giant metric number** (BPM 또는 pace, 96-128px display, dead-center)
  - 그 아래 secondary metrics row (3-4개 균등 분할, tabular-nums)
  - Animated line/area chart (HR over time, pace splits) — height 200-240px, accent green→orange gradient by zone
  - Map (있다면) full-bleed below chart, dark theme map style mandatory
  - Action row: share / save / delete (text + icon, 분명한 spacing)
- **Live Workout (during exercise):**
  - **Single hero metric, page-dominant** (BPM 또는 elapsed time 200pt+)
  - Swipe horizontally to switch primary metric (haptic on swipe complete)
  - Lock screen / always-on display 대응 — 단색 high-contrast
  - 화면 dim 방지 flag
- **Profile / Stats:**
  - Calendar heatmap (GitHub-style) for activity frequency
  - Personal records list with date stamps
  - Weekly / monthly toggle pill
- **Bottom tab bar:**
  - 4-5 tabs: Home / Activity / **Start (center FAB)** / Stats / Profile
  - Center FAB elevated +8px, accent green fill, "Start workout" — 1탭으로 시작
  - Tab labels 10pt caption underneath icon
  - Active tab: filled icon + accent color + label weight 600
- **Gestures:**
  - Swipe-left on workout card → quick delete / share
  - Pull-to-refresh on feed
  - Long-press on metric → unit toggle (km ↔ mile, °C ↔ °F)
  - Swipe-down to dismiss bottom sheet
  - 화면 가장자리 swipe로 뒤로가기 (iOS default 유지)

## 3. UI Elements & Animation

- **Button variants:**
  - **Primary CTA** — full-width, height 56pt, accent green fill, text 17pt weight 600, radius 16px. Disabled state: opacity 0.4, NO color shift.
  - **Secondary** — outlined, accent border 1.5px, transparent fill, same height
  - **Icon button** — 44pt min tap target, circular 또는 12px radius square, ghost background `oklch(1 0 0 / 0.06)`
  - **Destructive** — accent orange/red text on transparent, confirm dialog mandatory
- **Cards:**
  - Background `oklch(0.14 0.014 250)`
  - Border `1px solid oklch(1 0 0 / 0.06)` (subtle hairline, NOT shadow)
  - Padding 16-20px
  - 카드 내 카드 (nested) 금지
- **List item:**
  - 최소 56pt height (tap target)
  - Divider `1px oklch(1 0 0 / 0.06)` 또는 spacing-only
- **Bottom sheet:**
  - Drag handle 36×4px pill on top, opacity 0.3
  - Snap points: 25% / 50% / 90%
  - Background top corners 24px radius
  - Backdrop `oklch(0 0 0 / 0.5)` tap-to-dismiss
- **Animation library:**
  - iOS native: SwiftUI `withAnimation(.spring(response: 0.35, dampingFraction: 0.8))` for UI elements
  - React Native: **Reanimated 3** + `useSharedValue` + `withSpring({ damping: 14, stiffness: 200 })` for bottom sheet
  - Web view fallback: Framer Motion `transition={{ type: "spring", stiffness: 200, damping: 14 }}`
- **Motion specs:**
  - Tab switch — 200ms `cubic-bezier(0.2, 0, 0, 1)` (ease-out, snappy)
  - Card press — scale 0.98 + opacity 0.9, duration 100ms
  - Metric count-up — 500ms ease-out, tabular-nums interpolation (NEVER format string replace)
  - Chart line draw-in — 800ms ease-out on first paint, NO subsequent re-animate on scroll
  - Bottom sheet spring — damping: 14, stiffness: 200 (snappy, athlete-feel)
  - Screen transition — 280ms shared element when possible
- **Haptic feedback:**
  - Workout start — `UIImpactFeedbackGenerator.medium` / Android `HapticFeedback.heavy`
  - Workout stop — medium impact
  - Tab switch — light impact
  - PR / milestone — success notification haptic (iOS) / heavy + medium pair
  - Long-press unit toggle — selection haptic
- **Loading states:**
  - Shimmer skeleton with accent green tint (NOT gray-on-gray)
  - 1.2s cycle
  - Workout sync: small pulsing dot top-right of stat

## 4. Consistency Mandate (AI-generic banned 패턴)

**금지 (재발 시 디자인 fail 처리):**

1. **Purple → pink gradient** for "fitness/energy" — 챗GPT가 자동으로 뱉는 시그니처. green/orange 또는 cyan/magenta 정의된 페어만.
2. **Glassmorphism on metric cards** — `backdrop-blur-xl + 1px white border + bg-white/10` 카드. 운동 중 가독성 박살, AI-tell 1순위.
3. **Photo overlay with low contrast** — atmospheric photo 위 흰 글씨 + opacity 0.6 overlay → 운동 중 안 보임. Photo는 onboarding hero에서만, 그것도 별도 solid text container.
4. **Generic stock running photo** — Unsplash "person running at sunset" 류. 실제 athlete photography 또는 motion graphic / data viz만.
5. **Bounce spring on interactive buttons** — `damping < 10` overshoot. 버튼은 단호하게 (damping 14+). cardio motion graphic (heart pulse, breathing ring)은 spring 허용.
6. **Pure `#000000` background** — 검정 위 검정 그림자 invisible. `oklch(0.10 0.012 250)` (cool near-black).
7. **Pure `#ffffff` text** — eye strain 다크모드에서 특히. `oklch(0.97 0.004 250)`.
8. **`bg-slate-*` / `bg-zinc-*` as default gray** — Tailwind 기본 zinc는 푸르딩딩 죽은 회색. 정의된 surface token만.
9. **Drop shadow on dark theme** — 그림자 자체가 invisible. Glow 또는 inset 1px top light 사용.
10. **5+ utility classes inline** — `className="bg-zinc-900 border border-zinc-800 rounded-2xl p-4 shadow-xl backdrop-blur-md"` 류. **cva variant API + cn(twMerge+clsx)** 강제.
11. **Inter as sole font** — Inter body는 OK, display는 SF Pro Display / Roboto Flex / 별도 display family. Display+body 페어 필수.
12. **Animation duration > 300ms on UI controls** — 운동 중 답답함. 마케팅 hero 모션만 예외 (chart draw-in 800ms 등 정당화 가능한 케이스).
13. **`filter: blur(...)` animation** — GPU 폭발 + AI-tell. transform / opacity만.
14. **Non-tabular nums on changing metrics** — BPM이 162 → 89 갈 때 폭이 흔들리면 사용자 toast.
15. **AI-generic 영문 카피 — "Crush your goals" / "Unleash your potential"** — 운동 중 cringe. 숫자가 메시지, 카피는 명령형 단문 ("Start", "Resume", "End workout").

**필수 검증:**
- 직사광선 시뮬레이션 (밝기 100% + 콘트라스트 mock)에서 모든 hero metric 판독 가능한가
- 한 손 엄지 reach zone (bottom 2/3)에 primary CTA 위치하는가
- 땀 묻은 손 = 정확도 떨어지는 탭 → tap target 44pt 이상인가
- 모션 멀미 — 화면 전환 + 데이터 카운트업 동시 발생 금지


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

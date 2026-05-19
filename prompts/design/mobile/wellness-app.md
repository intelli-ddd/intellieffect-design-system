---
name: wellness-app
type: design-system-prompt
domain: Wellness / Meditation / Sleep tracking mobile app — atmospheric, contemplative, audio-led
tone: calm, soft, breathable, nighttime-friendly, photographic
reference: Calm, Headspace, Oura, Reflectly, 한국 Maum Wellness
platform: mobile
---

# Design System Prompt — Wellness App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준. Calm / Headspace / Oura / Reflectly 류의 contemplative wellness — 호흡, 명상, 수면. 모션과 색은 fitness와 정반대로 **느리고 부드럽게**, 모든 인터랙션은 사용자가 깊게 숨을 쉴 시간을 준다.

타겟 상태 — 잠들기 직전 침대 위, 어두운 방, 한 손, 낮은 인지 부하. 모든 결정은 "긴장을 풀어주는가 / 갑자기 깨우지 않는가"로 검증.

## 1. Design System Definition

- **Theme:** Dual theme (light + dark **both first-class**, 시스템 시간 / OS 설정 기반 auto). 저녁/밤은 dark 우선.
- **Background — Light theme:**
  - Base `oklch(0.96 0.018 75)` (warm cream, peachy under-tone)
  - Elevated surface `oklch(0.94 0.020 75)`
  - Overlay sheet `oklch(0.98 0.014 75)`
- **Background — Dark theme:**
  - Base `oklch(0.15 0.025 240)` (deep navy, midnight blue)
  - Elevated surface `oklch(0.19 0.028 240)`
  - Overlay sheet `oklch(0.22 0.030 240)`
- **Text — Light:**
  - Heading `oklch(0.22 0.018 60)` (deep warm brown, NOT black)
  - Body `oklch(0.42 0.016 60)` (mid warm brown)
  - Caption `oklch(0.55 0.014 60)`
- **Text — Dark:**
  - Heading `oklch(0.93 0.014 80)` (warm cream, NOT pure white)
  - Body `oklch(0.78 0.014 80)`
  - Caption `oklch(0.62 0.012 80)`
- **Accent (single, muted):**
  - Option A — **muted sage** `oklch(0.62 0.08 142)` (natural, plant-based wellness)
  - Option B — **soft terracotta** `oklch(0.62 0.10 35)` (warm, earth, sunset)
  - **하나만 선택**, 둘 다 쓰는 multi-accent 금지. 채도 ≤ 0.10 — vibrant 절대 금지.
- **Typography:**
  - Display: **Serif** — New York (iOS system serif) / Optima / Lora / Fraunces — emotional headings
  - Body: Sans — SF Pro Text / Inter
  - 한국어: **Pretendard** (display+body 모두) + 강조 시 **나눔명조** 또는 **본명조 (Source Han Serif)**
  - Heading weight **400-500** (NEVER 700+ bold) — 부드럽게
  - Italic accents 허용 (serif italic의 contemplative tone)
  - Body 16-17px, line-height 1.6 (호흡 가능한 leading)
  - Display 32-48px (giant도 절제, fitness처럼 96px+ 금지)
- **Border Radius:**
  - Cards 24-32px (generous, soft)
  - Buttons 16-24px
  - Pills 999px
  - Bottom sheet top corners 32px
- **Shadow:**
  - Light theme — `0 8px 24px oklch(0.22 0.018 60 / 0.06)` (deep brown tint, 매우 soft)
  - Light elevated — `0 16px 48px oklch(0.22 0.018 60 / 0.08)`
  - Dark theme — glow 우선 `0 0 32px oklch(0.62 0.08 142 / 0.10)` for active state. Drop shadow 거의 invisible이므로 사용 안 함.
- **Icon Style:** **Monoline stroke 1.5px**, rounded line caps + rounded joins. 24px standard. Decorative restraint — 장식 ornament / filled icon 금지. Stroke only.

## 2. Layout & Structure (Mobile)

- **Safe area:**
  - iOS Safe Area + bottom home indicator 존중
  - Android edge-to-edge, status bar transparent with light/dark icon auto-switch
- **Onboarding (4-5 step):**
  - **Gradient atmospheric background** — narrow hue range (예: navy `oklch(0.18 0.024 235)` → navy `oklch(0.22 0.026 245)`), 채도 0.02-0.03 폭 안에서만. Vibrant gradient 절대 금지.
  - Single line headline (serif, 32px) + body 1줄 (sans, 16px)
  - Primary CTA bottom 32px above home indicator
  - Skip / next text-button top-right minimal
  - Progress: thin horizontal line (NOT dots) 점진 채워짐
  - Fade transition between steps (800-1200ms), 절대 slide 아님
- **Home — Today / Discover:**
  - Top: time-aware greeting ("Good evening, Dongjin") + soft date
  - **Hero card** — today's recommended session, full-width, 그라데이션 또는 atmospheric image bg + serif title + duration + play
  - Scroll: vertical card stack of meditation / sleep / breathwork sessions
    - Card height 140-180px
    - Atmospheric image left (44% width) or top, content right/below
    - Title (serif, 18-20px) + duration + teacher name + audio waveform thumbnail
  - **Mood tracker bottom strip** — horizontal scroll of 5-7 emoji-less mood states (그저 단어 — "Calm" / "Restless" / "Hopeful"), pill chips, single-tap to log
- **Session Detail / Player:**
  - **Full-bleed atmospheric image or subtle gradient** (NO stock photo, abstract atmospheric만)
  - Top: back arrow only (minimal chrome)
  - Mid: session title (serif, 28-32px) + teacher / duration / category caption
  - **Play button — large, centered, 88-104px diameter circle**, ghost background `oklch(1 0 0 / 0.12)` (dark theme) or `oklch(0 0 0 / 0.06)` (light), single stroke play icon
  - Below: timeline scrubber, ambient sound mix toggle (rain / wind / silence), favorite icon
  - Background slow ken-burns or subtle particle motion (very slow, 60s+ cycle)
- **Sleep / Sleep tracking:**
  - Night-mode auto on after 9pm
  - Sleep score circle (large, breathing animation)
  - Sleep stages bar chart (REM / Light / Deep / Awake) — soft pastel bars, NOT vibrant
  - Wind-down checklist (3-4 items, large tap target)
- **Profile / Journey:**
  - Streak count (소박하게, "12 days" 정도, gamification 과시 금지)
  - Saved sessions
  - Stats — total minutes meditated (subtle, not boast)
- **Bottom tab bar — minimal:**
  - **3-4 tabs only**: Today / Discover / Sleep / Profile (no center FAB, no flashy element)
  - Tab bar background blur 절제 — 단색 surface 권장
  - Active tab: stroke icon stays stroke, **color shift to accent + tiny dot indicator** under label (NO fill swap)
  - Label always visible (10-11pt, weight 500)
- **Gestures:**
  - Pull-to-refresh: NO bouncy default — custom soft fade-in spinner
  - Swipe-down to dismiss bottom sheet (slow spring)
  - Long-press session card → quick add to favorites with light haptic
  - Audio session — lock screen / control center 완전 지원 (백그라운드 재생, 카플레이 OK)
  - Force quit 시 세션 진행상황 자동 저장

## 3. UI Elements & Animation

- **Button variants:**
  - **Primary CTA** — full-width or generous min-width, height 56pt, accent fill (muted sage / terracotta), text 17pt weight 500 (NOT bold), radius 24px
  - **Secondary** — outlined 1px accent, transparent, same height/radius
  - **Tertiary text** — accent color text only, no border, no fill, 44pt tap area
  - **Play button** — circular, 88-104pt for hero player / 56pt for list inline, single thin stroke play icon centered
- **Cards:**
  - Light theme bg `oklch(0.98 0.014 75)` with very soft shadow
  - Dark theme bg `oklch(0.19 0.028 240)` with optional 1px top inner light `inset 0 1px 0 oklch(1 0 0 / 0.04)`
  - Padding 20-28px (generous)
  - Atmospheric image top half + content bottom half pattern
- **List item:**
  - Min 64pt height (느슨한 tap area)
  - Divider — `1px oklch(... / 0.04)` (거의 invisible) 또는 spacing-only
- **Bottom sheet:**
  - Drag handle 40×4px pill, opacity 0.2
  - Snap points: 30% / 70% / 95%
  - Background top corners 32px radius (more generous than fitness)
  - Backdrop `oklch(0 0 0 / 0.4)` fade-in slow
- **Animation library:**
  - iOS native: SwiftUI `withAnimation(.easeInOut(duration: 0.6))` for transitions, `.spring(response: 0.6, dampingFraction: 0.9)` for sheets
  - React Native: **Reanimated 3** with `withSpring({ damping: 18, stiffness: 150 })` for bottom sheet (slower than fitness's 14/200)
  - Web view fallback: Framer Motion `transition={{ type: "spring", stiffness: 150, damping: 18 }}`
  - **Lottie**는 onboarding 일러스트 / breathing visual에 한해 허용
- **Motion specs:**
  - Screen transition — fade 600-800ms (marketing-onboarding 영역 예외, 일반 UI는 300ms)
  - **Onboarding fade-in 800-1200ms** (marketing-like exception)
  - **Session play button — breathing animation** — `scale(1.0) ↔ scale(1.04)`, **4s infinite ease-in-out** (실제 호흡 cycle과 동기). 사용자 호흡 가이드 역할.
  - Audio waveform — smooth real-time animation, 60fps, amplitude는 실제 오디오 데이터 기반 (가짜 sine wave 금지)
  - Mood selector — tap에 light haptic + 0.2s scale 0.95→1.0 spring
  - Bottom sheet — damping: 18, stiffness: 150 (slow & gentle)
  - Tab switch — opacity crossfade 300ms (slide 아님)
  - Card press — scale 0.99 + opacity 0.95, 180ms ease-out (fitness의 0.98보다 더 미세)
- **Haptic feedback:**
  - Mood log — light tap (`UIImpactFeedbackGenerator.light`)
  - Session start — **soft single tap only** (NO success notification haptic — too jarring at bedtime)
  - Session complete — light double tap, 별 잔치 금지
  - Long-press favorite — selection haptic
  - Tab switch — haptic OFF (저녁 사용성)
- **Loading states:**
  - Shimmer skeleton with accent tint at 0.10 opacity (거의 안 보일 정도)
  - Slow 2-2.4s cycle (fitness 1.2s의 2배)
  - 또는 단순한 fade-in placeholder (skeleton 없이)

## 4. Consistency Mandate (AI-generic banned 패턴)

**금지 (재발 시 디자인 fail 처리):**

1. **Purple → pink → blue gradient** for "wellness/spiritual" — Calm 카피캣 AI 시그니처. 정의된 narrow-hue gradient (navy→navy / cream→cream)만.
2. **Glassmorphism on cards** — `backdrop-blur-xl + white border + bg-white/10`. Wellness에서도 AI-tell. Solid surface + 미세 shadow 사용.
3. **AI-tell sparkle / glow particle effects** — "magical" 느낌 내려고 별가루 띄우는 것. 자연 photographic motion (구름, 물결, 나뭇잎)만.
4. **Generic meditation / yoga stock photography** — Unsplash "person meditating on mountain" / 가부좌 + 로우 라이트 류. **Atmospheric photo만** — 추상적 자연 (안개, 바다, 하늘, 숲 detail), 인물 없이.
5. **강한 spring bounce** — `damping < 12`. UI에서 진동 = 명상 분위기 파괴. damping 18+ 강제.
6. **Push notification overuse copy** — "You're slipping! Come back to meditate" / "Don't break your streak!" 류 죄책감 마케팅. 카피는 초대형 — "Tonight, take 10 minutes for you" 같은 invitation tone만.
7. **Vibrant saturated accent** — `oklch(... 0.18+ ...)` 채도. Wellness 톤 파괴. 채도 ≤ 0.10.
8. **Pure white `#ffffff` / pure black `#000000`** — eye strain. 정의된 warm/cool 톤만.
9. **Bold weight 700+ on headings** — wellness ≠ shout. Heading 400-500.
10. **Slate / Zinc gray as default** — 푸르딩딩 죽은 회색은 wellness와 정반대. Warm beige / soft navy surface만.
11. **Drop shadow heavy** — `shadow-2xl` 류 헤비 그림자. very soft `shadow / 0.06` 또는 dark theme glow만.
12. **5+ utility classes inline** — cva variant API + cn(twMerge+clsx) 강제.
13. **Sans-only typography** — emotional heading은 serif 필수. Inter 단독 금지, Pretendard 단독도 한국어 한정 OK이지만 serif 강조 페어가 더 좋음.
14. **`filter: blur(...)` animation** — GPU 폭발, AI-tell. transform / opacity만 애니메이트.
15. **Animation duration < 200ms on transitions** — wellness에서는 빠른 전환이 불편. 슬로우 fade 우선 (marketing onboarding은 800ms+ 허용).
16. **AI-generic 영문 카피 — "Find your zen" / "Discover inner peace" / "Mindfulness made easy"** — 클리셰. 1인칭 invitation + 구체적 시간 ("Sleep better in 10 minutes" / "A 7-minute reset for your afternoon").
17. **Gamification 노출 (XP, points, levels, leaderboard)** — wellness ≠ 경쟁. Streak도 작게 caption 처리, 자랑하지 않음.
18. **Emoji 남발** — mood selector에 emoji 쓰지 말고 단어만. App 내 emoji는 user-generated journal entry에서만.

**필수 검증:**
- 저녁 8pm 침실 시뮬레이션 — 밝기 30%, 다크모드, 한 손 — 모든 primary action 가능한가
- 화면 전환 / 애니메이션이 잠을 깨우지 않는가 (no jarring motion, no loud haptic)
- 카피가 명령형이 아니라 초대형인가 ("Start now" 보다 "When you're ready")
- Heading serif가 emotional weight를 전달하는가, 또는 sans-only로 cold한가
- 한국어 사용 시 Pretendard + serif 강조 페어가 깨끗하게 렌더되는가

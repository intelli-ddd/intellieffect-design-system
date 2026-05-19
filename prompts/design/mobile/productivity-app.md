---
name: productivity-app
type: design-system-prompt
domain: Productivity / Task / Notes mobile app — 할 일·노트·프로젝트 minimal focused 화면
tone: focused, minimal, content-first, light-mode-default, restrained
reference: Notion mobile, Linear mobile, Things 3, Bear, Craft, TickTick
platform: mobile
---

# Design System Prompt — Productivity App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준. 사용자의 글·할 일·생각이 주인공 — UI chrome은 최소화. Light mode default, dark mode는 1:1 pair로 토큰 정의.

본 시스템은 한 손 thumb-zone 조작에서의 빠른 capture(quick add)와 깊은 focus(task detail · note editor)를 동시에 만족시킨다. Things 3의 motion polish + Linear의 keyboard-first density + Bear의 typography reverence가 베이스라인. Notion의 emoji 다용은 mimic하지 않는다.

## 1. Design System Definition

- **Primary Color:** `oklch(0.985 0.004 80)` warm off-white — 종이 톤. Cool 선호 시 `oklch(0.985 0.004 240)`로 swap. **commit 후 lock**.
- **Surface elevation (light)**: base `oklch(0.985 0.004 80)` / grouped card `oklch(0.97 0.004 80)` / sheet `oklch(1 0 0)` pure surface. Dark mode pair: base `oklch(0.13 0.004 250)` / card `oklch(0.16 0.004 250)` / sheet `oklch(0.19 0.004 250)`.
- **Accent Color:** **하나 commit** — 프로젝트 진입 시 single hue lock:
  - `oklch(0.58 0.12 235)` Things-style blue
  - `oklch(0.62 0.18 22)` Bear-style red
  - `oklch(0.70 0.14 50)` Notion-orange
  - `oklch(0.60 0.14 165)` quiet teal (옵션)
  - **AI-generic Linear violet `oklch(0.62 0.16 280)` 영구 금지** (정확히 이 hue가 AI cliché)
- **Text Color:** `oklch(0.16 0.008 250)` headline · task title, `oklch(0.45 0.010 250)` body · meta · project name, `oklch(0.60 0.012 250)` tertiary · placeholder · timestamp
- **Hairline:** `oklch(0.16 0.008 250 / 0.10)` 1px — 모든 divider · input border · grouped list separator
- **Typography:**
  - Display + headline: SF Pro Display (iOS) / Pretendard (한국어). Weight 600 screen title, 700 hero editorial heading (note title).
  - Body + task title: SF Pro Text / Pretendard. Weight 500 task title, 400 body · description.
  - Numerics + code: SF Mono. Tabular-nums for due-date list, task id (`TSK-1234`), shortcuts (`⌘ K`).
  - Note editor body는 17pt minimum (reading comfort) — Bear paradigm.
- **Border Radius:** 10-14px cards. Checkbox 6-8px (subtle, not playful — large radius checkbox는 toy처럼 보임). Buttons 10px. Input 10px. Pills 999px (tag chip only). Sheet top 28px.
- **Shadow:**
  - 거의 없음 — hairline border가 1차 분리.
  - Floating elements만 예외: sheet from bottom `0 -4px 12px rgba(0,0,0,0.04)`, popover `0 8px 24px rgba(0,0,0,0.08)`.
  - List card에 shadow 사용 금지 — grouped list + hairline로 처리.
- **Icon Style:**
  - Monoline stroke 1.5-1.75px, `oklch(0.45 0.010 250)` default / accent on active.
  - Checkbox: empty stroke 1.5px hairline color → filled accent + 흰색 stroke check (animated draw).
  - Tag/category icon: solid 12px dot or small filled circle in tag color.
  - **금지**: AI-generic colorful emoji icon set (Notion이 emoji 허용해도 mimic은 cliché — fluent monoline으로). 3D illustration, isometric icon.

## 2. Layout & Structure (Mobile)

- **Viewport**: 375-430px. iOS safe area top + Android status bar. Bottom safe area + tab bar / FAB stack.
- **Grid**: 4-column logical, 16px gutter, 20px outer padding. Note editor는 18-20px outer.
- **Home (Today / Inbox)**:
  - Top header: screen title 28pt weight 700 (large title iOS style), scroll 시 small title으로 collapse.
  - Section grouped list — "Overdue / Today / Tonight" 같은 section, 13pt uppercase tracking 0.04em `oklch(0.45 0.010 250)` header.
  - Task row 56-64pt: [checkbox 22pt] [title 16pt weight 500] [meta row 12pt: project · due · tag]. Indent for subtask 24px.
  - Long-press row → reorder / context menu.
- **Task Detail**:
  - Title large input 24pt weight 600 (multi-line auto-grow).
  - Notes textarea 17pt body, placeholder "Add note…" `oklch(0.60 ...)`.
  - Meta row chips (project · tags · due · priority · reminder) — 28pt height pills, tap to edit inline sheet.
  - Bottom: subtask list + "+ Add subtask" ghost.
- **Quick Add (modal)**:
  - Full-screen sheet from bottom, 92% height.
  - Title input auto-focus + keyboard immediate.
  - Bottom command bar above keyboard: [calendar] [tag] [project] [priority] [submit] — 44pt icons.
  - Esc/swipe-down dismiss with confirmation if dirty.
- **Note Editor**:
  - Min chrome — top: back chevron + overflow menu. No title bar.
  - Body 17pt SF Pro Text, line-height 1.55, paragraph spacing 12px.
  - Inline toolbar above keyboard: H1 / H2 / Bold / Italic / Code / List / Checkbox / Link.
  - Block hover에서 drag handle (long-press) reveal.
- **Project / List view**: similar to Home but filtered. Sidebar/drawer optional.
- **Bottom Tab Bar**: 3-4 tabs (Today / Inbox / Projects / Profile) OR FAB-centric (Today / Projects / FAB+ / Search / Profile). 56pt + safe area. Active tab = accent label + filled icon, inactive = stroke + tertiary.
- **FAB (옵션)**: 56px circle, accent fill, bottom-right 16px from edge + 16px above tab bar. Plus icon 24pt stroke 2px white. Press scale 0.92 80ms + haptic medium.
- **Sheet**: 28px top radius. Drag handle. 2-snap (50% / 92%) for inline edit, 1-snap full for Quick Add.
- **Gesture**:
  - Swipe-right on task row → complete (accent fill reveal).
  - Swipe-left → snooze / reschedule (neutral) → far swipe-left → delete (red `oklch(0.62 0.20 25)` reveal, confirm required).
  - Drag handle long-press + drag for reorder.
  - Pull-to-refresh native (sync).

## 3. UI Elements & Animation

- **Button**:
  - Primary: accent fill, white label, 14pt weight 600, height 48-52pt, radius 10px, full-width in modal / inline width on detail.
  - Secondary: surface `oklch(0.97 0.004 80)` + text `oklch(0.16 0.008 250)`, hairline border.
  - Ghost: text only with accent, 44pt tap target min.
  - Destructive: text red, confirm dialog.
- **Checkbox**:
  - 22pt square, 7px radius, 1.5px hairline border default.
  - Active: accent fill + white check stroke 2px with `stroke-dasharray` animation 200ms ease-out.
  - Tap area 44pt invisible padding.
- **Task row**:
  - 56-64pt, 16px horizontal padding, hairline bottom (last row 제외).
  - Title strikethrough on complete: `text-decoration` animate 150ms + opacity 0.5.
- **Input**: 48pt height, 10px radius, hairline border, focus → accent border 1.5px + ring `oklch(accent / 0.12)` 3px. Inline note input은 borderless, hairline bottom only.
- **Chip / Tag**: 999px pill, 24-28pt height, 12pt label, padding 10-12px. Tag color = solid hue from limited palette (red·orange·amber·green·teal·blue·purple·pink, all desaturated ~0.10 chroma, NOT the accent's vivid chroma).
- **Card**: grouped list (iOS Settings style) — section card 14px radius, hairline divider rows, no shadow. Standalone card on detail 12px radius + 16px padding + hairline border 1px.
- **Sheet / Modal**: 위 layout 정의.
- **Animation library**: React Native Reanimated 3 / Motion (web hybrid). iOS UIViewPropertyAnimator + native spring.
  - **Task complete**: checkbox stroke draw 200ms ease-out → title strike-through 150ms linear → row opacity 1.0 → 0.5 200ms. After 600ms idle, row collapses to "completed" section (height animate 250ms ease-out).
  - **Drag-to-reorder**: long-press 300ms → haptic medium + lift (scale 1.02 + shadow `0 8px 16px rgba(0,0,0,0.08)`). Drop → spring damping 26 stiffness 320.
  - **Quick add modal**: slide up spring damping 22 stiffness 320, backdrop fade 0 → 0.4 200ms.
  - **Swipe-to-delete reveal**: track finger 1:1, threshold 80px → action commit reveal 200ms ease-out, red fill expands.
  - **Page transition**: iOS push native / cross-platform shared axis X 250ms ease-in-out.
  - **Stagger on list enter**: 25ms per row, 6 rows max, fade + 4px translateY 180ms. 7+ rows는 instant.
  - **Duration cap**: interactive ≤300ms. No filter blur animation.
- **Haptic**:
  - Light: checkbox tap, chip select, tag toggle
  - Medium: swipe action commit, FAB press, drag-reorder lift
  - Heavy / Notification.warning: delete confirm, due-date overdue alert
  - Selection: picker snap (date · priority wheel)
- **Skeleton**: hairline-bordered placeholder rows, shimmer disabled (productivity tone은 quiet). Loading 표현은 단순 spinner 16pt accent color centered.
- **Reduced motion**: `prefers-reduced-motion: reduce` 존중 — stagger off, strike-through instant, sheet fade only.

## 4. Consistency Mandate

이후 제작되는 모든 화면(Today / Inbox / Project / Task Detail / Note Editor / Quick Add / Search / Tags / Settings / Profile / Auth / Onboarding)과 모든 서브 화면은 위 Design System Definition을 엄격하게 준수.

새로운 색상 hue·다른 Radius·다른 아이콘 스타일·다른 typography family의 임의 추가 절대 금지. Accent는 프로젝트 진입 시 commit한 1 hue만 사용.

AI 생성물처럼 보이는 시각적 패턴 배제:

- **AI-generic "Notion-like" colorful emoji icon 금지** — Notion 자체가 emoji 허용해도 mimic하면 cliché. Monoline stroke icon 또는 small solid tag dot으로 처리.
- **AI-generic Linear violet `oklch(0.62 0.16 280)` 금지** — 정확히 이 hue가 가장 흔한 AI productivity 색. Things blue · Bear red · Notion orange · quiet teal 중 commit.
- **Glassmorphism on cards 금지** — `backdrop-blur` 어떤 강도도 카드·sheet·tab bar에 사용 금지. Productivity는 quiet legibility, blur는 텍스트 가독성 손상.
- **Gamification 금지** — xp bar · streak fire · achievement badge · level up animation 모두 reject. Habit tracker라도 minimal stat 표시로.
- **Playful illustration in empty state 금지** — "all caught up" 같은 mascot illustration·isometric character 금지. Text-only empty state: 18pt weight 500 + 13pt subtitle `oklch(0.45 ...)` + optional small monoline icon 32pt centered.
- **3-column dashboard layout 금지** — mobile은 single-column list / single-column editor 강제. Kanban·grid은 tablet/desktop 전용.
- **Large rounded "toy" checkbox 금지** — 12px+ radius checkbox는 children's app 톤. 6-8px radius로 restrained.
- **Bouncy spring on task complete 금지** — 완료는 confidence quiet motion. Overshoot · bounce 금지, ease-out only.
- **AI-generic streaming pastel gradient · fintech blue 톤 mimic 금지** — productivity는 paper-tone neutral + single muted accent.
- **Center-aligned task title 금지** — 모든 task · note 본문 left-align. Empty state copy만 center 허용.

이 focused content-first 구조를 기준으로 전체 앱의 톤앤매너·정보 위계·gesture·motion 규칙을 일관되고 의도적으로 확장하라.

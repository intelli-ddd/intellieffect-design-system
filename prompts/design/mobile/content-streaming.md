---
name: content-streaming
type: design-system-prompt
domain: Music / Podcast / Video streaming mobile app — 컨텐츠 발견·재생·라이브러리 immersive 화면
tone: immersive, content-first, dark-mode-default, photo-driven, motion-rich
reference: Spotify, Apple Music, YouTube Music, Netflix mobile, 멜론·플로
platform: mobile
---

# Design System Prompt — Content Streaming App

> 사용 패턴: designer agent 호출 시 verbatim 인용. **Mobile app** 화면 디자인이므로 viewport 375-430px 기준. Artwork·poster·thumbnail이 화면의 주인공 — UI는 컨텐츠를 가리지 않고 receding 한다. Dark mode default, light mode는 후순위.

본 시스템은 streaming의 immersive 경험(full-bleed artwork, gesture-rich now-playing, mini-player persistence)과 발견(horizontal carousel grid, editorial typography)을 동시에 만족시킨다. Spotify/Apple Music의 player UX + Netflix의 poster-driven discovery가 베이스라인.

## 1. Design System Definition

- **Primary Color:** `oklch(0.09 0.004 250)` near-black (dark theme background) — pure `#000` 금지, slight blue 250 hue로 OLED 친화 + warm cool 균형
- **Surface elevation (dark)**: base `oklch(0.09 0.004 250)` / raised card `oklch(0.13 0.004 250)` / sheet `oklch(0.16 0.004 250)`. Light mode (옵션) primary `oklch(0.985 0.004 250)`.
- **Accent Color:** **하나 commit** — 프로젝트 진입 시 single hue lock:
  - `oklch(0.78 0.18 142)` Spotify green
  - `oklch(0.62 0.22 18)` Apple Music red
  - `oklch(0.55 0.24 22)` Netflix red
  - `oklch(0.82 0.18 75)` editorial amber (옵션)
  - **purple/violet 영구 금지** (AI cliché)
- **Dynamic background**: now-playing 화면은 현재 artwork에서 dominant color 추출 → 화면 상단 vertical gradient `extracted-color` → `oklch(0.09 0.004 250)` 90% 지점에서 fade. 추출 색 saturation은 0.10 cap (난반사 방지).
- **Text Color:** `oklch(0.97 0.004 250)` headline · track title, `oklch(0.72 0.008 250)` body · artist · description, `oklch(0.50 0.012 250)` tertiary · timestamp · duration · play count
- **Typography:**
  - Display + headline: SF Pro Display (iOS) / Pretendard (한국어). Weight 700 track title·section header, 800 hero editorial heading.
  - Body: SF Pro Text / Pretendard. Weight 400 description, 500 metadata.
  - Numerics: SF Mono with tabular-nums for timestamp (`02:34 / 03:48`), play count (`1,234,567`), bitrate.
  - **Gradient text 금지**. **Text shadow 금지** — overlay 위 텍스트는 `drop-shadow(0 1px 2px rgba(0,0,0,0.6))` 또는 dim bottom-bleed gradient.
- **Border Radius:** 8-12px standard cards. **Album/poster art 동일 radius** (8px) — sacred ratio. Bottom sheet 28-32px top-only corners. Mini player 12px. Square chips 6px. Pills 999px (genre filter).
- **Shadow:**
  - Dark theme은 shadow 거의 무용 — 대신 surface elevation으로 분리.
  - Album art ambient만 예외: `0 4px 12px rgba(0,0,0,0.4)` 36px artwork 이상에만.
  - Mini player top edge: `0 -1px 0 rgba(255,255,255,0.06)` hairline.
- **Icon Style:**
  - Player control (play/pause/skip/shuffle/repeat): filled, high contrast, SF Symbols style. Active state = accent color, inactive = `oklch(0.72 0.008 250)`.
  - Navigation: monoline stroke 1.75px.
  - Like/heart: filled when active (accent), stroke when inactive.
  - **금지**: 3D glossy player button (early-2010s skeuomorph), emoji 대용.

## 2. Layout & Structure (Mobile)

- **Viewport**: 375-430px width. iOS top safe area + Android status bar 자동. **Bottom safe area + 64pt mini player + tab bar 56pt** 누적 stack — 콘텐츠 영역 bottom padding 144pt+ 확보.
- **Home (Browse)**:
  - Top sticky header: 좌측 user avatar 32px + 우측 search icon, scroll 시 blur 대신 surface raised 변환.
  - Hero editorial card 90% width swipe carousel (full-bleed image + overlay title 24pt weight 800).
  - 아래 vertical scroll of horizontal carousels: "오늘의 추천 / 새 발매 / 당신을 위한 / 최근 들은" — 각 carousel 카드 140×140 또는 160×220 (album vs playlist).
  - Section header 20pt weight 700 + chevron right.
- **Now Playing (full screen)**:
  - 상단 swipe-down handle (실은 dismiss gesture cue).
  - Artwork center 320-380px square, dynamic shadow ambient.
  - 아래 track title 22pt weight 700 + artist 16pt weight 400 `oklch(0.72 ...)`.
  - Progress bar 4px thin + scrubber 12px circle, 좌 elapsed / 우 remaining tabular-nums 12pt.
  - Control row: shuffle / prev / play(64px)/ next / repeat — 32-48-64-48-32 size hierarchy.
  - Bottom action row: like / device / queue / share — 24pt stroke icon.
  - Tab section: Lyrics / Up next / Related — swipe-up reveals.
- **Library**: list view 64pt row [artwork 48px 8px radius] [title 16pt weight 500 + subtitle 13pt] [chevron / overflow]. Sort/filter chip row sticky.
- **Search**: top input 44pt + recent / genre tile grid 2-column 110pt height.
- **Bottom Tab Bar**: 3-5 tabs (Home / Search / Library / Premium). 56pt + safe area. Mini player 64pt **위에** stack. Active = filled icon + label, inactive = stroke + dimmed.
- **Mini Player**: tab bar 위 고정, 64pt height, 좌 artwork 44px + title/artist truncate + play/pause + close. Tap → now playing full. Drag-up gesture로도 expand.
- **Sheet**: 28-32px top radius. Drag handle 36×4 `oklch(1 0 0 / 0.20)`. Track action sheet (add to playlist / share / view artist 등) 표준.
- **Gesture**: swipe-down dismiss now playing, swipe-left/right on artwork = prev/next track, long-press track row = preview, double-tap artwork = like.

## 3. UI Elements & Animation

- **Button**:
  - Primary (Play / Subscribe): accent fill, dark label `oklch(0.09 0.004 250)` for high-luminance accent, 16pt weight 700, height 52pt, radius 999px (pill) for play CTA / 12px for subscribe.
  - Secondary: surface `oklch(0.16 0.004 250)` + text `oklch(0.97 0.004 250)`, same dimension.
  - Ghost: text only with accent or white.
  - Icon button: 44pt tap target min, hit-slop 8px around 24-32pt icon.
- **Card**:
  - Album/playlist tile: square artwork + title 14pt weight 600 below + subtitle 12pt `oklch(0.72 ...)`. Hover/press scale 0.97 80ms.
  - Editorial hero: full-bleed image + bottom 40% gradient mask + overlay title.
  - **Nested card 금지** — artwork 위 다시 card 얹지 말 것.
- **Mini player**: 위 정의.
- **Animation library**: React Native Reanimated 3 / Motion (web). iOS native UIViewPropertyAnimator + shared element.
  - **Now playing hero transition**: tap mini player → artwork shared-element animate to full-screen position, 400ms ease-out cubic-bezier(0.2, 0, 0.0, 1). Background dynamic gradient cross-fades 300ms.
  - **Mini → full drag-up**: spring damping 24 stiffness 260. Threshold 40% of screen.
  - **Track skip**: audio crossfade 200ms + UI crossfade 150ms. Artwork swipe with 0.92 scale dip mid-transition.
  - **Lyrics auto-scroll**: smooth 400ms ease-in-out, current line accent color + weight 700, others `oklch(0.50 0.012 250)`. Reduced motion → instant snap.
  - **Carousel snap**: native scroll-snap, no JS spring.
  - **Like burst**: 200ms scale 1.0 → 1.2 → 1.0 + accent color flash, no particle confetti (cliché).
  - **Duration cap**: 400ms (hero transition만). 일반 interactive ≤250ms.
- **Haptic**:
  - Light: track skip, like, scrubber drag
  - Medium: play/pause toggle
  - Selection: carousel snap (`UISelectionFeedbackGenerator`)
- **Skeleton**: artwork placeholder `oklch(0.13 0.004 250)` solid + shimmer `oklch(0.16 ...)` 1.2s loop. Text line 60-80% width.
- **Reduced motion**: `prefers-reduced-motion` 존중 — hero transition은 fade only, scrubber animation off, lyrics는 instant.

## 4. Consistency Mandate

이후 제작되는 모든 화면(Home / Search / Library / Now Playing / Lyrics / Queue / Artist / Album / Playlist / Podcast / Profile / Settings / Auth)과 모든 서브 화면은 위 Design System Definition을 엄격하게 준수.

새로운 색상 hue·다른 Radius·다른 아이콘 스타일·다른 typography family의 임의 추가 절대 금지. Accent는 프로젝트 진입 시 commit한 1 hue만 사용.

AI 생성물처럼 보이는 시각적 패턴 배제:

- **AI-generic "modern streaming" purple-pink gradient 금지** — 가장 흔한 cliché. Dynamic background는 artwork에서 추출, hard-coded gradient는 reject.
- **Glassmorphism overlay on artwork 금지** — Artwork은 sacred. `backdrop-blur`로 가리지 말 것. Sheet·tab bar에도 blur 대신 surface elevation으로 분리.
- **Text shadow on overlay 금지** — `text-shadow` 사용 금지. 대신 `drop-shadow(0 1px 2px rgba(0,0,0,0.6))` filter 또는 bottom gradient mask로 처리.
- **Uniform 3-column grid 금지** — 음악 앱은 carousel + variable tile size가 표준. 정사각 grid만 깔면 generic discovery board처럼 보임.
- **3D glossy player button 금지** — early-2010s skeuomorph. Flat filled + SF Symbols style 유지.
- **Particle confetti / like burst 금지** — 200ms scale flash로 충분. Gamification 시그널은 streaming tone과 충돌.
- **Reduced motion 무시 금지** — `prefers-reduced-motion: reduce`는 필수 존중. Hero transition·auto-scroll·shimmer 모두 fallback 정의.
- **Center-aligned long form 금지** — Track title/description은 left-align. Now playing의 title·artist만 center 허용.
- **AI-generic Notion-pastel / fintech-blue 톤 mimic 금지** — streaming은 dark + saturated single accent.

이 immersive content-first 구조를 기준으로 전체 앱의 톤앤매너·layout·gesture·motion 규칙을 일관되고 의도적으로 확장하라.

---
name: kpop-entertainment
type: design-system-prompt
domain: K-pop entertainment company / artist platform / fan engagement (소속사 brand site, artist landing, album release campaign, fan community)
tone: bold cinematic, dark theme default, vivid single accent, motion-rich, photography·video heavy, fan-driven UX
reference: HYBE, SM Entertainment, YG, JYP, Weverse, 빅히트뮤직 (지디웹 2026 수상작), Antenna, SOURCE MUSIC
---

# Design System Prompt — K-pop Entertainment / Artist Platform

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/kpop-entertainment.md` 로 참조.

첨부된 레퍼런스를 분석하여, K-pop entertainment의 cinematic dark-theme Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **K-pop Entertainment Company / Artist Platform / Album Release Campaign / Fan Community**이며, 톤은 HYBE의 corporate cinematic, SM의 visual maximalism, Weverse의 fan UX, 빅히트뮤직 (지디웹 2026 수상작)의 editorial bold treatment를 표적으로 한다. 아티스트·앨범 아트가 sacred — typography·overlay·filter로 가리지 말 것. 한글 + 영문 stacked treatment 강제 (한국어 아티스트명 primary, 영문 romanization secondary 또는 대등).

## 1. Design System Definition

- **Primary Color (Background):** `oklch(0.08 0.004 250)` (near-black canvas with slight cool tint — pure `#000000` 금지). Surface elevation tier `oklch(0.12 0.005 250)` (card · modal), `oklch(0.16 0.006 250)` (popover · dropdown).
- **Accent Color:** artist 또는 album campaign 전용 color — **하나만** commit. 선택지:
  - `oklch(0.72 0.22 18)` vivid coral (default for energetic comeback)
  - `oklch(0.78 0.18 142)` electric mint (fresh debut · summer campaign)
  - `oklch(0.65 0.24 280)` royal violet (artist signature color로 명시된 경우 한정)
  - `oklch(0.82 0.18 65)` golden amber (anniversary · ballad release)
  - **Artist 자체의 signature color**가 있으면 그것을 따라가는 게 옳음 — 위 palette는 fallback.
- **Text Color:** `oklch(0.97 0.004 250)` (near-white heading — pure `#FFFFFF` 금지), `oklch(0.72 0.008 250)` (body), `oklch(0.50 0.012 250)` (tertiary · caption · meta).
- **Typography:** 3-family system, 한글 + 영문 stacked.
  - **Display (아티스트명 · 앨범명 statement):** `Pretendard Display` / `Apple SD Gothic Neo` Heavy (한글) + `Inter Display` / `Neue Haas Grotesk Display` (영문). Weight `700-800` 허용 — editorial과 차별되는 **heavy treatment**가 K-pop 시그니처. Letter-spacing `-0.03em` for large display.
  - **Body Sans:** `Pretendard Variable` (한글 우선) + `Inter` (영문). Weight `400-500`.
  - **Mono (numeric · meta · tag):** `Geist Mono` / `JetBrains Mono` — release date, track number, duration, comeback countdown 표기 한정.
  - 한글 아티스트명 primary, 영문 romanization secondary 또는 대등 stacked. 영문 위주 typography 금지.
  - 텍스트 그라데이션 금지 — 단, accent color flat fill on display heading은 허용 (album campaign color로 한정).
- **Border Radius:** `0` 또는 `4px` (sharp edge for music album cover ratio). **Album/poster art는 정사각 `0` radius** — album art는 sacred geometry. Button · badge · chip 한정 `4-8px` 허용. Pill · 16px+ rounded 금지.
- **Shadow:** dark theme이라 거의 무용. Surface elevation으로 분리 (위 tier 참조). Album art ambient `0 4px 12px rgba(0,0,0,0.5)` 한정 — album cover floating 시.
- **Icon Style:** filled high-contrast (Lucide Solid · Phosphor Fill). Play / pause / skip / heart / share — accent color when active, near-white when idle. 16-24px. Outline icon은 secondary nav 한정.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1920px` 풀-블리드 mandatory (`max-width` cap 금지). Inner content padding `64px` desktop / `24px` mobile.
- **Full-bleed cinematic media hero:**
  - **Background:** full-bleed artist photography 또는 group photo (`21:9` 또는 `16:9`, `100vh` desktop / `85vh` mobile). 실제 branded photoshoot 또는 album art — generic stock 금지. Subtle dark gradient overlay (`oklch(0.08 0.004 250)` from bottom, opacity `0 → 0.5`) for typography legibility only — 아티스트 얼굴 가리지 말 것.
  - **Top nav (transparent overlay):** 좌측 소속사 logo + 우측 5-7 menu (Sans `14-15px`, 한글 우선: 아티스트 · 디스코그래피 · 스케줄 · 커뮤니티 · 샵 · 매거진 · 회사소개). Hairline bottom border `oklch(0.97 0.004 250 / 0.08)` on scroll. Multi-language toggle (한국어 · 영어 · 일본어 최소).
  - **Center 또는 lower-left typographic statement:**
    - Eyebrow (Mono uppercase `12-13px`, tracked `0.12em`, accent color) — 예: `COMEBACK · 2026.06.04` · `1ST FULL ALBUM` · `DEBUT SHOWCASE`.
    - **아티스트명 / 앨범명 (Display Heavy, clamp `72px → 144px`, line-height `0.95`, letter-spacing `-0.03em`)** — heavy weight treatment, 한글·영문 stacked (한글 primary line + 영문 sub line, 또는 대등 horizontal stack).
    - Tagline (Body Sans `18-22px`, max 2 lines) — 앨범 컨셉 1줄.
  - **Bottom info strip (full-width):** 가로 3-4 column — `LATEST SINGLE` (track title + duration mono) · `UPCOMING CONCERT` (venue + date) · `OFFICIAL MV` (YouTube link → arrow). Each cell: Mono caps label `11px` tracked + Sans value. Hairline divider `oklch(0.97 0.004 250 / 0.12)`.
  - **CTA placement (lower-right 또는 center-bottom):**
    - **Primary:** "LISTEN NOW" / "들으러 가기" — accent color fill, padding `16px 32px`, radius `4px`, Sans `15px` medium uppercase tracked `0.04em`. Hover: opacity `0.85`, no transform.
    - **Secondary (Ghost):** "TOUR SCHEDULE" / "공연 일정" — 1px near-white border `oklch(0.97 0.004 250 / 0.3)`, transparent background, near-white text. Hover: border opacity `1.0`, background `oklch(0.97 0.004 250 / 0.05)`.
- 12-column grid는 inner content 한정, hero media는 full-bleed.
- 모든 요소 **Auto Layout** / CSS Grid 기반. 반응형 `<1024px`: 아티스트명 크기 축소, info strip 2×2 grid wrap.
- Hero 하단은 dark canvas로 hard cut. Subtle vignette `1-2vh` 만 허용. Fade gradient 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Filled)`: accent color background, dark text (`oklch(0.08 0.004 250)`), radius `4px`, padding `16px 32px`. Hover: opacity `0.85`.
  - `Secondary (Ghost)`: 1px near-white border `30% opacity`, transparent background. Hover: border `1.0 opacity` + background `5% opacity`.
  - `Tertiary (Link)`: text + arrow `→`. Hover: arrow translate `x: 4px`.
- **Album / Poster card:** square (`1:1`) album art, **radius `0`** (album art is sacred geometry). Below: 한글 앨범명 (Display `20-24px` heavy) + 영문 romanization (italic `16px`) + Mono release date (`2026.06.04`). Hover: album art slight scale `1.0 → 1.03` over `400ms` ease-out + play icon overlay fade-in.
- **Artist card (group · solo):** full-bleed portrait (`3:4` or `2:3`), radius `0`. Bottom overlay: 한글 아티스트명 (Display Heavy `28-40px`) + role (Mono caps `12px`). Hover: dark gradient overlay deepens slightly, no transform.
- **Schedule item:** date Mono large (`24-32px`) + event title Sans medium + venue · time Sans muted. Hairline divider between rows. Accent color dot for "TODAY" marker.
- **Badge / Tag:** Mono `11px` uppercase tracked `0.12em`. 예: `NEW` · `COMEBACK` · `EXCLUSIVE` · `LIMITED` · `한정판`. Radius `4px`. Accent color text on transparent + 1px accent border, 또는 accent fill + dark text.
- **Nav:** transparent overlay → hairline bottom border on scroll. Mega-dropdown (artist grid thumbnail · upcoming schedule · latest release). Multi-language switcher Mono caps `12px`.
- **Music player widget (sticky bottom):** album art thumbnail (radius `0`) + track title + artist + play/pause/skip controls (accent color active state) + progress bar (1px height, accent fill). Background `oklch(0.12 0.005 250)` surface tier.
- **Community / Fan post card:** avatar (radius `999px` 한정 — 사람 얼굴만 예외) + username + post body + reaction count (Mono). Surface elevation `oklch(0.12 0.005 250)`.
- **Animation library:** Framer Motion + GSAP (cinematic effect 한정).
  - **Hero media Ken Burns:** on-load only, slow zoom `1.0 → 1.05` over `≤2000ms` ease-out OR slow pan `≤2000ms`. Loop 금지 — single playback. Marketing hero exception.
  - **Hero typography:** `opacity 0 → 1` + `y: 16px → 0` over `800-1200ms` ease-out, stagger `200ms` (eyebrow → 아티스트명 → tagline → info strip → CTA).
  - **Scroll-triggered parallax:** hero media subtle parallax (`y: -10%` over scroll), discography section album art reveal stagger `100ms`. Reduced-motion 시 즉시 표시 fallback.
  - **Hover:** album art scale `1.0 → 1.03` (`400ms` ease-out), button opacity `0.85`. Bouncy spring · overshoot 금지.
  - **Page transition:** fade `200-300ms` 또는 View Transitions API. Slide-jack 금지.
  - **Banned motion:** sparkle/star particle effects (fan-cam aesthetic cliché), lens flare overlay, chromatic aberration filter, bouncy spring on transition, marquee infinite loop, 3D rotating album cover (early 2010s skeuomorph), **auto-play music with sound on hero entry** (auto-play muted video는 허용).

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Hero · 아티스트 · 디스코그래피 · 스케줄 · 아티스트 bio · 커뮤니티 · 샵 · Auth · Footer) 및 모든 서브 페이지는 위 Design System Definition을 엄격히 준수.
- Single accent only — 처음 선택한 artist/campaign accent 외 다른 saturated color 동시 사용 금지.
- 새로운 색상 · radius scale 추가 · 아이콘 multi-color 사용 금지.
- **Album / Poster art는 sacred:**
  - Overlay text · blur · filter로 가리지 말 것
  - Aspect ratio 변경 금지 (정사각 `1:1` mandate)
  - Radius `0` mandate — rounded album art 금지
  - Cropping 금지 — full art 보존
- **Banned patterns (AI K-pop cliché — 명시적 배제):**
  - AI-generic "K-pop modern" purple-pink-blue rainbow gradient
  - Glassmorphism on artist card · album card · player widget
  - Sparkle / star particle effects · fan-cam shimmer mimicry
  - Bouncy spring · overshoot · elastic transition
  - 영문 위주 typography (한글 아티스트명이 secondary로 밀려나는 구조 금지)
  - 다중 saturated accent 동시 사용 (rainbow palette · neon multi-color)
  - Lens flare · chromatic aberration · TikTok-style filter overlay
  - 3D rotating album cover · skeuomorphic vinyl record graphic
  - Auto-play music with sound on hero entry — muted video만 허용
  - Generic stock concert imagery — branded photoshoot · album art only
  - Cartoon mascot · emoji-heavy decoration
  - Pure `#000000` background · pure `#FFFFFF` text
  - Centered hero with gradient blob background
  - "BUY NOW!" / "PRE-ORDER!" 빨간 sticker burst — Mono caps tracked badge로 대체
- **K-pop 시그널 mandate:**
  - 한글 아티스트명 · 앨범명 Display Heavy treatment 강제, 영문 romanization은 italic secondary 또는 대등 stacked.
  - **Multi-language toggle 필수** (한국어 · 영어 · 일본어 최소, 가능하면 중국어 간/번체 추가) — K-pop 글로벌 fanbase expectation.
  - Comeback countdown · release date Mono 표기 (`2026.06.04 18:00 KST`).
  - Trust signal — 소속사 logo, official partner (YouTube Music · Spotify · Apple Music · Melon · Weverse) footer 배치.
  - Fan engagement layer 필수 — 커뮤니티 · 멤버십 · 굿즈샵 · 콘서트 티켓 path 명확.
  - Album / artist photography 자체 brand asset — 외부 stock 금지.
- **Accessibility / motion:**
  - Reduced-motion media query 존중 — Ken Burns · parallax · album scale 모두 즉시 표시 fallback 필수.
  - Color contrast WCAG AA — dark theme accent color는 vivid라 contrast `4.5:1` 자동 충족하되, body text muted tier는 확인 필수.
  - Multi-language font fallback chain 안전하게 (한 → 영 → 일 → 중).
- 이 Hero Section을 기준으로 전체 사이트의 cinematic immersion, photographic weight, typographic heavy treatment를 일관되고 의도적으로 확장하라. HYBE의 corporate cinematic, SM의 visual maximalism, Weverse의 fan-driven UX, 빅히트뮤직의 editorial bold treatment를 합쳐 단일 K-pop entertainment 신뢰감으로 통합한다.

---
name: corporate-b2b
type: design-system-prompt
domain: Enterprise / Corporate B2B Marketing (consulting, infra, AI services)
tone: confident, minimal, editorial, generous-whitespace, intentional-restraint
reference: Vercel, Notion, Linear, Anthropic, IBM Carbon, Mintlify
---

# Design System Prompt — Corporate B2B

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용.

첨부된 레퍼런스를 분석하여, 풀-와이드 Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Enterprise / Corporate B2B Marketing** (consulting · infra · AI services 회사)이며, 톤은 Vercel의 절제, Notion·Linear의 밀도, Anthropic의 editorial 무게, IBM Carbon·Mintlify의 systemic 일관성을 결합한 confident minimal editorial을 표적으로 한다.

## 1. Design System Definition

- **Primary Color:** 한 톤 commit — light **또는** dark 중 하나 선택 후 페이지 전체 고정.
  - **Light variant:** `#F8F6F0` (warm cream) 또는 `#FAFAF7` (cool ivory). Pure `#FFFFFF` 금지 — warmth가 editorial 톤의 핵심.
  - **Dark variant:** `oklch(0.14 0.012 250)` (near-black, 살짝 cool tint). Pure `#000000` 금지.
- **Accent Color:** 한 가지만 선택 후 페이지 전체에서 최소량 사용:
  - `#5C7A5A` (muted sage) — AI/consulting의 차분한 권위
  - `#C49960` (warm ochre) — editorial warmth, 출판물 톤
  - `#1B2E50` (deep navy) — 전통적 enterprise trust
  - Indigo · violet · saturated purple 절대 금지 (AI-generic cliché).
- **Text Color:**
  - Light variant: `#14130F` (heading), `#54514A` (body). Contrast ratio 12:1 / 7:1 확보.
  - Dark variant: `oklch(0.96 0.008 90)` (heading), `oklch(0.72 0.012 90)` (body).
- **Typography:** display + body **2-family minimum**. Pair 옵션:
  - `Geist` (display) + `Inter` (body)
  - `Söhne` (display) + `GT America` (body)
  - `Neue Montreal` (display) + `Inter Display` (body)
  - Display는 headline · section title 전용, body는 본문 · UI 전용. 단일 family (Inter만 사용) 금지.
  - Headline kerning: tracked `-0.02em ~ -0.03em` (tight display). Body는 default tracking.
  - Gradient text 절대 금지.
- **Border Radius:** `6px` (input · small badge), `8–12px` (button · card). 그 이상 금지 — round한 톤은 editorial restraint를 깬다. 0px (hard edge) 옵션도 허용 — 페이지 전체 일관 유지 시.
- **Shadow:** 거의 없음. Hairline border 우선.
  - 카드/모듈: `1px solid` border, light variant `rgba(20,19,15,0.08)`, dark variant `rgba(255,255,255,0.08)`.
  - 필요 시: `box-shadow: 0 1px 2px rgba(0,0,0,0.04);` 한정. 다중 shadow · ambient glow 금지.
- **Icon Style:** monoline stroke `1.5–2px`, 단색 (text color와 동일), 배경 없음. Lucide / Phosphor Light. 컬러 아이콘 · 파스텔 배경 · 3D · gradient stroke 금지.

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1440px` 풀-와이드 프레임, 콘텐츠 max-width `1280px`. Breakpoint: `1280 / 1024 / 768 / 480`.
- 12-column grid, gutter `32px` (light, editorial), side padding `80px` (desktop) / `24px` (mobile). **Generous whitespace가 정체성** — 빈 공간을 채우려 하지 말 것.
- **Layout 옵션 (둘 중 commit):**
  - **A. Editorial single-column (centered):** display headline 중앙 정렬, max-width `880px`. Eyebrow → Headline → Sub-description → CTA row. 아래 큰 여백 후 supporting visual 또는 client logo strip.
  - **B. Asymmetric split (8:4):** 좌측 8-col에 display headline + sub + CTA. 우측 4-col에 minimal supporting element (단일 quote · single image · client logo column). 좌우 모두 baseline align.
- **Headline:** Display family, `clamp(60px, 8vw, 120px)`, line-height `0.98 ~ 1.04`, weight `500–600`, tracking `-0.025em`. Max 3 lines. Line break는 의도적으로 — 시맨틱 chunk 단위로 끊는다 (자동 wrap에 맡기지 말 것).
- **CTA row:** Primary 1개 + Ghost 1개. 절대 3개 이상 금지.
  - Primary: solid accent or solid text-color, padding `14px 24px`, weight `500`.
  - Ghost: transparent + underline 또는 hairline border.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<768px`에서 single column stack, headline `clamp(40px, 10vw, 64px)`로 축소.
- Hero 하단은 단순 여백 (`120px+`) 또는 hairline divider로 다음 섹션과 연결. Fade gradient · curved divider · wave shape 금지.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary`: solid (accent 또는 text-color), radius `8px`, weight `500`. Hover: color shift only (`brightness +6%` 또는 accent → text-color swap).
  - `Ghost`: transparent, underline `1px` offset `4px`. Hover: underline thickens to `2px` 또는 offset 변화.
  - `Tertiary inline link`: text color + underline. Arrow icon은 hover 시 `translateX 2px`만 허용.
- **Card / Module:** background = primary (or slightly elevated `oklch(L + 0.02)`), border `1px` hairline, radius `8–12px`, padding `32px`. Inner content는 baseline grid 준수.
- **Badge:** small caps `11px`, tracked `0.08em`, accent text + transparent background + accent hairline border. Pill 금지 — `4px` radius로 sharp 유지.
- **Nav:** top sticky `72px`, transparent → `backdrop-filter: blur(12px) saturate(160%)` on scroll. Hairline bottom border on scroll only. Nav 카드에는 blur 적용하지 않음 (글로벌 ban: glassmorphism on cards).
- **Client logo strip:** monochrome only, opacity `0.6`, height fixed `28–32px`. 컬러 로고 사용 시 grayscale filter 강제.
- **Animation library:** Framer Motion 또는 GSAP. 룰:
  - **거의 정적.** Page load stagger reveal만 허용.
  - Stagger reveal: `opacity 0 → 1`, `y: 12px → 0`, duration `≤300ms each`, stagger `60ms`, easing `cubic-bezier(0.2, 0, 0, 1)`.
  - Hover: color shift · underline animation **만** 허용. Scale · translate · rotate 금지.
  - Scroll-triggered animation은 첫 fold 이후 minimal fade-in만. Parallax · pin · scroll-jacking 금지.
  - Filter blur animation · spring overshoot · marquee 금지.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Capabilities, Case studies, Insights, Approach, Team, Contact, Footer) 및 서브 페이지(Services, Work, About, Insights, Contact)는 위 Design System Definition을 엄격히 준수.
- 새로운 색상 · 추가 accent · 다른 radius scale · 다른 typography pair의 임의 추가 금지. Accent는 페이지당 점유율 `<5%` 유지.
- **Banned patterns (AI corporate cliché — 명시적 배제):**
  - Gradient background (any direction, any color combination)
  - Gradient text (특히 headline 위)
  - Glassmorphism (backdrop-blur on content cards)
  - AI-generic Tailwind `slate-*` · `zinc-*`을 default gray로 사용 — 반드시 warm/cool neutral commit
  - `indigo-*` · `violet-*` · `purple-*` accent
  - Bento grid with uniform cells (모든 칸 동일 크기) — editorial은 의도적 asymmetry 요구
  - Stock illustration: handshake · rocket · gear · abstract globe · floating 3D shape
  - Emoji decoration · multicolor 3D icon
  - Bouncy spring · scale hover · parallax
  - Curved section divider · wave SVG · diagonal cut
- **Editorial signals:**
  - Body copy는 max-width `64ch` (light variant 기준). 한 줄 100자 초과 금지.
  - Headline은 의도적 line break — semantic chunk 단위.
  - Section spacing `120–200px` vertical. 답답한 `64px` 간격 금지.
  - Numbers / dates / proper nouns는 본문과 동일 family — fintech처럼 mono 강제하지 않음 (editorial flow 우선).
- 이 Hero Section을 기준으로 전체 사이트의 톤앤매너, 여백 리듬, typography hierarchy를 일관되고 의도적으로 확장하라. Vercel의 절제, Anthropic의 editorial 무게, Linear의 systemic 정교함을 합쳐 단일 enterprise voice로 통합한다.

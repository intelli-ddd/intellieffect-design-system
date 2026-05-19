---
name: medical-clinic
type: design-system-prompt
domain: Premium medical clinic / 의원 / 병원 / 펫의료 brand marketing (피부과 · 성형외과 · 한의원 · 치과 · 동물병원)
tone: clean, trustworthy, wellness-lifestyle adjacent, soft warm, evidence-based, premium calm
reference: 뷰웰의원, 가까이한의원, 픽케어 (지디웹 2026 수상작), 압구정 피부과, 청담 BLS, 강남 줄기세포 클리닉, 압구정 ID 한의원
---

# Design System Prompt — Premium Medical Clinic

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/web/medical-clinic.md` 로 참조.

첨부된 레퍼런스를 분석하여, 풀-와이드 Hero Section을 디자인하라. 이 Hero는 이후 모든 섹션·페이지의 **Design System 기준점**이 된다. 웹사이트 타입은 **Premium medical clinic / 의원 · 병원 · 펫의료 brand marketing (피부과 · 성형외과 · 한의원 · 치과 · 동물병원)**이며, 톤은 지디웹 2026 수상작 — 뷰웰의원 · 가까이한의원 · 픽케어 — 같은 한국 의료 marketing의 신뢰감과 lifestyle wellness 브랜드의 따뜻함을 결합한 표현을 표적으로 한다. 의료의 evidence-based 무게와 lifestyle 브랜드의 calm warmth를 단일 톤으로 통합할 것 — 차가운 sterile hospital cliché 절대 금지.

## 1. Design System Definition

브랜드 톤에 따라 2개 variant 중 선택. 두 variant는 mutually exclusive — 같은 사이트 내 혼용 금지. 펫의료는 Variant A + warm coral accent 옵션.

### Variant A — Warm Off-white (default for 한의원 · 피부과 · 치과 · 펫의료)

- **Background:** `oklch(0.97 0.008 80)` (warm off-white — pure `#FFFFFF` 금지. 병원의 cliché 차가운 white를 회피하고 wellness lifestyle 톤을 형성)
- **Text Primary (Headline):** `oklch(0.20 0.012 220)` (deep navy — pure `#000000` 금지)
- **Text Secondary (Body):** `oklch(0.45 0.014 220)` (muted navy)
- **Accent:** 하나 commit (mutually exclusive):
  - `oklch(0.62 0.08 165)` muted sage (한의원 · wellness 친화)
  - `oklch(0.58 0.06 80)` warm taupe (치과 · 피부과 lifestyle)
  - `oklch(0.72 0.10 40)` warm coral (펫의료 한정 — 따뜻한 동물 친화)

### Variant B — Cool Calm (default for 성형외과 · 종합 클리닉 · 줄기세포 advanced)

- **Background:** `oklch(0.965 0.012 220)` (cool calm off-white)
- **Text Primary (Headline):** `oklch(0.20 0.012 220)` (deep navy)
- **Text Secondary (Body):** `oklch(0.45 0.014 220)` (muted navy)
- **Accent:** `oklch(0.55 0.10 220)` calm blue (단일 commit, electric/cyan blue 금지)

### 공통 규칙

- Single accent only — 두 accent 동시 사용 금지. **빨강 · 강한 saturated 색 금지** (의료 = warning 연상 차단).
- **Typography:** 3-family system, **한글 우선** (의료는 한국어 정보 위계가 환자 신뢰의 1순위).
  - **Display Serif (헤드라인 trust signal):** `Cormorant Garamond` 또는 `Tiempos` (영문) + `본명조` 또는 `Pretendard Display` (한글). Weight `400-500` (heavy weight 금지 — refined serif가 medical prestige).
  - **Body Sans (가독성):** `Pretendard Variable` 또는 `Inter` — 본문 · 진료 안내 · 보험 정보. 한글 우선 family.
  - **Mono (caption 한정):** `Geist Mono` 또는 `Pretendard JP` — 시술명 · 예약 시간 · 진료 코드 표기.
  - 텍스트 그라데이션 절대 금지.
  - 영문 위주 typography 금지 — 한글 진료과목 · 의사명이 primary.
- **Border Radius:** `12-20px` (soft approachable). Cards · buttons `14px` default. 차가운 sharp edge (`0px`) 회피, 과도한 pill 라운드 (`24px+`) 회피.
- **Shadow:** subtle 2× blur 룰 — `0 6px 16px rgba(0,0,0,0.05)` default. Doctor profile card에 strong elevation `0 12px 32px rgba(0,0,0,0.08)`. Background photography가 보조 elevation 역할.
- **Icon Style:** 단색 monoline `1.5px` stroke. 의료 상징 (heart · leaf · stethoscope · paw for 펫의료) 우선 사용. Lucide Light weight. **3D 의료 illustration 절대 금지** (DNA helix · heart pump · sci-fi lab 패턴 금지).

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 `1440px+` 풀-와이드 프레임, inner padding `64px` (desktop) / `20px` (mobile).
- **좌측 typographic statement (60% width):**
  - **Eyebrow (Mono uppercase `12px`, tracked `0.10em`, accent color)** — 신뢰 signal: 예 `한방 진료 · 33년 SINCE 1993` · `대한피부과학회 정회원` · `KAHA 인증 동물병원`.
  - **Headline 한글 (Display Serif weight 500, clamp `48px → 88px`, line-height `1.1`, letter-spacing `-0.015em`)** — 영문 italic secondary stacked. 한글이 primary, 영문은 brand mark 역할.
  - **Sub (Body Sans `18-22px`, max 2 lines)** — 진료/시술 분야 1-2줄 요약. 의료법 준수 voice (효과 보증 표현 금지).
  - **CTA pair:**
    - **Primary:** "진료 예약" — accent solid background + warm white text (`oklch(0.97 0.008 80)`), radius `14px`, padding `16px 28px`, Body Sans weight 600 `15px`.
    - **Ghost:** "원장 인사말" 또는 "둘러보기" — transparent + 1.5px accent border, same radius/padding, accent text.
- **우측 photography (40% width):**
  - 실제 원장 · 전문의 portrait (인물 중심) **또는** lifestyle photography (clinic interior · 치료 공간 · 자연광). Aspect ratio `4:5` 또는 `3:4` portrait orientation. Image radius `20px`.
  - **금지:** 시술 결과 before/after 사진, stock "smiling diverse patient" cliché, sterile operation room photo.
- **하단 trust strip (full-width, hero 하단 fixed):**
  - 4-col hairline divider strip — `진료시간` · `위치` · `진료과목` · `보험 적용`. 각 cell: label (Mono uppercase `11px` muted) + value (Body Sans `15px` deep navy). Hairline `1px` accent 10% opacity divider 분리.
- 모든 요소는 **Auto Layout** 기반. 반응형: `<1024px`에서 우측 photography가 상단 stack, typographic statement 하단. Trust strip은 2×2 grid wrap.
- Hero 하단은 photography에서 다음 섹션 background로 1-2vh subtle fade. Hard transition은 medical 톤에 어울리지 않음.

## 3. UI Elements & Animation

- **Button variants:**
  - `Primary (Solid)`: accent solid + warm white text, radius `14px`. Hover: opacity `0.92` + `y: -2px` lift.
  - `Ghost (Outline)`: 1.5px accent border, transparent. Hover: accent 10% bg fill.
  - `Tertiary (Link)`: accent underline, no padding. Hover: opacity `0.7`.
- **Card:** Doctor profile · 시술 menu · 진료 안내 카드. Background `oklch(0.99 0.005 80)` (1-tier lighter than hero bg), radius `20px`, shadow `0 12px 32px rgba(0,0,0,0.08)`. Padding `32px`.
- **Badge:** Mono `11px` uppercase tracked `0.10em`. 예: `예약 우선` · `보험 적용` · `당일 진료 가능`. Radius `8px`, accent 12% bg + accent text. Pill (`radius: 999px`) 금지.
- **Nav:** transparent overlay on hero scroll, hairline bottom border on scroll trigger. Logo (한글 + 영문 stacked) 좌측, 5-6 menu items (병원소개 · 진료안내 · 의료진 · 시설 · 후기 · 예약). Body Sans `15px`.
- **Appointment widget:** floating bottom-right "온라인 예약" sticky CTA (Solid Primary variant). Mobile에서 bottom-fixed full-width band.
- **Animation library:** Framer Motion only (GSAP overkill — medical은 calm motion).
  - **Hero entrance:** text staggered reveal — eyebrow → headline → sub → CTA → trust strip 순 `120ms` stagger, `opacity 0 → 1` + `y: 12px → 0` over `600-800ms` ease-out. Photography는 `opacity 0 → 1` + `scale 1.02 → 1.0` over `1000ms` ease-out.
  - **Hover:** interactive ≤`300ms` cap. `y-axis -2px` lift + opacity transition. Scale · rotate · spring overshoot 금지.
  - **Scroll-triggered reveal:** section enter 시 `y: 16px → 0` + opacity over `500ms` ease-out, once-only.
  - **Banned motion:** before/after sliding comparison slider, sparkle/glow effect (lab-tech sci-fi), parallax scroll-jacking, video autoplay with sound, marquee scrolling text, bouncy spring, infinite loop background animation.

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Hero · About doctor · Treatment menu · Facility · Reviews · Appointment · Location · Footer) 및 서브 페이지는 위 Design System Definition을 엄격히 준수.
- Variant A / B 선택은 프로젝트 단위로 lock — 페이지별 혼용 금지.
- 새로운 색상 · 추가 accent · 다른 radius scale · multi-color icon 임의 추가 금지.
- **Banned patterns (AI medical cliché — 명시적 배제):**
  - AI-generic 차가운 cyan / electric blue gradient (병원 cliché 즉시 파괴)
  - Sterile pure white `#FFFFFF` background + 빨간 cross logo cliché
  - Before/after sliding comparison animation in hero (시술 결과는 별도 portfolio 페이지에서만, disclaimer 동반)
  - 글로우 · sparkle effect (lab-tech sci-fi aesthetic — medical trust 파괴)
  - Stock photography of "smiling diverse patient" — 실제 원장 · 전문의 portrait 우선
  - 의료 3D illustration (heart pump · DNA helix · 분자 모델 floating animation)
  - "Limited consultation!" · "오늘만 50% 할인!" high-pressure copy (의료법 위반 신호)
  - Auto-rotate carousel of treatment photo (clinical photos는 별도 portfolio 섹션 only)
  - Glassmorphism on appointment card · doctor profile card
  - 다중 saturated accent (의료는 quiet single accent lock)
  - Gradient text — 특히 headline 위 (medical trust 즉시 파괴)
  - Emoji · cartoon mascot · playful illustration (펫의료는 monoline paw icon 한정 허용)
- **Korean medical 신뢰 시그널 mandate:**
  - Footer에 진료 경력 (년수) · 학력 · 학회 활동 · 보험사 제휴 · 사업자등록번호 · 의료기관 인증 배치.
  - 의료법상 "최고" · "유일" · "100% 완치" 같은 표현 절대 금지 — Voice에도 반영.
  - 시술 결과 사진은 disclaimer 동반 (`*개인차가 있을 수 있습니다`).
  - 한국 의료 전통 신뢰 시그널 — 진료 경력 (년수), 학력, 학회 활동, 보험사 제휴 명시.
  - 진료시간 · 휴진일 · 위치 · 전화번호는 hero trust strip + footer 둘 다 노출.
- 이 Hero Section을 기준으로 전체 사이트의 calm trust tone, wellness lifestyle warmth, evidence-based prestige를 일관되고 의도적으로 확장하라. 뷰웰의원의 typographic restraint, 가까이한의원의 lifestyle warmth, 픽케어의 pet-friendly approachability를 합쳐 단일 한국 medical trust 톤으로 통합한다.

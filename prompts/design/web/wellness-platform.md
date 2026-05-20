---
name: wellness-platform
type: design-system-prompt
domain: Personalized Health & Wellness Platform
tone: friendly, calm, organic, trustworthy
reference: GDWEB 류 한국 wellness/health 마케팅 사이트
---

# Design System Prompt — Wellness Platform

> 사용 패턴: designer agent 호출 시 spec body 에 본 파일 verbatim 인용. 또는 메인 세션이 사용자 prompt 에 `@~/.claude/prompts/design/wellness-platform.md` 로 참조.

첨부된 레퍼런스 이미지를 분석하여, 전체 웹사이트를 제작할 수 있도록 풀-와이드 Hero Section을 디자인하라. 이 Hero Section은 이후 제작될 모든 섹션과 페이지의 **Design System 기준점**이 되어야 한다. 웹사이트 타입은 **Personalized Health & Wellness Platform**이다.

## 1. Design System Definition

- **Primary Color:** `#E6E7E3` (차분하고 따뜻한 라이트 그레이 배경 컬러)
- **Accent Color:** `#B6E63A` (브랜드를 대표하는 라임 그린, CTA 및 핵심 강조 요소에만 제한적으로 사용)
- **Text Color:** `#1A1A1A` (헤드라인), `#5F5F5F` (바디 텍스트)
- **Typography:** Modern sans-serif 기반. Bold한 대문자 또는 세미볼드 헤드라인, 가독성 높은 Regular 바디 텍스트. 텍스트에는 그라데이션을 절대 사용하지 않는다.
- **Border Radius:** 24px 이상, 부드럽고 친근한 라운드 코너
- **Shadow:** 낮은 대비의 소프트 드롭 섀도우 (예: `0px 12px 32px rgba(0,0,0,0.08)`)
- **Icon Style:** 배경 없는 단색 아이콘만 사용하거나, 모든 아이콘에 동일한 단일 배경색 적용

## 2. Layout & Structure (Hero Section)

- 데스크톱 기준 1440px 이상 풀-와이드 프레임
- 좌측: 텍스트 중심의 콘텐츠 영역 (Eyebrow Text, Headline, Description, Primary / Secondary CTA)
- 우측: 실제 생활감이 느껴지는 인물 중심의 고해상도 이미지
- 모든 요소는 **Auto Layout** 기반으로 구성하여 반응형 확장과 유지보수가 용이해야 한다
- Hero 영역 하단은 부드러운 페이드 또는 화이트 영역으로 자연스럽게 다음 섹션과 연결

## 3. UI Elements & Animation

- 버튼은 **Component**로 정의하며, Primary 버튼은 Accent Color 단색 배경 + 다크 텍스트
- Secondary 버튼은 아웃라인 스타일 또는 뉴트럴 톤
- 카드, 뱃지, 네비게이션 요소 모두 동일한 Border Radius와 Shadow 규칙을 공유
- **Framer Motion 로직**을 고려한 애니메이션 적용:
  - Hero 진입 시 텍스트는 `staggered reveal on load`
  - 버튼과 인터랙티브 요소는 `smooth hover transition (opacity / y-axis 4~8px)`
  - 과도한 모션이나 화려한 효과는 배제하고, 안정적이고 신뢰감 있는 움직임만 허용

## 4. Consistency Mandate

- 이후 제작되는 모든 섹션(Features, How it works, Testimonials, Pricing, Footer)과 모든 서브 페이지는 반드시 위에서 정의한 **Design System Definition**을 엄격하게 준수해야 한다.
- 새로운 색상, 다른 Radius, 다른 아이콘 스타일의 임의 추가를 절대 허용하지 않는다.
- AI 생성물처럼 보이는 시각적 패턴을 명확히 배제한다:
  - 그라데이션 사용 금지
  - 파스텔 톤 아이콘 배경 금지
  - 아이콘별 상이한 색상 조합 금지
  - 아이콘은 반드시 배경 없는 단색 아이콘이거나, 전체 시스템에서 동일하게 정의된 단일 배경 규칙만을 사용해야 한다
- 이 Hero Section을 기준으로 전체 웹사이트의 톤앤매너, 레이아웃, UI 규칙을 일관되고 의도적으로 확장하라.

## 5. 구현 Guardrails (MUST READ)

상위 `prompts/design/_guardrails.md` 의 5 카테고리 (Text overflow / useGSAP scope / Motion stacking / Absolute positioning / Reduced motion) 모두 적용. 본 DSP 특이 trap:

- 본 DSP 는 SplitText / GSAP 권장 안 함 (Section 3 의 "안정적이고 신뢰감 있는 움직임만") — Category A/B/C/D 자동 회피
- Category E (reduced-motion) 만 의무 — CSS `@media (prefers-reduced-motion: reduce)` 블록으로 모든 keyframe·transition 0.01ms clamp

## 6. Media Generation Prompts

본 DSP 의 hero portrait / feature tile 자리에 들어가는 image 자산을 위한 prompt verbatim. 공통 style descriptor 는 상위 `_media-prompts.md` 의 **Style B — Soft organic wellness** 사용.

생성 방법:

```bash
# 전제: codex login 완료
./scripts/codex-media-gen.sh \
  --dsp wellness-platform \
  --prompt hero-portrait \
  --output ../distinctive-ui-test/public/wellness/hero-portrait.png \
  --size 1024x1536
```

### 6.1 Hero portrait — 우측 인물 이미지

<!-- media-prompt: name=hero-portrait type=image preset=cover-portrait provider=gpt-image-1 -->

Style: Soft organic wellness lifestyle photography. Warm natural light through large window, 5500K color temperature, gentle falloff into shadow. Mood: morning ritual, slow, embodied, considered. Photographic editorial wellness magazine quality.

Subject: woman in her early 30s holding a warm ceramic mug with both hands, seated at a linen-draped surface near a sunlit kitchen or quiet living room window. Three-quarter view, she is looking down into the mug, slight smile, eyes downcast. Cream linen shirt or oversized cardigan sleeve visible. NO direct face contact with camera.

Composition: 4:5 portrait orientation. Subject anchored to LEFT THIRD of frame, ample empty warm-cream space upper-right with soft window light bleeding in. Out-of-focus botanical fragment (oak branch / dried eucalyptus) at top edge of frame. Background = warm out-of-focus interior, oak wood grain shelf or linen curtain.

Lighting: large window soft light from camera-right at 30°, golden-natural quality, soft falloff into warm shadow on left side of subject. No flash, no harsh shadow, no studio look.

Color: warm cream and oat tones throughout (oklch 0.96 0.012 80 dominant), sage green accent only in single small element (a sprig of herb, a ceramic glaze, dried plant — minimal). Skin tone warm natural. NO cool tones, NO pure white, NO neon, NO saturated jewel tones, NO greys.

NO direct eye contact. NO stock-photo over-perfect smile. NO conference-room or office. NO laptop or screen. NO yoga mat cliché. NO meal prep gear. Single human subject. Editorial wellness magazine quality.

### 6.2 Feature tile — Movement (운동·웰니스 활동)

<!-- media-prompt: name=feature-movement type=image preset=cover-square provider=gpt-image-1 -->

Style: Soft organic wellness lifestyle still life. Warm natural light, embodied moment.

Subject: top-down overhead shot of two bare feet stepping gently onto a folded linen blanket on warm oak wood floor. No equipment, no yoga mat brand visible. Feet only — no full body, no face. OR alternative: close-up of bare hands cupping a small ceramic bowl of mixed nuts and dried fruit on linen napkin.

Composition: 1:1 square, centered subject, generous warm-cream negative space around. Subject 50-60% of frame.

Lighting: warm window light from above-right, soft falloff. 5500K.

Color: dominant cream + oat + warm oak (oklch 0.94-0.96 / 0.012 80), single muted sage green accent in shadow detail. No saturation.

No equipment branding. No yoga props with logos. No fitness watch. Single moment, intimate scale.

### 6.3 Feature tile — Nourishment (식사·차)

<!-- media-prompt: name=feature-nourishment type=image preset=cover-square provider=gpt-image-1 -->

Style: Soft organic wellness still life. Editorial slow-food photography.

Subject: three-quarter overhead shot of a small ceramic teapot pouring herbal tea into a matching cup, steam rising and catching window light, single dried herb sprig (chamomile or mint) resting beside on raw linen napkin. Worn wooden surface texture. Optional: small ceramic plate with whole fruit (pear or fig) at frame edge.

Composition: 1:1 square, hero subject (teapot pour) center-left, plate at lower-right frame edge. Generous negative space upper-right.

Lighting: warm window light from camera-right at 30°, soft directional, catching steam particles. 5000-5500K.

Color: warm cream backdrop (oklch 0.94 0.014 80), oak wood grain mid-tone, single sage green from dried herb sprig. Tea color warm amber. No oversaturated bowls or colorful prop styling.

No utensils with brand logos. No paper napkins. No coffee shop aesthetic. Single moment, considered, slow.

### 6.4 Feature tile — Rest (휴식·수면)

<!-- media-prompt: name=feature-rest type=image preset=cover-square provider=gpt-image-1 -->

Style: Soft organic wellness interior, photographic editorial.

Subject: close-up of soft linen bedding (cream or warm oat tone), gentle wrinkles, single dried lavender or dried botanical placed on the corner of the pillow. Warm morning light coming through curtain (curtain visible upper-left frame, slightly out of focus). NO people, NO sleep tech products, NO sleep mask.

Composition: 1:1 square, bedding texture occupying full frame, dried botanical as small focal point right of center. Curtain corner upper-left providing soft window-light gradient.

Lighting: filtered morning window light from upper-left, very soft, no harsh shadow. 5000K.

Color: cream + warm oat linen dominant, single faint sage green from dried botanical. No deep navy or black accents, no greys.

NO bed frame. NO sleep tracker device. NO phone. NO branded product. Pure texture + light + single botanical.

### 6.5 Pre-commit audit hook for media

본 DSP 적용 시 generated code 가 외부 placeholder image (Unsplash URL 등) 를 사용하면, designer agent 는 매핑되는 media-prompt 가 박혀있는지 확인:

```bash
# 외부 image URL 사용 색출
grep -rnE 'unsplash\.com|picsum\.photos|i\.imgur' <project>/app

# DSP 의 media-prompt 매핑 카운트 (≥ 4 기대)
grep -c "<!-- media-prompt: name=" prompts/design/web/wellness-platform.md
```

외부 placeholder 사용 자리 N개 → media-prompt N개 매핑 ≥ 1:1.

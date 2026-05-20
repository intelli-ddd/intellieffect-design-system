---
name: intellieffect-design
description: >
  AUTO-TRIGGER on any UI/UX design request — React/Next.js component, hero section, landing page, marketing site, pricing page, dashboard, mobile app screen, Tailwind theme/@theme block, Motion/GSAP animation, shadcn install/customization, or any task that ends with a renderable interface.

  IntelliEffect 팀 design system wrapper. 사용자 요청 도메인을 20 DSP (Design System Prompt) 카탈로그에서 매칭한 뒤, **그 DSP를 verbatim 적용**하여 코드 생성. AI-generic UI defaults 회피 + 회사 일관 톤 확보. 지디웹 한국 시장 reference 통합.

  Web DSP (12): wellness-platform, fintech-saas, corporate-b2b, ecommerce-luxury, editorial-magazine, education-edtech, real-estate-kr, kbeauty-cosmetics, kpop-entertainment, medical-clinic, museum-cultural, automotive-mobility.
  Mobile DSP (8): fitness-app, wellness-app, fintech-app, content-streaming, productivity-app, insurance-mobile, ecommerce-mobile-kr, fnb-membership.

  Activation flow: (1) 사용자 요청에서 도메인 키워드 추출 (예: "pricing page" + "Linear 톤" → fintech-saas 또는 corporate-b2b / "한국 분양 사이트" → real-estate-kr / "K-beauty 브랜드 사이트" → kbeauty-cosmetics / "보험 가입 모바일" → insurance-mobile), (2) 매칭 DSP 파일 경로 명시 (`@plugin's prompts/design/<web|mobile>/<slug>.md`), (3) Claude Code 환경이면 designer agent 위임 (Task tool `subagent_type: "designer"`) — 그 외 환경이면 DSP inline verbatim 적용 + iteration loop 직접 실행.

  Override DSP 가능 — 사용자가 명시적으로 "Linear 톤", "Aesop 톤", "한국 매거진 톤" 같은 키워드 박으면 그 톤이 매칭되는 DSP 우선. 매칭되는 DSP가 없으면 가장 가까운 reference + `_template.md` 기반 inline DSP 즉석 생성.
license: MIT
metadata:
  version: "1.6.0"
  author: IntelliEffect
  upstream: frontend-design@claude-plugins-official (recommended dependency)
  vault-source: "Intellieffect-Vault 08-Resources/Marketing/랜딩페이지 레퍼런스/ (17 sites + 9-section meta analysis)"
---

# IntelliEffect Design System

**이 skill은 IntelliEffect 팀의 UI 디자인 작업에 자동 적용된다.** 사용자가 UI/디자인 관련 요청을 하면 이 skill이 활성화되어, 20개 DSP 카탈로그에서 도메인 매칭 후 verbatim 적용한다.

## 핵심 룰 (모든 UI 작업에 강제)

1. **DSP verbatim 적용** — 매칭된 DSP의 color hex, radius, shadow token, typography family를 한 글자도 변경 금지
2. **AI-generic 패턴 명시 배제** — 각 DSP의 "Banned patterns" 섹션을 코드에 적용 전 grep으로 검증
3. **Single accent commit** — DSP가 multi-color 정의 안 한 이상 페이지당 1개 accent, ratio ≤ 10%
4. **Single-shot 금지** — 코드 생성 후 screenshot iteration 최소 2 라운드 (renderable component에 한해)
5. **frontend-design plugin 활용** — 설치되어 있으면 base aesthetic guardrail로 활용. 없어도 본 skill 자체가 충분한 design context 제공.

## Award-grade signal — 글로벌 banned 패턴 (모든 DSP 위에 강제, v1.2.0 추가)

**문제**: DSP가 positive spec만 있으면 LLM은 학습 corpus의 **median** (Stripe/Linear/Vercel을 섞은 SaaS template) 을 출력. AI-template median이 모든 도메인에서 동일하게 나타남. 다음은 어떤 DSP를 활성화해도 항상 적용되는 negative constraint:

### A. Banned typography (어느 DSP든 위반 시 failure)

- **Inter weight 700 또는 800**을 헤드라인에 사용 — 가장 강한 AI-template 시그널. 사용 가능 weight: 400, 500, 510 (Linear-style 비-표준), 590, 600 만.
- **단일 family (Inter만, Geist만)** 헤드라인+본문 동시 사용 — 항상 display + body + (optional) mono 3-family pair 강제.
- **`letter-spacing: normal`** 을 48px+ display headline에 사용 — 모든 headline에 progressive negative tracking 강제:
  - 48px → `-0.05em` (-2.4px)
  - 32px → `-0.04em` (-1.28px)
  - 24px → `-0.04em` (-0.96px)
  - 16px → `-0.02em` (-0.32px)
  - 14px 이하 → `normal`
- **OpenType features 미활성화** — body에 `font-feature-settings: "tnum", "ss01"` 또는 `font-variant-numeric: tabular-nums slashed-zero` 글로벌 강제. 누락 시 모든 숫자가 proportional digit으로 jitter → AI-template 시그널.
- **`font-weight: bold`** (700) for emphasis — 대신 `font-weight: 510` 또는 `font-weight: 600` + tracking 조정으로 hierarchy 만들 것.
- **Title Case Headlines** — sentence-case 강제 ("Banking — redesigned from the ground up" 같은 형태. "The Best Platform For Modern Teams" 같은 Title Case 금지).

### B. Banned color (어느 DSP든 위반 시 failure)

- **Tailwind 기본 indigo-500 (`#6366f1`)**, **purple-blue gradient** (purple → blue → pink), **violet-* / sky-* / emerald-* tailwind defaults** — 모두 LLM이 가장 자주 reach하는 색.
- **Pure `#000000` / `#ffffff`** — 항상 near-black (`oklch(0.10 0.004 250)` 또는 `#0A0A0A~#171717`) + near-white (`oklch(0.97 0.004 80)` 또는 `#FAFAFA`).
- **다중 saturated accent** (rainbow palette) — single accent 페이지 ratio ≤ 10% 강제.
- **Gradient text** on headline/metric — 절대 금지.

### C. Banned layout (어느 DSP든 위반 시 failure)

- **Split 7:5 hero with text-left + product-mock-right** — 가장 흔한 AI-template hero. 대안: asymmetric single-column left-aligned, 60/40 primary+secondary, full-bleed cinematic, magazine spread.
- **3-up uniform feature grid** (icon + title + 2-line desc × 3) — AI-template 시그니처. 대안: asymmetric bento (1 dominant cell 2+ col + smaller cells with varied media — chart/illustration/metric/testimonial), single column with editorial flow, 또는 numbered article.
- **3-tier identical pricing card** — AI 시그니처. 대안: tier별 visual differentiation (Standard small / Scale large 강조 / Enterprise text-only), variable cell width, 또는 single-column comparison table.
- **Centered hero with stacked CTA pair** — AI default. 대안: asymmetric headline + side meta + single Primary CTA only.
- **`backdrop-filter: blur` on content cards** (glassmorphism) — 거의 항상 AI-template 시그널.

### D. Banned shadow / radius / micro-detail

- **`shadow-lg` / `shadow-xl` single drop** — 대신 3-layer shadow stack: `0 0 0 1px rgba(0,0,0,0.08)` (hairline ring) + `0 2px 2px rgba(0,0,0,0.04)` (soft drop) + `inset 0 0 0 1px #fafafa` (inner highlight). Hobday 2× rule 유지.
- **`rounded-2xl` (16px) 이상** on buttons/cards — 6-8px buttons, 8-12px cards 강제. Marketing CTA만 `100px pill` 허용 (예외).
- **Generic Lucide/Heroicons** without customization — DSP가 monoline stroke 1.5px 명시했으면 그것만. 컬러 아이콘·3D 아이콘·gradient stroke 절대 금지.

### E. Banned copy voice

- **"Move money, ship faster" / "The all-in-one platform for X" / "Built for modern teams" / "Powerful, simple, secure"** 같은 generic SaaS cliché — 절대 금지.
- 대안 copy patterns:
  - Brand-specific noun-metaphor + em-dash (예: Mercury "Banking — redesigned from the ground up")
  - Triple-imperative declarative (예: Vercel "Develop. Preview. Ship.")
  - Single-concept dramatic noun phrase (예: Stripe "Payments infrastructure for the internet")

### F. Banned motion

- **Fade-in only on scroll** (generic Framer Motion default) — 대안: weight-axis variable font transition on hover (400→510), scroll-driven typography reveal with `clip-path` mask, View Transitions API for route changes.
- **Bouncy spring / overshoot / elastic easing** — 항상 ease-out cubic-bezier 또는 narrow spring (damping 22-26, stiffness 280-320).
- **Parallax scroll-hijacking** — 절대 금지.

### G. Visual hook mandate (모든 marketing page 필수)

페이지에 다음 중 **정확히 하나만** 선택해서 적용:

1. **Gradient mesh art** (Stripe-style cream/orange/lavender 혼합) — 단 hue palette는 DSP가 명시한 brand color 안에서만
2. **Cinematic photography** (Mercury-style, single subject + dramatic lighting + atmospheric)
3. **3D card/product render** (Brex-style, Spline/R3F)
4. **Branded illustration system** (Ramp-style bento graphic system)
5. **Graphic tapestry** (Wise-style texture + color + imagery 합성)

**2개 이상 mix는 AI-template 시그널 → failure.** Visual hook 0개 (pure typography only) 은 editorial DSP (editorial-magazine, museum-cultural) 에서만 허용.

### H. Required craft signal (모든 DSP에 자동 부착)

- **Tabular-nums** on all numeric displays (counts, amounts, timers, dates, ratios, percentages)
- **Single accent strict ratio** — page surface 5-10%만 차지. 나머지는 ink + canvas + neutral grays
- **Sentence-case headlines** (Title Case 금지)
- **Mono eyebrow + sans headline pairing** — eyebrow는 11-12px monospace uppercase tracking 0.05em, 위에 placed
- **Asymmetric layout** — 모든 hero/section은 의도적 visual weight imbalance
- **Keyboard shortcut display in monospace badge** (`⌘ K`, `⌘ K to search`) — command-driven action에 강제

## 70% Negative + 30% Positive 원칙

DSP/SKILL 본문의 약 **70%가 banned 패턴 명시** (negative constraint) 이어야 LLM이 학습 median에서 벗어남. 30%만 positive spec. 사용자가 "AI 느낌 난다"고 평가하면 banned list가 부족한 것 — 더 구체적 negative constraint 추가.

## Motion Library 카탈로그 (글로벌 — v1.6.0 확장)

다음 라이브러리를 작업별로 분담. **anime.js + GSAP plugins 추가** (v1.6.0):

### GSAP plugin 카탈로그 (gsap.com/showcase 분석)

GSAP showcase의 award-winning 사이트들이 공통 사용하는 plugin:

| Plugin | 용도 | 사용 사례 |
|---|---|---|
| **ScrollTrigger** | scroll-driven trigger | 모든 award 사이트 — pin/scrub/timeline 연동 |
| **SplitText** | character / word / line split | 거의 모든 hero text reveal (3.13+ free) |
| **DrawSVG** | SVG path stroke animation 0→100% | DAVINCII, Arijaya Putra — vector logo reveal |
| **Flip** | element layout transition (FLIP technique) | ADA (thefirstthelast.agency) — layout swap |
| **CustomEase** | 정교한 cubic-bezier 또는 SVG-based easing | DAVINCII — brand-specific motion personality |
| **Draggable + Inertia** | drag interaction with physics | Hypefluency — interactive draggable cards |
| **MotionPath** | element를 SVG path 따라 이동 | Arijaya Putra — character가 path 따라 움직임 |
| **ScrollSmoother** | smooth scroll (Lenis 대안) | Škoda Vision Concept — single-page cinematic |

**GSAP plugin 사용 시 주의:** ScrollSmoother는 mobile에서 hijacking 위험 — Lenis와 동일하게 mobile auto-disable 권장.

### anime.js v4 (NEW)

15KB gzipped, MIT 라이센스, animejs.com 자체 데모. GSAP와 역할 분담:
- **anime.js**: SVG vector animation, lightweight timeline, financial visualization (transaction flow / settlement / chart morph), `svg.morphTo()`, `svg.createDrawable()`
- **GSAP**: scroll-triggered, complex timeline, SplitText, layout transition (Flip)

### Award-grade GSAP showcase reference (11개)

| Site | URL | 사용 plugin |
|---|---|---|
| Luke Baffait | https://www.lukebaffait.fr/ | ScrollTrigger |
| Apex | https://apex-psi-indol.vercel.app/ | SplitText |
| Škoda Vision Concept | https://vision.doanbao.com/ | ScrollTrigger + ScrollSmoother |
| Studio375 | https://375.studio/ | ScrollTrigger + SplitText |
| Maxima Therapy | https://maximatherapy.com/ | ScrollTrigger |
| Hypefluency | https://hypefluency.com/ | ScrollTrigger + Draggable + SplitText + Inertia |
| Arijaya Putra | https://arijayaputra.xyz/ | DrawSVG + MotionPath |
| Victor Furuya '26 | https://victorfuruya.com/ | ScrollTrigger + SplitText |
| DAVINCII | https://davincii.com/ | ScrollTrigger + DrawSVG + SplitText + CustomEase + ScrollTo |
| ADA | https://thefirstthelast.agency/ | ScrollTrigger + Flip + SplitText |
| Pacôme Pertant | http://pacomepertant.com/ | ScrollTrigger + SplitText |

위 사이트는 대부분 **portfolio / creative agency / branded campaign** 톤 — fintech-saas의 정밀 monochrome 톤과 다른 영역. 별도 DSP `agency-portfolio.md` (v1.6.0)에서 활용. fintech-saas 등 정밀 DSP는 이 사이트들의 plugin 사용 패턴만 참고하되 visual maximalism은 회피.

### anime.js / GSAP showcase mimicry 금지

- ❌ animejs.com의 거대한 multi-color SVG hero를 fintech-saas에 복사 → 톤 충돌
- ❌ DAVINCII의 dark brutalist 톤을 wellness-platform에 복사 → 톤 충돌
- ✅ **plugin 사용 패턴만 추출** — DrawSVG concept을 fintech의 transaction path animation에, SplitText를 모든 hero headline reveal에, Flip을 dashboard view 전환에

## Copy Voice & Headline Patterns (글로벌 — vault 메타 분석 통합)

> 출처: IntelliEffect vault `08-Resources/Marketing/랜딩페이지 레퍼런스/00-패턴 요약.md` (2026-02-08, 17개 글로벌+한국 사이트 분석)

### 7가지 헤드라인 공식 (UI 작업 시 1개 commit, generic SaaS 패턴 회피)

| 패턴 | 공식 | 예시 |
|---|---|---|
| **A. 카테고리 재정의** | `The [수식어] [새 카테고리] for/to [결과]` | "Financial infrastructure to grow your revenue" (Stripe), "The First AI-Native GTM Platform" (Copy.ai) |
| **B. 페르소나 격상** | `[제품] for [멋진 페르소나]` | "The AI for problem solvers" (Claude), "Powering the world's best product teams" (Linear) |
| **C. 선언/단언** | `[주제]의 미래는 [우리] 입니다` | "고객상담의 미래는 AI 입니다" (채널톡), "Make anything possible, all in Figma" |
| **D. 부정/파괴** | `Goodbye [기존]` / `No [하이프]. Just [결과].` | "Goodbye AI Copilots" (Copy.ai), "Death to boilerplate" (Retool), "No AI hype here" (Zapier) |
| **E. 통합/단순화** | `모든 [X]를 하나로` / `More [가치]. Fewer [비용].` | "모든 HR 데이터 flex 하나로", "More productivity. Fewer tools." (Notion) |
| **F. 행동 동사** | `[동사1] and [동사2] [목적어]` | "Build and deploy the best web experiences" (Vercel) |
| **G. 결과 수치** | `[결과 수치] [in/by] [기간]` (sub-headline에 권장) | "Cut onboarding time by 40%" |

### 8가지 카피 안티패턴 (사용 시 failure)

1. ❌ **모호한 헤드라인** — "혁신적인 솔루션", "최고의 플랫폼", "Built for modern teams"
2. ❌ **기능 나열형 features** — "실시간 분석 / 대시보드 / API 연동" 같은 모든 SaaS 공통어
3. ❌ **익명 인용문** — "A사 마케터", "한 고객" — 실명 + 직함 + 회사 + 구체 수치 필수
4. ❌ **"Learn more" CTA** — 행동 없음. "Get started", "Book a demo", "Start free"로
5. ❌ **홈페이지 = 랜딩페이지 착각** — nav 가득 + 블로그 링크. 랜딩은 단일 CTA 경로
6. ❌ **경쟁사 직접 비교** — "X보다 좋습니다" 소송 리스크. 카테고리 부정 ("Goodbye [카테고리]") 으로
7. ❌ **너무 많은 선택지** — CTA 5개, nav 메뉴 10개. Primary 1 + Secondary 1 (최대 2)
8. ❌ **느린 로딩** — Hero LCP > 3초. 목표 LCP ≤ 2.5s, lazy loading, 이미지 압축

### 한국어 vs 영어 카피 차이 (한국 시장 DSP 강제)

| 요소 | 영어 | 한국어 |
|---|---|---|
| 헤드라인 길이 | 5-8 words | 10-15자 |
| 종결어미 | 없음 (명사구) | "~입니다" 선언, "~하세요" 청유, "~해보셨나요?" 질문 |
| CTA | "Get started" | "시작하기" > "가입하기" / "무료 체험하기" > "무료 체험" / "상담 신청" > "문의하기" |
| 수치 표현 | $1.4T, 99.999% | "80.9%", "1분 만에", "224,221개 기업" |
| Social proof | 로고 + 이름만 | 실명 + 소속 + 직급 + 파트 (예: "윤천상, 부스터스 CX 파트 리드") |
| 보안 인증 | SOC 2, GDPR | ISMS, ISO + 한국 인증 |
| 어조 | Casual, Direct | 존댓말 기반, formal |
| 대구법 | 드물게 | 핵심 기법 ("간편하게 / 정확하게") |
| "무료" 강조 | "Free" 부차적 | "무료", "평생 무료" 매우 중요 |

### 섹션 순서 BP (마케팅 페이지)

**표준 구조:**
```
Hero → Logo Wall → Problem/Value → Solution → Features (3-6) → Customer Stories → Security/Trust → Final CTA
```

**AI 서비스 특화:**
```
Hero (AI 비전) → Logo Wall → AI Capabilities (데모) → Use Cases by Persona → ROI 수치 + Stories → Security/Compliance → Pricing/Demo CTA
```

**한국 시장 특화:**
```
Hero (한국어 선언형) → 핵심 수치 (구체적, 소수점) → 제품 기능 (시나리오형) → 고객 사례 (실명+소속+직급) → 보안 인증 (ISMS, ISO) → 가격/도입 문의 CTA
```

### CTA 위치 패턴 (모든 페이지에 적용)

1. **Hero CTA** — 100% 필수, 스크롤 없이 보이는 위치
2. **중간 CTA** — 3-4 섹션마다 반복 (Zapier/Stripe 스타일)
3. **Final CTA** — 페이지 하단에 전용 섹션 (전체의 ~80%가 사용)

### Social Proof 배치 전략

- **로고월**: 5-8개 (clutter 회피), Hero 바로 아래
- **수치형**: 다각적 (사용자 수 + 거래량 + 자동화 성과 + 만족도 + G2 ranking). 반올림 안 한 수치가 더 신뢰 (80.9% > 81%)
- **인용문**: 이름 + 직함 + 회사 + 구체 결과 (금액 인용이 최강: "$16M saved")
- **실시간 데이터**: Vercel AI 랭킹 / Zapier 자동화 카운터 — 활성도 증명

### AI 에이전시 vs SaaS 패턴 차이 (corporate-b2b · IntelliEffect-specific)

| 요소 | SaaS 제품사 | AI 에이전시 |
|---|---|---|
| Hero | 제품 기능/가치 | 신뢰 + 결과 + 전문성 |
| 핵심 증거 | 무료 체험, 데모 | 포트폴리오, 고객 인용, 실적 수치 |
| CTA | "Start free" | "상담 신청", "프로젝트 의뢰" |
| 가격 | 공개 (투명성) | 프로젝트별 (맞춤형) |
| 신뢰 장치 | 사용자 수, 실시간 | 고객사 로고, C레벨 인용, 인증 |
| 경쟁 우위 | 기능/UX/가격 | 팀 전문성/프로세스/커뮤니케이션 |

**에이전시 Hero 카피 안티패턴:** "혁신적인", "창의적인", "최고의" 같은 빈 수식어 — 모두 banned.

**에이전시 추가 섹션:** Engagement Model (PoC → MVP → 유지보수 / Hourly · Part-time · Full-time / Dedicated · Extension · Project-based)

## DSP 카탈로그

### Web (12)

| Slug | Domain | Reference 톤 | Path |
|---|---|---|---|
| `wellness-platform` | Personalized Health & Wellness | 라이트 그레이 + 라임 그린 accent | `prompts/design/web/wellness-platform.md` |
| `fintech-saas` | B2B Financial SaaS | Stripe/Mercury/Brex 정밀 monochrome | `prompts/design/web/fintech-saas.md` |
| `corporate-b2b` | Enterprise / Consulting / AI services | Vercel/Anthropic editorial 절제 | `prompts/design/web/corporate-b2b.md` |
| `ecommerce-luxury` | Premium / Niche e-commerce | Aesop/MR PORTER atelier 톤 | `prompts/design/web/ecommerce-luxury.md` |
| `editorial-magazine` | 디지털 매거진 / 인쇄 magazine 웹 에디션 | Apartamento/Cabana/데이즈드코리아 print-derived | `prompts/design/web/editorial-magazine.md` |
| `education-edtech` | EdTech / 학습 플랫폼 | Duolingo/Coursera friendly + 한국 EdTech | `prompts/design/web/education-edtech.md` |
| `real-estate-kr` | 한국 부동산 / 분양 마케팅 | 코오롱 하늘채/블랑써밋 cinematic | `prompts/design/web/real-estate-kr.md` |
| `kbeauty-cosmetics` | K-beauty / Korean cosmetics | 동국제약 마데키엘/조선미녀/닥터자르트 soft warm photographic | `prompts/design/web/kbeauty-cosmetics.md` |
| `kpop-entertainment` | K-pop artist / entertainment platform | HYBE/SM/YG/Weverse 빅히트뮤직 bold cinematic dark | `prompts/design/web/kpop-entertainment.md` |
| `medical-clinic` | Premium clinic / 의원 / 펫의료 | 뷰웰의원/가까이한의원/픽케어 trustworthy wellness-adjacent | `prompts/design/web/medical-clinic.md` |
| `museum-cultural` | 박물관 / 디지털 역사관 / anniversary | 퐁피두센터 한화/대구대 70주년/SP삼화 100년 archival editorial | `prompts/design/web/museum-cultural.md` |
| `automotive-mobility` | 자동차 / EV / 모빌리티 brand | 그린카/HM그룹/현대/Tesla/Polestar precision-engineered | `prompts/design/web/automotive-mobility.md` |

### Mobile (8)

| Slug | Domain | Reference 톤 | Path |
|---|---|---|---|
| `fitness-app` | Fitness / Workout tracking | Strava/Whoop kinetic dark | `prompts/design/mobile/fitness-app.md` |
| `wellness-app` | Wellness / Meditation / Sleep | Calm/Headspace contemplative | `prompts/design/mobile/wellness-app.md` |
| `fintech-app` | Banking / Investment | Toss/KakaoBank/Wise transaction-first | `prompts/design/mobile/fintech-app.md` |
| `content-streaming` | Music / Video streaming | Spotify/Apple Music immersive | `prompts/design/mobile/content-streaming.md` |
| `productivity-app` | Tasks / Notes | Things/Linear/Bear focused minimal | `prompts/design/mobile/productivity-app.md` |
| `insurance-mobile` | 한국 보험 모바일 가입·관리 | 삼성화재 CM/AXA/한화자산운용/KB국민카드 transaction-confidence | `prompts/design/mobile/insurance-mobile.md` |
| `ecommerce-mobile-kr` | 한국 대형 유통 mobile commerce | 롯데하이마트/더현대Hi/무신사/29CM/마켓컬리 product-photo-driven | `prompts/design/mobile/ecommerce-mobile-kr.md` |
| `fnb-membership` | F&B 멤버십 / 사이렌오더 카페·베이커리 | 이디야멤버스/영커피/스타벅스/메가커피 warm hospitality | `prompts/design/mobile/fnb-membership.md` |

## Activation Flow (사용자 요청 → 코드 출력)

```
1. 사용자 요청 도메인 매칭
   - "pricing page Linear 톤" → corporate-b2b 또는 fintech-saas
   - "한국 아파트 분양 사이트" → real-estate-kr
   - "운동 트래커 모바일 앱" → fitness-app
   - "AI consulting 회사 hero" → corporate-b2b
   - 매칭 안 됨 → 사용자에게 가장 가까운 후보 2-3개 제시 + 선택 받기

2. 매칭 DSP 인용
   - Claude Code 환경: Task tool로 designer agent 위임
     subagent_type: "designer"
     spec body:
       "DSP @<repo-path>/prompts/design/<web|mobile>/<slug>.md verbatim 적용
        타겟: <file paths>
        Iteration: screenshot 최소 2 라운드
        [추가 컨텍스트]"
   - 그 외 환경 (Cursor, Codex, Gemini 등):
     DSP 본문을 inline으로 prompt에 박은 뒤 verbatim 적용 + iteration 직접 실행

3. 결과 검증
   - DSP token compliance 체크 (color hex, radius, shadow, typo)
   - AI-generic banned 패턴 grep
   - Screenshot 시각 비교
   - 2+ 라운드 critique → targeted edit
```

## Override / 확장 패턴

### 매칭 DSP가 없을 때

`prompts/design/_template.md` 양식으로 즉석 DSP 작성:
- Section 1 — Design System Definition (color/typo/radius/shadow/icon)
- Section 2 — Layout & Structure
- Section 3 — UI Elements & Animation
- Section 4 — Consistency Mandate (banned patterns)

작성한 inline DSP는 작업 후 PR로 `prompts/design/<web|mobile>/` 에 추가 권장 — 다음 사용자가 재활용.

### 명시적 톤 override

사용자가 "wellness 도메인이지만 brutalist 톤" 같은 hybrid 요청 시:
- Primary DSP 선택 (예: `wellness-platform`)
- Override section만 사용자 prompt에 명시 ("color는 라이트 그레이 유지, layout/typography는 brutalist 톤 적용")
- designer agent가 두 DSP 간 conflict resolve

## 의존성 (권장 설치)

```bash
# 1. 본 plugin
claude plugin marketplace add intelli-ddd/intellieffect-design-system
claude plugin install intellieffect-design@intellieffect-design-system

# 2. base aesthetic guardrail (강력 권장)
claude plugin install frontend-design@claude-plugins-official

# 3. designer agent의 iteration loop (선택)
# Playwright MCP server 설정 — claude_desktop_config.json 또는 mcp.json에 추가
```

## 새 DSP 기여

1. `prompts/design/_template.md` 복사
2. 4 section 채우기 — 모든 token, banned pattern 명시
3. PR 제출 — AGENTS.md의 checklist 통과 검증
4. Merge 후 `git pull`로 팀 전체 반영

## Designer agent 직접 호출 (Claude Code 한정)

본 skill 자동 트리거 외에, 사용자가 명시적으로 designer agent를 호출할 수도 있음:

```
Task tool
  subagent_type: "designer"
  description: "<짧은 description>"
  prompt:
    """
    # TASK
    DSP @~/.claude/prompts/design/<web|mobile>/<slug>.md verbatim 적용

    # EXPECTED / CONTEXT / CONSTRAINTS / MUST DO / MUST NOT / OUTPUT
    [...]
    """
```

Designer agent는 `~/.claude/agents/designer.md` 에 정의됨 (본 repo install.sh 또는 plugin install이 ~/.claude/agents/ 로 symlink).

## Section 8 — Implementation Guardrails (5 카테고리 trap)

DSP 의 abstract tone 룰 (색·폰트·radius·motion 라이브러리) 만으로 prevent 안 되는 **구현 레벨 code trap** 5 카테고리. designer agent 가 pre-commit 시점에 반드시 grep audit.

**Source of truth**: `~/.claude/prompts/design/_guardrails.md` (verbatim 코드 예시 + grep audit 명령 카탈로그). 본 섹션은 요약 + 인덱스.

### Category A — Text overflow (italic + SplitText)

- Trap: SplitText word wrapper `.word-wrap { overflow: hidden }` 가 italic / weight≥700 / tight tracking 글립의 우측 클리핑
- MUST USE: `clip-path: inset(-0.15em -0.4em 0 -0.4em)` + italic span 에 `padding-right: 0.06em`
- MUST NOT: `overflow: hidden` on SplitText word wrappers with italic/heavy content
- Audit: `grep -rnE "\.(word|char|line)-wrap[^{]*\{[^}]*overflow:\s*hidden"`

### Category B — useGSAP scope rules

- Trap: `useGSAP({ scope: ref })` 안 string CSS selector 는 scope descendant 만 매치 → 외부 element silent fail
- MUST USE: 외부 element 는 `document.querySelector` 로 ref 받아 직접 전달
- MUST NOT: 외부 element 를 string selector 로 `gsap.to / ScrollTrigger.batch / gsap.utils.toArray` 전달
- Audit: `useGSAP scope` 있는 파일에서 `gsap.to("#...")` 패턴 grep

### Category C — Motion stacking conflicts

- Trap: 같은 wrapper 에 anime.js infinite loop + GSAP scroll-tied rotation stack → 라벨 누움 + drift
- MUST USE: 한 element 당 한 transform-source, 또는 label 을 non-rotating sibling 으로 분리, 또는 counter-rotation
- MUST NOT: `<div ref={animeTarget}><svg/><span>LABEL</span></div>` + 같은 ref 에 GSAP rotation
- Audit: `svg.morphTo / createTimeline` 있는 파일에 `gsap.*rotation` 동시 등장 grep

### Category D — Decorative absolute positioning

- Trap: `position: absolute` + GSAP rotation 시 transform-origin default (center) → scale 동반 drift
- MUST USE: `transformOrigin: "50% 50%"` 명시. 위치는 CSS top/right, transform 은 GSAP — 책임 분리
- MUST NOT: GSAP transform 으로 x/y 위치까지 잡기
- Audit: `gsap.*rotation` 라인 ±5 줄 내 `transformOrigin` 누락 검출

### Category E — prefers-reduced-motion full audit

- Trap: JS gate (`useReducedMotion()`) 만 박고 CSS `@media (prefers-reduced-motion: reduce)` 누락 (또는 반대)
- MUST USE: 두 layer 모두 작성 — JS 로 timeline init skip + CSS 로 모든 transition/animation 0.01ms clamp
- MUST NOT: 한쪽만 박기
- Audit: `useReducedMotion` 있는 파일에 `prefers-reduced-motion` 누락 검출

### Pre-commit audit checklist

designer agent 가 코드 생성 완료 후 다음 5 명령 모두 실행, 결과를 리포트에 verbatim 박는다:

```bash
# A. Text overflow
grep -rnE "\.(word|char|line)-wrap[^{]*\{[^}]*overflow:\s*hidden" <project>/app <project>/components

# B. useGSAP scope (수동 확인 필요)
grep -lE "useGSAP\([^,]+,\s*\{\s*scope:" <project>/app | while read f; do
  echo "=== $f ==="
  grep -nE "gsap\.(to|from|fromTo|set)\(\"[#.]|ScrollTrigger\.batch\(\"[#.]" "$f"
done

# C. Motion stacking
grep -lE "svg\.morphTo|createTimeline" <project>/app | while read f; do
  if grep -qE "gsap\.(to|from|fromTo).*rotation" "$f"; then
    echo "POTENTIAL STACK CONFLICT: $f"
    grep -nE "svg\.morphTo|gsap\.(to|fromTo).*rotation" "$f"
  fi
done

# D. transformOrigin 누락
grep -rnE "gsap\.(to|fromTo)\([^)]*rotation" <project>/app -A 5 | grep -B 1 "rotation" | grep -v "transformOrigin" | grep "rotation"

# E. reduced-motion 한쪽 누락
grep -lE "useReducedMotion\(\)" <project>/app | xargs grep -L "prefers-reduced-motion"
```

0 매치 또는 모두 의도된 예외 (inline 주석으로 사유 명시) 가 있어야 작업 완료. 매치 있고 사유 없으면 fix 또는 surface as Open question.

---

## Anti-pattern (이 skill 호출 후 발생 시 failure)

- DSP token 변경 ("좀 더 밝게", "round 더 크게" 같은 자체 판단)
- 매칭 DSP 무시하고 자체 design 시도
- Single-shot 후 종료 (screenshot iteration 누락)
- DSP의 banned patterns 등장 (purple/violet gradient, glassmorphism, AI-generic Inter-only 등)
- 다른 plugin (특히 frontend-design)과 충돌하는 룰 강제 — 본 skill은 wrapper, 충돌 시 frontend-design이 우선

## 참고 — 본 skill의 origin

본 skill은 IntelliEffect 팀이 내부적으로 사용하는 design system을 외부 wrapper로 packaging한 것. 12개 DSP는 사용자가 처음 제시한 wellness-platform 예시 + 지디웹 수상작 + Stripe/Linear/Vercel/Aesop 등 글로벌 reference + 한국 시장 (real-estate-kr) 을 모두 포괄한 카탈로그. 새 도메인은 contributor가 `_template.md` 따라 추가.

---
name: intellieffect-design
description: >
  AUTO-TRIGGER on any UI/UX design request — React/Next.js component, hero section, landing page, marketing site, pricing page, dashboard, mobile app screen, Tailwind theme/@theme block, Motion/GSAP animation, shadcn install/customization, or any task that ends with a renderable interface.

  IntelliEffect 팀 design system wrapper. 사용자 요청 도메인을 12 DSP (Design System Prompt) 카탈로그에서 매칭한 뒤, **그 DSP를 verbatim 적용**하여 코드 생성. AI-generic UI defaults 회피 + 회사 일관 톤 확보.

  Web DSP (7): wellness-platform, fintech-saas, corporate-b2b, ecommerce-luxury, editorial-magazine, education-edtech, real-estate-kr.
  Mobile DSP (5): fitness-app, wellness-app, fintech-app, content-streaming, productivity-app.

  Activation flow: (1) 사용자 요청에서 도메인 키워드 추출 (예: "pricing page" + "Linear 톤" → fintech-saas 또는 corporate-b2b), (2) 매칭 DSP 파일 경로 명시 (`@plugin's prompts/design/<web|mobile>/<slug>.md`), (3) Claude Code 환경이면 designer agent 위임 (Task tool `subagent_type: "designer"`) — 그 외 환경이면 DSP inline verbatim 적용 + iteration loop 직접 실행.

  Override DSP 가능 — 사용자가 명시적으로 "Linear 톤", "Aesop 톤", "한국 매거진 톤" 같은 키워드 박으면 그 톤이 매칭되는 DSP 우선. 매칭되는 DSP가 없으면 가장 가까운 reference + `_template.md` 기반 inline DSP 즉석 생성.
license: MIT
metadata:
  version: "1.0.0"
  author: IntelliEffect
  upstream: frontend-design@claude-plugins-official (recommended dependency)
---

# IntelliEffect Design System

**이 skill은 IntelliEffect 팀의 UI 디자인 작업에 자동 적용된다.** 사용자가 UI/디자인 관련 요청을 하면 이 skill이 활성화되어, 12개 DSP 카탈로그에서 도메인 매칭 후 verbatim 적용한다.

## 핵심 룰 (모든 UI 작업에 강제)

1. **DSP verbatim 적용** — 매칭된 DSP의 color hex, radius, shadow token, typography family를 한 글자도 변경 금지
2. **AI-generic 패턴 명시 배제** — 각 DSP의 "Banned patterns" 섹션을 코드에 적용 전 grep으로 검증
3. **Single accent commit** — DSP가 multi-color 정의 안 한 이상 페이지당 1개 accent
4. **Single-shot 금지** — 코드 생성 후 screenshot iteration 최소 2 라운드 (renderable component에 한해)
5. **frontend-design plugin 활용** — 설치되어 있으면 base aesthetic guardrail로 활용. 없어도 본 skill 자체가 충분한 design context 제공.

## DSP 카탈로그

### Web (7)

| Slug | Domain | Reference 톤 | Path |
|---|---|---|---|
| `wellness-platform` | Personalized Health & Wellness | 라이트 그레이 + 라임 그린 accent | `prompts/design/web/wellness-platform.md` |
| `fintech-saas` | B2B Financial SaaS | Stripe/Mercury/Brex 정밀 monochrome | `prompts/design/web/fintech-saas.md` |
| `corporate-b2b` | Enterprise / Consulting / AI services | Vercel/Anthropic editorial 절제 | `prompts/design/web/corporate-b2b.md` |
| `ecommerce-luxury` | Premium / Niche e-commerce | Aesop/MR PORTER atelier 톤 | `prompts/design/web/ecommerce-luxury.md` |
| `editorial-magazine` | 디지털 매거진 / 인쇄 magazine 웹 에디션 | Apartamento/Cabana print-derived | `prompts/design/web/editorial-magazine.md` |
| `education-edtech` | EdTech / 학습 플랫폼 | Duolingo/Coursera friendly + 한국 EdTech | `prompts/design/web/education-edtech.md` |
| `real-estate-kr` | 한국 부동산 / 분양 마케팅 | 코오롱 하늘채/블랑써밋 cinematic | `prompts/design/web/real-estate-kr.md` |

### Mobile (5)

| Slug | Domain | Reference 톤 | Path |
|---|---|---|---|
| `fitness-app` | Fitness / Workout tracking | Strava/Whoop kinetic dark | `prompts/design/mobile/fitness-app.md` |
| `wellness-app` | Wellness / Meditation / Sleep | Calm/Headspace contemplative | `prompts/design/mobile/wellness-app.md` |
| `fintech-app` | Banking / Investment | Toss/KakaoBank/Wise transaction-first | `prompts/design/mobile/fintech-app.md` |
| `content-streaming` | Music / Video streaming | Spotify/Apple Music immersive | `prompts/design/mobile/content-streaming.md` |
| `productivity-app` | Tasks / Notes | Things/Linear/Bear focused minimal | `prompts/design/mobile/productivity-app.md` |

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

## Anti-pattern (이 skill 호출 후 발생 시 failure)

- DSP token 변경 ("좀 더 밝게", "round 더 크게" 같은 자체 판단)
- 매칭 DSP 무시하고 자체 design 시도
- Single-shot 후 종료 (screenshot iteration 누락)
- DSP의 banned patterns 등장 (purple/violet gradient, glassmorphism, AI-generic Inter-only 등)
- 다른 plugin (특히 frontend-design)과 충돌하는 룰 강제 — 본 skill은 wrapper, 충돌 시 frontend-design이 우선

## 참고 — 본 skill의 origin

본 skill은 IntelliEffect 팀이 내부적으로 사용하는 design system을 외부 wrapper로 packaging한 것. 12개 DSP는 사용자가 처음 제시한 wellness-platform 예시 + 지디웹 수상작 + Stripe/Linear/Vercel/Aesop 등 글로벌 reference + 한국 시장 (real-estate-kr) 을 모두 포괄한 카탈로그. 새 도메인은 contributor가 `_template.md` 따라 추가.

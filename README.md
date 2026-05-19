# intellieffect-design-system

IntelliEffect 팀 내부 Design System Prompt (DSP) 카탈로그 + designer agent.

웹·앱 UI 코드를 LLM(Claude · Gemini · Cursor 등)에 위임할 때, **각 도메인·톤별로 매우 구체적인 Design System Definition을 강제하는 prompt 라이브러리**를 제공한다. AI-generic UI 회피 + 일관된 회사 디자인 voice 확보가 목적.

## 무엇이 들어있나

- **1 agent**: `agents/designer.md` — coder agent와 mirror된 design-task delegate. DSP를 spec으로 받아 코드 생성 + screenshot iteration loop 자동 실행.
- **20 DSP**: `prompts/design/{web,mobile}/<domain>.md` — 각각 4 sections (Design System Definition / Layout & Structure / UI Elements & Animation / Consistency Mandate) + AI-generic banned 패턴 명시.
- **1 template**: `prompts/design/_template.md` — 새 DSP 작성 양식.

### Web DSP (12개)

| Slug | Domain | Reference |
|---|---|---|
| `wellness-platform` | Personalized Health & Wellness | (IntelliEffect 자체 예시) |
| `fintech-saas` | B2B Financial SaaS | Stripe, Mercury, Brex, Ramp, Linear |
| `corporate-b2b` | Enterprise / Consulting / AI Services | Vercel, Notion, Anthropic, IBM Carbon |
| `ecommerce-luxury` | Premium / Niche e-commerce | Aesop, MR PORTER, Hermès, COS |
| `editorial-magazine` | 디지털 매거진 / 인쇄 magazine 웹 에디션 | Apartamento, Cabana, MAGAZINE B, 데이즈드코리아 |
| `education-edtech` | EdTech / 학습 플랫폼 | Duolingo, Coursera, 천재교과서 |
| `real-estate-kr` | 한국 부동산 / 분양 마케팅 | 코오롱 하늘채, 대우건설 블랑써밋 (지디웹 수상작) |
| `kbeauty-cosmetics` | K-beauty / Korean cosmetics | 동국제약 마데키엘, 멜로우앤코, 조선미녀, 닥터자르트, 라네즈 (지디웹 2026) |
| `kpop-entertainment` | K-pop entertainment / artist platform | HYBE, SM, YG, JYP, Weverse, 빅히트뮤직 (지디웹 2026) |
| `medical-clinic` | Premium medical clinic / 의원 / 펫의료 | 뷰웰의원, 가까이한의원, 픽케어, 압구정 피부과 (지디웹 2026) |
| `museum-cultural` | 박물관 / 디지털 역사관 / anniversary marketing | 퐁피두센터 한화, 대구대학교 70주년, SP삼화 100년 동행 (지디웹 2026) |
| `automotive-mobility` | 자동차 / EV / 모빌리티 brand | 그린카, HM그룹, 현대, 기아, Tesla, Polestar (지디웹 2026) |

### Mobile DSP (8개)

| Slug | Domain | Reference |
|---|---|---|
| `fitness-app` | Fitness / Workout tracking | Strava, Whoop, Apple Fitness+ |
| `wellness-app` | Wellness / Meditation / Sleep | Calm, Headspace, Oura |
| `fintech-app` | Banking / Investment | Toss, KakaoBank, Wise, Revolut |
| `content-streaming` | Music / Video streaming | Spotify, Apple Music, Netflix, 멜론 |
| `productivity-app` | Tasks / Notes | Notion mobile, Linear mobile, Things 3 |
| `insurance-mobile` | 한국 보험 모바일 가입·관리 | 삼성화재 CM, AXA손해보험, 한화자산운용, KB국민카드, 롯데카드 (지디웹 2026) |
| `ecommerce-mobile-kr` | 한국 대형 유통 mobile commerce | 롯데하이마트, 더현대Hi, 무신사, 29CM, 마켓컬리 (지디웹 2026) |
| `fnb-membership` | F&B 멤버십 / 카페·베이커리 (사이렌오더 패턴) | 이디야멤버스, 영커피, 스타벅스 사이렌오더, 메가커피 (지디웹 2026) |

## Installation — 두 가지 path 중 선택

### Path A — Claude Code Plugin (Recommended)

자동 트리거 skill. UI 디자인 요청 시 description match로 자동 활성화. **팀원이 가장 적은 마찰로 사용 가능.**

```bash
# 1. 본 plugin (자동 트리거 skill + designer agent)
claude plugin marketplace add intelli-ddd/intellieffect-design-system
claude plugin install intellieffect-design@intellieffect-design-system

# 2. base aesthetic guardrail (강력 권장)
claude plugin install frontend-design@claude-plugins-official
```

새 Claude Code 세션부터 자동 작동. UI 작업 요청 시 `intellieffect-design` skill이 description match로 활성화되며, DSP 카탈로그 안내 + designer agent 위임 패턴이 컨텍스트에 inject됨.

### Path B — Manual symlink (Cursor/Codex 등 non-Claude-Code 환경 또는 dotfiles 패턴 선호)

```bash
gh repo clone intelli-ddd/intellieffect-design-system
cd intellieffect-design-system
./install.sh
```

`install.sh`가 하는 일:
- `~/.claude/agents/designer.md` → 이 repo의 `agents/designer.md` symlink
- `~/.claude/prompts/design` → 이 repo의 `prompts/design` symlink

기존 파일이 있으면 `.removed_<timestamp>` 접미사로 보존 (rm 대신 mv — file-safety rule).

**중요:** 두 path 중 어느 쪽을 선택하든 설치 후 **Claude Code 세션 재시작** 필요 — agent / skill registry는 세션 시작 시점에 캐싱됨.

### 두 path의 차이

| | Path A (Plugin) | Path B (Manual symlink) |
|---|---|---|
| 자동 트리거 | ✅ description match로 활성화 | ❌ 명시적 호출 필요 |
| Claude Code 외 환경 | designer agent는 Claude Code 한정. DSP markdown은 어디서든 portable. | DSP markdown은 어디서든 portable. designer agent도 마찬가지. |
| 업데이트 | `claude plugin marketplace update` 한 줄 | `git pull` |
| 권장 사용자 | Claude Code 위주 팀원 | dotfiles 패턴 / 여러 IDE 혼용 팀원 |

두 path를 **동시에 적용해도 무방** — plugin은 skill 자동 트리거 제공, manual symlink는 `~/.claude/agents/designer.md` + `~/.claude/prompts/design/` 직접 접근 경로 확보.

## 의존성 (선택 설치)

- **`frontend-design@claude-plugins-official`** (강력 권장) — base aesthetic guardrail. 본 plugin은 그 위에 IntelliEffect token 강제하는 wrapper로 작동.
- **Playwright MCP server** (designer agent의 iteration loop 사용 시 필요) — `claude_desktop_config.json` 또는 `.mcp.json`에 `@playwright/mcp` 설정.

## 사용 패턴

```
사용자: "wellness platform hero 짜줘"

메인 (Opus) → designer agent 위임:
  subagent_type: "designer"
  spec body:
    """
    # TASK
    DSP @~/.claude/prompts/design/web/wellness-platform.md verbatim 적용
    
    # EXPECTED
    - app/wellness/page.tsx + app/wellness/_hero.tsx 생성
    - DSP Section 1-4 모든 token 정확히 적용
    - Desktop + Mobile screenshot 캡처
    - Iteration loop 최소 2 라운드
    
    # CONTEXT
    - Next.js 14 + Tailwind v4 + TypeScript
    - cva + tailwind-merge + clsx 설치됨
    
    # MUST DO / MUST NOT / OUTPUT
    [...]
    """

designer (Sonnet):
  1. DSP Read
  2. frontend-design skill 자동 활성화
  3. 코드 작성 → dev server → Playwright screenshot
  4. Critique (overlap, 토큰 drift, mobile overflow 등) → targeted edit
  5. 3-5 라운드 iteration 후 최종 보고
```

## 새 DSP 추가

```bash
# 1. template 복사
cp prompts/design/_template.md prompts/design/web/<your-slug>.md

# 2. 4 section 채우기:
#    - Design System Definition (color hex, typo, radius, shadow, icon)
#    - Layout & Structure (페이지 type별 grid·column·breakpoint)
#    - UI Elements & Animation (button variants, library, motion specs)
#    - Consistency Mandate (banned 패턴 명시)

# 3. commit + push
git add prompts/design/web/<your-slug>.md
git commit -m "Add DSP: <your-slug>"
git push
```

팀원은 `cd ~/intellieffect-design-system && git pull` 한 줄로 반영.

## 디자인 원칙 (모든 DSP에 공통)

1. **Token verbatim** — DSP에 명시된 color hex / radius / shadow / typo는 한 글자도 변경 금지
2. **Single accent commit** — 페이지당 1개 accent. 사용 후 추가 금지
3. **AI-generic 패턴 명시 배제** — 각 DSP의 "Banned patterns" 섹션 verbatim 따름
4. **Iteration loop** — 단일 generation 금지. 코드 → screenshot → critique → 수정 사이클
5. **2× shadow rule** — Hobday rule (blur = 2× distance)
6. **`prefers-reduced-motion` respect** — 모든 animation은 fallback 정의

## 의존 plugin

이 시스템은 `frontend-design@claude-plugins-official` (Anthropic 공식 plugin)을 base aesthetic guardrail로 활용한다. DSP는 그 위에 도메인별 token을 강제하는 layer.

설치 안 됐다면:
```bash
claude plugin install frontend-design@claude-plugins-official
```

## License

MIT. IntelliEffect 팀 내부 자산으로 시작했으나, DSP 자체는 공개해도 무방한 design system documentation.

## Contributing

See [AGENTS.md](./AGENTS.md) for new DSP authoring guidelines + review checklist.

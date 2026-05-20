---
name: media-generation-prompts
description: 모든 DSP가 reference하는 image·video 생성 프롬프트 카탈로그 — DSP-specific 톤 디스크립터 + format preset (16:9 hero / 4:3 cover / 1:1 social / 9:16 vertical) + provider matrix (gpt-image-1, Midjourney v7, Veo 3, Sora, Runway Gen-4). designer agent 가 코드 생성 시 placeholder 패턴 자리에 실제 prompt 매핑 의무.
version: v1.8.0
---

# Media Generation Prompts

DSP의 UI 코드 출력 외에 hero imagery·project cover·case-study video 같은 시각 자산 생성을 위한 prompt catalog. designer agent 는 코드의 placeholder (CSS pattern / aspect-ratio div) 위치마다 해당 DSP 의 media prompt 가 박혀있는지 확인하고, prompt 없으면 surface as Open question.

본 카탈로그는 다음 3축의 카르테시안 곱으로 구성:
1. **Style descriptor** — DSP 톤 (brutalist / soft-organic / kbeauty-studio / cinematic-dark 등)
2. **Format preset** — 용도별 비율·해상도 (hero 16:9 / cover 4:3 / social 1:1 / vertical 9:16)
3. **Provider matrix** — image 즉시 generation (gpt-image-1) / image 고품질 (Midjourney v7) / video (Veo 3 / Sora / Runway Gen-4)

---

## Style descriptor 라이브러리

각 DSP 가 본문에서 자신의 style descriptor 를 import.

### A. Brutalist cinematic dark (agency-portfolio, editorial-magazine 일부)

```
Tone: brutalist editorial, cinematic dark composition, raw concrete or matte
black surfaces, single coral or amber accent light. Hairline grid faintly
visible. Heavy negative space. Print-grade typography intersecting frame
edges. No people unless silhouette. No lifestyle smiles. No stock-photo
brightness. Mood: post-industrial, contemplative, intentional.

Lighting: single hard direction light, deep shadows, color temperature
3200K-3800K. Avoid soft beauty light.

Color: oklch(0.10 0.004 250) background, oklch(0.97 0.004 250) primary
detail, single accent — oklch(0.68 0.22 28) coral. Monochrome 90%.
```

### B. Soft organic wellness (wellness-platform, wellness-app)

```
Tone: warm natural light, organic textures (linen, raw ceramic, oak wood
grain), botanical fragments out of focus. Human presence as hands or back
shoulder — never full face direct. Mood: morning ritual, slow, embodied.

Lighting: large window soft light, 5500K, gentle falloff into shadow.
No harsh shadow.

Color: oklch(0.96 0.012 80) cream background, oklch(0.42 0.06 145) sage
green accent. Earth palette only — no neon, no pure white, no jewel tone.
```

### C. K-Beauty studio (kbeauty-cosmetics)

```
Tone: high-key studio product photography, glossy ceramic dewy skin
texture, water droplets on petal, glass-walled compact products. Soft
gradient backdrop pink-to-cream. Mood: clean, indulgent, K-aesthetic.

Lighting: large softbox + fill card, 6000K, beauty dish on subject.
Reflections in product face.

Color: oklch(0.94 0.02 20) blush pink background, oklch(0.18 0.01 250)
deep brand label accent. Avoid yellow undertone in skin.
```

### D. K-Pop entertainment vibrant (kpop-entertainment)

```
Tone: maximalist vibrant pop, neon-on-black or color-block, member group
arrangement with intentional asymmetry. Mood: idol-tier energy, motion
blur on extremities, choreography mid-frame.

Lighting: stage performance lighting, multi-color washes, lens flare
allowed. Edge-light separation on hair.

Color: 3-color palette per group identity (e.g., black + magenta + cyan).
Saturated, not desaturated. No filter-soft pastel.
```

### E. Editorial magazine (editorial-magazine, museum-cultural)

```
Tone: archival magazine spread, art-directed still life or environmental
portrait, generous gutter, Swiss-grid composition. Mood: considered,
sophisticated, slow-read.

Lighting: window or studio softbox at 45°, 5000K, deliberate shadow
geometry.

Color: muted palette from subject. No over-saturation. Print-paper
warmth preferred.
```

### F. Fintech/SaaS clean (fintech-saas, productivity-app)

```
Tone: clean product UI screenshot with subtle 3D environment, fintech
gradient surfaces, glass card + soft shadow on light grey backdrop, or
dashboard hero on warm white. Mood: trustworthy, sharp, modern.

Lighting: studio softbox 5500K + edge highlight. No drama.

Color: oklch(0.99 0.002 80) warm white background, oklch(0.38 0.18 260)
deep navy accent, oklch(0.62 0.18 28) optional warm tertiary.
```

### G. Real estate Korean (real-estate-kr)

```
Tone: architectural photography of Korean residential interior or
exterior — hanok modern fusion, apartment golden hour balcony view,
mid-century minimal interior. People absent or small silhouette. Mood:
aspirational, calm, Korean middle-upper market.

Lighting: golden hour or overcast diffuse, 5000-5500K. No harsh studio.

Color: muted earth + glass + concrete grey. Avoid pure white walls in
favor of warm off-white.
```

### H. Automotive/mobility (automotive-mobility)

```
Tone: cinematic vehicle photography — three-quarter studio shot or
desert/concrete jetty environmental. Glass reflection treatment. Mood:
engineering pride, motion implied.

Lighting: HDR studio lighting on vehicle body, polarizer to manage glass.
Or harsh sun + long shadow environmental.

Color: vehicle paint as primary, single ground-plane neutral. No
distracting background.
```

### I. Medical clinic Korean (medical-clinic)

```
Tone: clinical environment photography or product close-up — clean
treatment room, hand holding instrument, doctor profile in white coat.
Mood: trustworthy, sterile, premium. Avoid stock-photo doctor smiles.

Lighting: clinical fluorescent or soft natural, 5000-6500K. Even fill,
no drama.

Color: oklch(0.98 0.003 200) clinical white, oklch(0.55 0.10 200) brand
teal accent, oklch(0.20 0.005 250) typography near-black.
```

### J. Food & Beverage membership (fnb-membership)

```
Tone: warm food photography overhead 45° or three-quarter, steam visible,
hand reaching for cup or plate edge. Korean cafe / dessert / coffee
context. Mood: cozy, indulgent, brand-loyal.

Lighting: window soft light or warm tungsten 3200K. Shadow gradient
across plate.

Color: warm brown + cream + occasional brand accent. No green tint food.
```

---

## Format preset

각 prompt 마지막에 명시. provider 가 정확한 비율·해상도로 생성하도록.

| Preset | Aspect | Resolution (gpt-image-1) | Use case |
|---|---|---|---|
| `hero-wide` | 16:9 | 1536×1024 (closest) | Landing hero background, case study cover |
| `cover-portrait` | 4:5 | 1024×1536 | Mobile hero, product detail |
| `cover-square` | 1:1 | 1024×1024 | Project tile, social card, Instagram |
| `cover-landscape` | 4:3 | 1536×1024 (closest) | Project tile landscape, blog hero |
| `vertical-9-16` | 9:16 | 1024×1536 | Stories, TikTok cover, mobile splash |
| `wide-21-9` | 21:9 (cinemascope) | 1536×768 (manual crop from 1536×1024) | Hero cinematic only — note: gpt-image-1 supports only square / portrait / landscape; crop after gen |

gpt-image-1 (2025 release) 공식 지원 size: `1024x1024` / `1024x1536` / `1536x1024` / `auto`. 그 외는 Midjourney (v7 `--ar 21:9`) 또는 Runway 사용.

---

## Provider matrix

### gpt-image-1 (default — image actual gen)

`scripts/codex-media-gen.sh` 가 호출. OpenAI Images API, $0.04/image (high quality), 약 15-30s 생성.

```bash
codex-media-gen.sh \
  --dsp agency-portfolio \
  --prompt cover-01 \
  --output public/agency/cover-01.png \
  --size 1536x1024 \
  --quality high
```

### Midjourney v7 (manual, 고품질 또는 21:9 등 특수 비율)

DSP 의 prompt body 에 다음 suffix 추가하여 Discord / Web 에서 수동 실행:

```
... [prompt body] ...

--ar 16:9 --v 7 --style raw --s 50
```

### Veo 3 (video, Google AI Studio API access 필요 — 사용자 hand-off)

Markdown prompt 박아두기만. Veo 3 API 호출은 본 plugin 범위 외 (gated access). 사용자가 Google AI Studio 에 prompt copy-paste.

Veo 3 prompt 권장 구조 (verbatim 박을 것):

```
Style: [DSP 톤 descriptor]
Subject: [primary visual]
Camera: [movement — dolly in / orbit / locked off]
Duration: 8s (loop) | 15s (one-shot)
Audio: ambient room tone | silent
Color grade: [specific reference — Bladerunner 2049 / Roma / Moonlight]
Resolution: 1080p
```

### Sora (video, OpenAI gated access — 사용자 hand-off)

동일하게 markdown prompt 만. Sora API GA 시 자동 generation 으로 승격.

### Runway Gen-4 (video, API 즉시 사용 가능 — 추후 v1.9.0 자동화 후보)

Markdown prompt + (v1.9.0 부터) `scripts/codex-media-gen.sh --type video --provider runway`.

---

## DSP 별 prompt 명명 규칙

DSP 본문의 "Media Generation Prompts" 섹션은 다음 마커로 시작:

```markdown
<!-- media-prompt: name=<asset-name> type=<image|video> preset=<hero-wide|cover-square|...> provider=<gpt-image-1|midjourney|veo3|sora|runway> -->

[프롬프트 본문 — style descriptor + subject + composition + lighting + color, 100-300 단어]
```

예시 마커 (agency-portfolio 의 project cover):

```markdown
<!-- media-prompt: name=cover-01 type=image preset=cover-landscape provider=gpt-image-1 -->

Maison Bréa case-study cover. Brutalist cinematic dark composition...
```

`scripts/codex-media-gen.sh` 는 awk/sed 로 `name=cover-01` 마커 매치해 본문 추출.

---

## Pre-commit audit (designer agent 의무)

코드 생성 시 placeholder 패턴 (CSS lines/dots/diag/block 등) 자리가 있으면 해당 DSP 에 그 위치에 매핑되는 media-prompt 가 박혀있는지 확인:

```bash
# Generated code 의 placeholder 사용 케이스 색출
grep -rnE "p\.pattern\s*===|backgroundImage:.*repeating-linear-gradient|backgroundImage:.*radial-gradient" <project>/app

# 해당 DSP 의 Media Generation Prompts 섹션 매핑 확인
grep -nE "<!-- media-prompt: name=" prompts/design/web/<dsp-slug>.md
```

placeholder 자리 N개 → media-prompt N개 ≥ 1:1 매핑. 부족하면 DSP 에 prompt 추가하거나 Open question 으로 surface.

---

## 관련

- `_guardrails.md` — 5 카테고리 implementation trap (Category C motion stacking 과 본 media-prompts 가 독립)
- DSP 본문 — 각자의 "Media Generation Prompts" 섹션에서 본 카탈로그의 style descriptor 인용
- `scripts/codex-media-gen.sh` — Codex CLI 호환 image generation wrapper (OpenAI Images API 호출)
- `agents/designer.md` — Pre-commit audit 에 media-prompt 매핑 확인 의무

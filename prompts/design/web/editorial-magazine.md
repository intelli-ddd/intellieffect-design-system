---
name: editorial-magazine
type: design-system-prompt
domain: 디지털 매거진 / 인쇄 magazine 의 웹 에디션 (Apartamento, Cabana, Toiletpaper 류 + 한국 매거진 디지털화)
tone: print-derived, dense typography, hand-set feel, asymmetric grid
reference: Apartamento, Cabana, MAGAZINE B, The Folio, Toiletpaper
---

# Design System Prompt — Editorial Magazine

> 사용 패턴: designer agent 호출 시 spec body 에 verbatim 인용.

활판 인쇄와 hand-set type 의 질감을 웹으로 옮긴 디지털 매거진 디자인 시스템이다. 비대칭 12-col grid, hairline column rule, drop cap, mono caption 으로 print 의 밀도를 그대로 재현한다.

## 1. Design System Definition
- **Primary Color:** `#F2EFE6` 또는 `#F5F2E8` (warm cream paper stock, page background)
- **Accent Color:** `oklch(0.55 0.12 38)` terracotta / `oklch(0.32 0.10 240)` ink blue / `oklch(0.45 0.08 110)` olive 중 **단 하나만** 선택. Drop cap, pull quote rule, masthead volume number, footnote marker 한정.
- **Text Color:** `#181612` 또는 `#1A1815` (deep ink, headline + body), `#5A554C` (muted ink, caption + byline)
- **Typography:** 3-family 강제.
  - Serif display: PP Editorial New, Cormorant, Tiempos Headline — display weight **400-500 (NOT 700+)**. 표지 헤드라인은 italic regular 우선.
  - Serif body: Iowan Old Style, Tiempos Text, Cormorant — body 16-18px, line-height 1.5-1.65.
  - Mono caption: Söhne Mono, Berkeley Mono — caption 11-12px, tracking 0.04em, all-caps for plate caption / folio.
  - **Drop caps mandatory** in body intro 첫 문단 — 3-4 line height, accent color 또는 deep ink.
  - 본문 hanging punctuation, optical margin alignment 적용. Justify text + hyphenation 허용.
- **Border Radius:** `0` only (sharp corners). Pills, rounded button, rounded card 일체 금지.
- **Shadow:** 없음. 모든 elevation 은 hairline border 1px `#181612` at 15-20% opacity 로 표현. Card·image·dialog 어디에도 shadow 금지.
- **Icon Style:** Pictographic, hand-drawn feel — 등사판·목판화 질감의 SVG. 또는 **icon 완전 생략, text-only navigation 권장.** Lucide/Heroicons 같은 generic icon set 금지.

## 2. Layout & Structure
- 12-col asymmetric magazine grid, gutter 16-24px, hairline column rule 1px between columns.
- **Masthead at top:** 좌측 wordmark + volume·issue 번호 (`VOL. XII — ISSUE 03 — MMXXVI`, mono all-caps), 중앙 issue title in serif italic, 우측 date + page folio.
- **Body pattern:** 좌측 issue number + section nav (vertical, mono caps), 중앙 headline + drop cap intro (7-8col), 우측 plate caption + byline (mono, 2-3col).
- Pull quote 는 본문 column 가로지르며 serif italic large + 좌우 hairline rule.
- Plate (image) 캡션은 figure 하단 mono caps, italic figure number (`PLATE I`, `PLATE II`).
- Centered hero layout, full-bleed gradient hero, AI-generic landing 구조 모두 금지. Page 진입은 masthead → table of contents → article spread 순.
- Vertical rhythm 은 baseline grid 4px 또는 8px 에 snap.

## 3. UI Elements & Animation
- **Link:** body link 은 serif italic + 1px underline. Hover 시 underline → accent color shift 만, transform 금지.
- **Nav item:** mono caps, tracking 0.12em, hairline underline on current. Hover background fill 금지.
- **Button (사용 최소화):** 필요 시 text + bracket (`[ READ THE STORY ]`) 또는 hairline rectangle outline button, radius 0, no shadow, no fill.
- **Card:** article preview 는 hairline border 또는 column rule 만으로 구획. Box-shadow, rounded corner, background tint 금지.
- **Input:** newsletter signup 은 single underline only (border-bottom 1px), 좌측 mono label, 우측 arrow glyph submit. Filled rounded input 금지.
- **Animation:** 거의 정적, 인쇄물 fixed feel.
  - 페이지 전환 fade ≤ 250ms ease-out only.
  - Smooth scroll (native) 만 허용.
  - Hover: color shift, underline appearance 만. **Transform, scale, translate, rotation, parallax, scroll-reveal, stagger 일체 금지.**
  - Animated entrance > 250ms 금지.

## 4. Consistency Mandate
- 모든 섹션 (Masthead, Cover, Table of contents, Article spread, Plate gallery, Editor's letter, Colophon, Footer) 과 서브 페이지는 위 Design System Definition 을 엄격히 준수.
- 새 color·radius·shadow·font family 임의 추가 금지. Accent 는 처음 선택한 단일 색상 외 추가 금지. 3-family typography stack 외 폰트 import 금지.
- AI-generic banned 패턴:
  - Shadow on cards, drop-shadow anywhere
  - Rounded corner > 4px (어느 element 든)
  - Gradient (background, text, border, button) 전면 금지
  - Animated entrance > 250ms, scroll-reveal stagger, parallax
  - AI-generic "feature card" pattern — 3 identical cards with icon + heading + body
  - Centered hero layout with large CTA pair
  - Glassmorphism, backdrop-blur, neumorphism
  - Sans-serif display headline (serif display 강제)
  - Display weight 700+ (Tiempos Headline 같은 print-grade serif 는 400-500 으로만)
  - Generic Lucide/Heroicons icon row
  - Hero with abstract gradient blob, mesh gradient, AI-rendered 3D shape

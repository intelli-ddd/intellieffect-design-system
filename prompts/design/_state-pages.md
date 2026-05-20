---
name: state-pages-addendum
description: 모든 DSP 가 reference 하는 state pages (404 / 500 / loading skeleton / empty state) 명세. v1.9.6 — gsap-bp-audit 결과 DSP 카탈로그 25개 중 0개가 명시한 critical gap fill.
version: v1.9.6
---

# State Pages Addendum (cross-cutting)

DSP body 가 hero / sections / motion choreography 만 강조하면 **production reality 의 큰 부분 누락**:
- 404 페이지 (사용자가 broken link 클릭 시)
- 500 / 503 페이지 (서버 에러 시)
- Loading state (초기 mount / data fetch 중)
- Empty state (검색 결과 없음 / 비어있는 list / 신규 사용자 onboarding)

본 문서는 모든 DSP 의 Section 7 (또는 Section 8) 에 reference. designer agent 가 page route 생성 시 본 addendum 의 패턴 verbatim 적용.

---

## 1. 404 Page (Page Not Found)

### 의무 요소

- **Plain-language headline** — "Page not found" / "404 — 페이지를 찾을 수 없습니다"
- **사유 명시** (가능하면): "The link may be outdated, or the page may have moved."
- **Primary action** — Home link 또는 검색
- **Secondary action** — 최근 인기 page 리스트 또는 contact
- **Brand consistency** — hero 와 동일 tokens / typography. agency-portfolio 404 가 wellness 404 처럼 보이면 안 됨

### 패턴 (cluster 별 권장)

| Cluster | 404 pattern |
|---|---|
| A Brutalist agency | 큰 mono caps `404` + manifesto-style explanation + underlined home link. NO illustration. |
| B Cinematic immersion | 단색 background + 단순 `404 ROUTE NOT FOUND` Mono caps + telemetry HUD 같은 시그니처 element 유지 + ghost button home |
| K-Pop entertainment | 한글 + 영문 stacked `404 / 페이지 없음` + accent coral CTA "메인으로" |
| Wellness platform | warm cream bg + soft headline "Page can't be reached" + lime green CTA "Start over" |
| Editorial slow | serif display "Apologies — page missing" + narrow column + dashed divider + small home link |

### 권장 motion

- snippet #49 `404 SplitText entrance + search input expand` — hero 와 동일 reveal pattern 단순화 버전
- 또는 단순 fade in 0.4s (motion-light DSP)

### MUST NOT

- ❌ Generic illustration (broken robot / lost astronaut) — brand identity 위배
- ❌ Excessive humor copy ("Oops! You broke the internet") — production B2B 톤 위배
- ❌ Auto-redirect (사용자 의도 파악 불가)
- ❌ "Back to safety" 류 alarm 문구

### Example skeleton

```tsx
// app/not-found.tsx (Next.js App Router)
export default function NotFound() {
  return (
    <main className="state-page state-404">
      <div className="state-eyebrow">404 · ROUTE NOT FOUND</div>
      <h1 className="state-headline">Page can not be reached.</h1>
      <p className="state-body">
        The link may be outdated, or the project may have moved.
      </p>
      <div className="state-actions">
        <Link href="/" className="primary-cta">Back to home</Link>
        <Link href="/work" className="secondary-link">View selected work →</Link>
      </div>
    </main>
  );
}
```

---

## 2. 500 / 503 Page (Server Error)

### 의무 요소

- **Calm headline** — "Something went wrong" / "Service temporarily unavailable"
- **NO 기술 stack trace exposure** (production)
- **Status indicator** — current incident status, e.g., "Our team has been notified"
- **Retry action** — explicit reload button (auto-retry 금지)
- **Contact escape hatch** — support email 또는 status page link

### 패턴

| Cluster | 500 pattern |
|---|---|
| A Brutalist | Mono caps `500 / SERVICE INCIDENT` + status page link |
| B Cinematic | 단색 dark + telemetry HUD style `STATUS: DEGRADED · LAST CHECK: 14:32 KST` |
| Wellness | 가벼운 톤 + "We're working on it" + retry button |

### MUST NOT

- ❌ Stack trace 노출
- ❌ "Internal Server Error" raw text (사용자 친화적 메시지)
- ❌ Auto-retry 무한 loop
- ❌ 사용자가 다시 시도할 길 차단 (단순 dead-end)

### Example skeleton

```tsx
// app/error.tsx (Next.js App Router)
"use client";
export default function Error({ reset }: { reset: () => void }) {
  return (
    <main className="state-page state-500">
      <div className="state-eyebrow">500 · SERVICE INCIDENT</div>
      <h1 className="state-headline">Something is not right.</h1>
      <p className="state-body">
        Our team has been notified and is on it. Please try again in a moment.
      </p>
      <div className="state-actions">
        <button onClick={reset} className="primary-cta">Try again</button>
        <Link href="/status" className="secondary-link">View status →</Link>
      </div>
    </main>
  );
}
```

---

## 3. Loading / Skeleton State

### Production reality (Timothy Graf 2026-04-21 verbatim)

> "Skeleton screens beat spinners in 2026: perceived load time drops 18-32% when content shapes appear immediately instead of a generic spinner."

### 의무 요소

- **Shape preservation** — final content 의 layout 구조 미리 표시 (hero / card / list 형태)
- **Shimmer animation** — 1.5s ease-in-out diagonal gradient sweep
- **`aria-busy="true"` + `aria-live="polite"`** — screen reader 친화
- **Color matching** — bg `oklch(L+0.03 C 0)` (canvas 보다 살짝 밝게) 또는 `oklch(L-0.03 C 0)` (살짝 어둡게)
- **Reduced motion**: shimmer 정지 + 정적 mute background

### 패턴 — Snippet #48 verbatim

```tsx
// components/Skeleton.tsx
import type { CSSProperties, HTMLAttributes } from "react";

export function Skeleton({
  className,
  style,
  ...props
}: HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      aria-busy="true"
      aria-live="polite"
      className={`skeleton ${className ?? ""}`}
      style={style}
      {...props}
    />
  );
}
```

```css
.skeleton {
  background: linear-gradient(
    90deg,
    oklch(0.96 0.004 80) 0%,
    oklch(0.99 0.004 80) 50%,
    oklch(0.96 0.004 80) 100%
  );
  background-size: 200% 100%;
  animation: skeleton-shimmer 1.5s ease-in-out infinite;
  border-radius: 0;  /* DSP 의 radius token 따름 */
}
@keyframes skeleton-shimmer {
  0%   { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
@media (prefers-reduced-motion: reduce) {
  .skeleton {
    animation: none;
    background: oklch(0.96 0.004 80);
  }
}
```

### MUST NOT

- ❌ 단순 spinner (Material UI / Chakra default) — production-hostile 2026
- ❌ "Loading..." 텍스트만 (visual context 부재)
- ❌ shimmer 가 ≥ 3s 또는 ≤ 0.5s (1.5s 가 sweet spot)
- ❌ Shimmer 가 DSP accent color (정신 사납게)
- ❌ Full-page spinner (single content area 만 fetch 중인데 전체 freeze)

---

## 4. Empty State (No data / no results)

### 의무 요소

- **Plain-language headline** — "No projects yet" / "No matching results"
- **사유 또는 next step 명시** — "Try a different keyword" / "Start your first project"
- **Primary action** — CTA 로 사용자 다음 step 안내
- **Optional illustration** — DSP token 따르는 그래픽 (banned: generic empty box / sad cloud)

### 패턴

| Use case | Empty state copy |
|---|---|
| Search no results | "No results for '[query]'. Try broader keyword." |
| Filter no results | "No items match filter 'X'. Clear filter →" |
| Onboarding (new user) | "Welcome. Start your first project →" |
| Archive (no past entries) | "No archived items yet. Items will appear here when archived." |
| Notification (no unread) | "All caught up. No new notifications." |

### MUST NOT

- ❌ Blank space (사용자 confusion)
- ❌ "There is no data" 류 robot 문장
- ❌ "Empty!" 단일 단어
- ❌ Generic stock illustration (broken egg / empty box) — brand identity 위배

### Example

```tsx
export function EmptyState({
  title,
  description,
  primaryAction,
}: {
  title: string;
  description: string;
  primaryAction: { label: string; href: string };
}) {
  return (
    <div className="empty-state">
      <h2 className="empty-headline">{title}</h2>
      <p className="empty-body">{description}</p>
      <Link href={primaryAction.href} className="primary-cta">
        {primaryAction.label}
      </Link>
    </div>
  );
}

// Usage:
<EmptyState
  title="No projects yet."
  description="Start a new project to see it here."
  primaryAction={{ label: "New project →", href: "/new" }}
/>
```

---

## 5. Pre-commit audit (designer agent 의무)

DSP 적용 시 state pages 누락 확인:

```bash
PROJECT_DIR=<project>/app

# 404 page 존재 확인 (Next.js App Router)
test -f "$PROJECT_DIR/not-found.tsx" || echo "❌ Missing 404 page"

# Error boundary 존재
test -f "$PROJECT_DIR/error.tsx" || echo "❌ Missing error boundary"

# Skeleton 컴포넌트 사용 검출
grep -rE "Skeleton\b|aria-busy" "$PROJECT_DIR" | wc -l
# 0 이면 loading state 미구현 — fetch 있는 모든 page 에 보강 필요

# Empty state 검출
grep -rE "EmptyState\b|empty-state\b" "$PROJECT_DIR" | wc -l
# data 표시하는 page 가 있는데 0 매치 = empty state 미구현 가능
```

### 판정 룰

- **production-grade DSP 적용 시** (B2B SaaS / fintech / commerce / brutalist-architecture 등): 404 + error.tsx + Skeleton + EmptyState 모두 의무
- **demo-only DSP 적용 시** (showcase / landing-only): 최소 404 + EmptyState 만
- 누락 시 fail — fix 후 재실행

---

## 6. 핵심 reference

- **Timothy Graf 2026-04-21** — "Skeleton screens beat spinners in 2026" (1.5s shimmer + aria-busy/live)
- **AuditBuffet 2026 pattern AB-002290** — 404 audit pattern
- **Web.dev 2026 articles** — error boundary best practices for Next.js App Router
- **Vercel / Linear / Stripe 404 pages** — production-grade reference

---

## 7. DSP 별 state pages 매트릭스

각 DSP body 의 Section 7 또는 Section 8 끝에 다음 reference 추가:

```markdown
## State Pages (cross-cutting)

상위 `prompts/design/_state-pages.md` 의 4 카테고리 (404 / 500 / Loading / Empty)
모두 본 DSP token + typography 로 적용. designer agent 가 page route 생성
시 본 addendum 의 패턴 verbatim 적용.

본 DSP 특이 사항:
- 404 headline 톤: <DSP tone>
- skeleton background color: <DSP canvas tier>
- empty state illustration: <yes/no, type>
```

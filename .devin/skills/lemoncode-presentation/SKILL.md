---
name: lemoncode-presentation
description: Use when creating or updating slides, decks, or presentations and the user wants Lemoncode visual style — neo-brutalist, high-contrast black/cream/yellow with Archivo Black headings. Also use for any "Lemoncode-style" or "lemoncode.net style" requests.
---

# Lemoncode Presentation Style

## Overview

Neo-brutalist design system scraped from lemoncode.net. Key traits: massive UPPERCASE Archivo Black headings, hard non-blurred box shadows, thick solid borders, three-color palette (cream / ink-black / lemon-yellow), tight line-height on display text.

Default output: **Reveal.js** (self-contained HTML). User can request Marp or plain HTML.

---

## Design Tokens

### Colors

| Token        | Hex       | Use                              |
|--------------|-----------|----------------------------------|
| `--ink`      | `#111111` | Text, borders, hard shadows      |
| `--cream`    | `#fefaf0` | Light section background         |
| `--yellow`   | `#ffd60a` | Primary accent, CTAs, highlights |
| `--panel`    | `#171a16` | Dark section background          |
| `--earth`    | `#1f1a14` | Darkest warm tone (footers)      |
| `--white`    | `#ffffff` | Text on dark, card borders       |

### Typography

| Role         | Font               | Weight | Transform | Line-height |
|--------------|--------------------|--------|-----------|-------------|
| Display/H1   | `Archivo Black`    | 700    | UPPERCASE | 0.882       |
| Heading/H2   | `Archivo Black`    | 700    | UPPERCASE | 0.94        |
| Body         | `Archivo`          | 400    | —         | 1.55        |
| Code/Mono    | `IBM Plex Mono`    | 400    | —         | —           |

Google Fonts import:
```
https://fonts.googleapis.com/css2?family=Archivo+Black&family=Archivo:wght@400;600&family=IBM+Plex+Mono&display=swap
```

### Effects

```css
/* Hard shadow (no blur — this is the signature effect) */
--shadow-hard:        .45rem .45rem 0 #111111;
--shadow-hard-yellow: .5rem .5rem 0 #ffd60a;

/* Borders */
--stroke-lg: 3px solid #111111;
--stroke-md: 2px solid #111111;

/* Radius */
--radius-card:   1.45rem;   /* cards */
--radius-pill:   999rem;    /* buttons, tags */
--radius-md:     1rem;

/* Background texture (faint 24px grid) */
background-image: linear-gradient(180deg, rgba(17,17,17,.05) 0 1px, transparent 1px 100%) 0 0 / 100% 24px;
```

---

## Flow Diagrams

Use `.flow` for any horizontal box → arrow → box sequence (pipeline, lifecycle, analogy).

### CSS

```css
/* ── Flow diagram ── */
.flow {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  margin-top: 1.5rem;
  width: 100%;
}
.flow-node {
  background: var(--yellow);
  color: var(--ink);
  border: 2px solid var(--ink);
  border-radius: 0.85rem;
  box-shadow: 4px 4px 0 var(--ink);
  padding: 1rem 1.4rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.3rem;
  min-width: 148px;
  text-align: center;
}
.flow-node strong {
  font-family: 'Archivo Black', sans-serif;
  font-size: 0.72rem;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--ink);
}
.flow-node span { font-size: 0.65rem; opacity: 0.68; font-family: 'Archivo', sans-serif; }
.flow-icon { font-size: 1.5rem; line-height: 1; }
.flow-arrow {
  font-size: 1.8rem;
  color: var(--ink);          /* dark arrow on cream slides */
  font-family: 'Archivo Black', sans-serif;
  line-height: 1;
  flex-shrink: 0;
}
.dark .flow-arrow { color: var(--yellow); }   /* yellow arrow on dark slides */

/* ── Diagram animation rule: 500ms stagger, node → arrow → node → … ──
   Elements enter sequentially — each one 500ms after the previous.
   First element starts at the same time as body content (320ms).
   Works for any number of elements up to 7. ── */
.reveal .slides section.present .flow > *:nth-child(1) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay:  320ms;
}
.reveal .slides section.present .flow > *:nth-child(2) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay:  820ms;
}
.reveal .slides section.present .flow > *:nth-child(3) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay: 1320ms;
}
.reveal .slides section.present .flow > *:nth-child(4) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay: 1820ms;
}
.reveal .slides section.present .flow > *:nth-child(5) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay: 2320ms;
}
.reveal .slides section.present .flow > *:nth-child(6) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay: 2820ms;
}
.reveal .slides section.present .flow > *:nth-child(7) {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both; animation-delay: 3320ms;
}
```

### HTML template

```html
<!-- 3-node flow (5 elements total: 3 nodes + 2 arrows) -->
<div class="flow">
  <div class="flow-node">
    <span class="flow-icon">✍️</span>
    <strong>Step one</strong>
    <span>Subtitle</span>
  </div>
  <div class="flow-arrow">→</div>
  <div class="flow-node">
    <span class="flow-icon">🗂️</span>
    <strong>Step two</strong>
    <span>Subtitle</span>
  </div>
  <div class="flow-arrow">→</div>
  <div class="flow-node">
    <span class="flow-icon">⚙️</span>
    <strong>Step three</strong>
    <span>Subtitle</span>
  </div>
</div>

<!-- 4-node flow (7 elements) — max recommended for readability -->
<div class="flow">
  <div class="flow-node"><span class="flow-icon">📋</span><strong>A</strong><span>sub</span></div>
  <div class="flow-arrow">→</div>
  <div class="flow-node"><span class="flow-icon">📖</span><strong>B</strong><span>sub</span></div>
  <div class="flow-arrow">→</div>
  <div class="flow-node"><span class="flow-icon">✅</span><strong>C</strong><span>sub</span></div>
  <div class="flow-arrow">→</div>
  <div class="flow-node"><span class="flow-icon">⚡</span><strong>D</strong><span>sub</span></div>
</div>
```

### Rules

- **Max 4 nodes** per diagram — more than that does not fit the 1280 × 720 canvas.
- **Always use `.flow-arrow` between every pair of nodes** — never skip.
- **Dark slides**: arrow colour flips to yellow automatically via `.dark .flow-arrow`.
- **Animation**: CSS-only, automatic on slide entry — do NOT use Reveal.js fragments inside `.flow`.
- The `.flow-icon` emoji is optional but recommended — gives each node a distinct scan target.

---

## Slide Layouts

### 1. Hero Slide (cream bg)
- Background: `#fefaf0`
- Title: Archivo Black, UPPERCASE, display size, line-height 0.882, color `#111111`
- **Module label**: use `module-title` + `module-tag` for section covers (see Components). Tag text follows the `<Module N/>` JSX-like format — e.g. `<Module 01/>`, `<Module 02/>`. One module per section topic within a day.
- **Also used as a section cover** inside multi-topic presentations — same layout, same class, incrementing `<Module N/>` label per topic

### 2. Statement Slide (dark bg)
- Background: `#111111` or `#171a16`
- Title: Archivo Black, UPPERCASE, white or `#ffd60a`
- Body: Archivo, `#ffffff` or `rgba(255,255,255,0.8)`

### 3. Accent Slide (yellow bg)
- Background: `#ffd60a`
- Title: Archivo Black, UPPERCASE, `#111111`
- Use sparingly — max 1-2 per deck

### 4. Card Grid Slide (cream or dark bg)
- 2–3 dark cards (`#111111`) with `border: 3px solid #fefaf0`
- `box-shadow: 7px 7px 0 #111111` (hard, no blur)
- `border-radius: 1.45rem`
- Content: Archivo Black label, Archivo body

### 5. Two-Column Slide
- Left: large UPPERCASE heading
- Right: body text, code block, or card

### 6. Code Slide
- Dark background (`#171a16`)
- IBM Plex Mono code block
- Yellow (`#ffd60a`) for highlights/keywords

---

## HTML Templates (Reusable)

Use these as copy-paste templates. Always include the Lemoncode logo at the top-left.

### Template A: Two-Column Slide

```html
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="cols" style="align-items:center;">
    <div>
      <div class="module-num">01 — Title</div>
      <h2>Left<br>heading</h2>
      <p>Short explanation that fits 2-4 lines.</p>
      <ul>
        <li>Key point one</li>
        <li>Key point two</li>
        <li>Key point three</li>
      </ul>
    </div>
    <div>
      <div style="border:3px solid var(--ink);border-radius:1rem;padding:1.2rem;box-shadow:6px 6px 0 var(--ink);">
        <h3>Right panel</h3>
        <p>Use for examples, metrics, or a compact diagram.</p>
      </div>
    </div>
  </div>
</section>
```

### Template B: Single Image Slide

```html
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div style="display:flex;align-items:center;justify-content:center;flex:1;">
    <img
      src="./images/your-image.png"
      alt="Descriptive caption"
      style="max-width:100%;max-height:65vh;height:auto;object-fit:contain;border:2px solid var(--ink);box-shadow:6px 6px 0 var(--ink);border-radius:0.85rem;"
    />
  </div>
</section>
```

### Template C: Statement Slide (Dark)

```html
<section class="dark">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="module-num">Key idea</div>
  <h2>Short, bold<br>statement</h2>
  <p>One or two lines to reinforce the point.</p>
</section>
```

### Template D: Hero Cover

```html
<section class="hero">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="module-title"><span class="module-tag">&lt;Module 01/&gt;</span></div>
  <h1>Section<br>Title</h1>
</section>
```

---

## Reveal.js Template

Reveal.js CDN (v5.1):
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reset.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.css" />
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.js"></script>
```

Logo SVG: scraped from `https://d2gr4gsp182xcm.cloudfront.net/lemoncode/lemoncode-web-2/headingsection/headingsection/es/lemon-new.svg` — 48×29 lemon+braces icon; combine with a `<text>` wordmark to build the full logo file.

### Reveal.js init

```js
Reveal.initialize({
  hash: true,
  progress: true,
  slideNumber: true,
  center: false,         // left-align content (brutalist style)
  transition: 'none',
  backgroundTransition: 'none',
  width: 1280,
  height: 720,
});
```

### Core CSS rules

```css
/* All slides: flex column, content centered vertically.
   IMPORTANT: Reveal.js sets display:block via JS inline style on the active
   section — !important is required or justify-content has no effect. */
.reveal .slides section {
  box-sizing: border-box;
  width: 100%; height: 100%;
  padding: 3.5rem 4.5rem;
  display: flex !important;
  flex-direction: column !important;
  justify-content: center !important;
  text-align: left;
  background-color: var(--cream);
  background-image: linear-gradient(180deg, rgba(17,17,17,.04) 0 1px, transparent 1px 100%) 0 0 / 100% 24px;
  /* NOTE: rem is relative to html root (16px), not to .reveal.
     7rem = 112px, 5.5rem = 88px — use this when sizing text. */
}

/* Logo: always absolute top-left, never in flex flow */
.slide-logo {
  position: absolute;
  top: 1.4rem;
  left: 4.5rem;
  height: 26px;
}
/* Invert logo on dark slides without colour-shift (desaturate first) */
.dark .slide-logo { filter: saturate(0) invert(1) brightness(2.5); }

/* Hero: reduced vertical padding so 3-line h1 fits and flexbox can center it.
   Logo (SVG) shows as-is. Tag is hidden — the logo wordmark already says LEMONCODE. */
section.hero {
  padding-top: 1.5rem;
  padding-bottom: 1.5rem;
}
section.hero .tag { display: none; }
section.hero h1 { font-size: 7rem; line-height: 0.86; margin: 0; }

/* Dark slides: diagonal yellow micro-stripe (signature texture) */
.reveal .slides section.dark {
  background-color: var(--panel);
  background-image:
    repeating-linear-gradient(45deg, rgba(255,214,10,.08) 0 1px, transparent 1px 28px);
  color: var(--white);
}

/* Module title — used on hero/section-cover slides */
.module-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-family: 'Archivo Black', sans-serif;
  font-size: 1.5rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  margin-bottom: 1rem;
}
.module-title .module-rest { opacity: 0.4; }

/* Module tag — yellow rotated badge inside .module-title on hero slides */
.module-tag {
  display: inline-block;
  padding: 0.34rem 0.82rem 0.3rem;
  border: 2px solid var(--ink);
  border-radius: 0;                         /* square corners — intentional */
  background: var(--yellow);
  color: var(--ink);
  font-family: 'IBM Plex Mono', monospace;
  font-size: 0.75rem;
  line-height: 1;
  text-transform: uppercase;
  box-shadow: 0.18rem 0.18rem 0 var(--white);
  transform: rotate(-1deg);                 /* slight tilt — signature brutalist quirk */
}

/* Module num — slide-level label (not a hero cover) */
.module-num {
  font-family: 'Archivo Black', sans-serif;
  font-size: 1.5rem;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  opacity: 0.4;
  margin-bottom: 1rem;
}
.dark .module-num { color: var(--white); }

/* Three-column grid */
.cols-3 { grid-template-columns: repeat(3, 1fr); }

/* ── Two-column staggered slide-in (left → right) ── */
/* Remove .cols from the Step 3 entryFade group, then add these instead: */
@keyframes slideInLeft {
  from { opacity: 0; transform: translateX(-24px); }
  to   { opacity: 1; transform: translateX(0); }
}
/* Left column lands at the same moment body content does (320ms) */
.reveal .slides section.present .cols > *:nth-child(1) {
  animation: slideInLeft 0.45s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 320ms;
}
/* Right column follows 160ms later — creates left-to-right sweep */
.reveal .slides section.present .cols > *:nth-child(2) {
  animation: slideInLeft 0.45s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 480ms;
}
/* Three-column layouts: third at 640ms */
.reveal .slides section.present .cols > *:nth-child(3) {
  animation: slideInLeft 0.45s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 640ms;
}
```

### Slide variants

```html
<!-- Hero (cream) — opening or section-cover slide.
     module-tag uses <Module N/> JSX-like format — IBM Plex Mono, rotated yellow badge. -->
<section class="hero">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="module-title">
    <span class="module-tag">&lt;Module 01/&gt;</span>
  </div>
  <h1>Topic<br>Title</h1>
</section>

<!-- Section cover (cream) — same hero class, incremented <Module N/> between topics -->
<section class="hero">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="module-title">
    <span class="module-tag">&lt;Module 02/&gt;</span>
  </div>
  <h1>Next<br>Topic</h1>
</section>

<!-- Content slide (cream) — slide-level label via module-num -->
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="module-num">01 — Slide label</div>
  <h2>Slide<br>Title</h2>
  <!-- content -->
</section>

<!-- Dark statement -->
<section class="dark">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <h1>One big<br>idea</h1>
</section>

<!-- Yellow accent (use sparingly) -->
<section class="yellow">
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <h1>Key idea</h1>
  <div class="tag">CTA</div>
</section>

<!-- Three-column layout: module-num and h2 go inside the first column -->
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="cols cols-3">
    <div>
      <div class="module-num">Label</div>
      <h2>Three<br>things</h2>
      <h3>One</h3><p>Detail</p>
    </div>
    <div><h3>Two</h3><p>Detail</p></div>
    <div><h3>Three</h3><p>Detail</p></div>
  </div>
</section>

<!-- ─── TWO-COLUMN TEMPLATE (staggered slide-in) ─── -->
<!--
  RULE: On any multi-column slide, ALL content (module-num, h2, body) must
  live inside a column div. The ONLY element allowed outside .cols is the
  .slide-logo (it is position:absolute and not part of the flex flow).

  Animation sequence:
    320ms → LEFT column slides in from left (module-num + h2 + content together)
    480ms → RIGHT column slides in from left

  Put module-num + h2 + content inside the left <div> so they animate as one unit.
-->
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="cols">
    <div>
      <!-- ← slides in at 320ms: label + title + body as one unit -->
      <div class="module-num">01 — Label</div>
      <h2>Title inside<br>left column</h2>
      <ul>
        <li>Item one</li>
        <li>Item two</li>
        <li>Item three</li>
      </ul>
      <p class="idea-clave"><strong>Key idea:</strong> callout stays in the column too.</p>
    </div>
    <div>
      <!-- ← slides in at 480ms -->
      <h3>Right heading</h3>
      <ul>
        <li>Item one</li>
        <li>Item two</li>
        <li>Item three</li>
      </ul>
    </div>
  </div>
</section>

<!-- Image-right variant -->
<section>
  <img class="slide-logo" src="logo.svg" alt="Lemoncode" />
  <div class="cols" style="align-items:center;">
    <div>
      <div class="module-num">01 — Label</div>
      <h2>Title inside<br>left column</h2>
      <ul>
        <li>Item one</li>
        <li>Item two</li>
      </ul>
      <p class="idea-clave"><strong>Key idea:</strong> text here.</p>
    </div>
    <div>
      <img src="screenshot.png" alt="Description"
           style="width:100%;border-radius:0.85rem;border:2px solid var(--ink);box-shadow:6px 6px 0 var(--ink);display:block;" />
    </div>
  </div>
</section>
```

### Module numbering convention

Each major topic within a day gets its own `<Module N/>` tag — written as JSX-like component syntax displayed in IBM Plex Mono on the hero/section-cover slide. Modules increment per section, restarting at `01` each day.

```
Day 1:  <Module 01/> Tokens  |  <Module 02/> Context Window  |  <Module 03/> …
Day 2:  <Module 01/> Prompt to Harness  |  <Module 02/> Obsidian
Day 3:  <Module 01/> Plugins  |  <Module 02/> Spec-Driven Development
```

Use HTML entities inside the tag text: `&lt;Module 02/&gt;` renders as `<Module 02/>`.  
Do **not** use `module-num` on hero/cover slides — use `module-title` + `module-tag` instead. `module-num` is for slide-level sub-labels within a content slide.

---

## Marp Template

Create `theme.css` alongside the markdown file:

```css
/* @theme lemoncode */
@import url('https://fonts.googleapis.com/css2?family=Archivo+Black&family=Archivo:wght@400;600&family=IBM+Plex+Mono&display=swap');

:root {
  --ink:    #111111;
  --cream:  #fefaf0;
  --yellow: #ffd60a;
  --panel:  #171a16;
  --white:  #ffffff;
}

section {
  background: var(--cream);
  color: var(--ink);
  font-family: 'Archivo', sans-serif;
  font-size: 1.1rem;
  line-height: 1.55;
  padding: 3rem 4rem;
  background-image: linear-gradient(180deg, rgba(17,17,17,.05) 0 1px, transparent 1px 100%) 0 0 / 100% 24px;
}

h1, h2, h3 {
  font-family: 'Archivo Black', sans-serif;
  text-transform: uppercase;
  line-height: 0.9;
  letter-spacing: -0.01em;
  color: var(--ink);
}

h1 { font-size: clamp(3rem, 8vw, 7rem); }
h2 { font-size: clamp(2rem, 5vw, 4rem); }
h3 { font-size: clamp(1.4rem, 3vw, 2.5rem); }

/* Dark slide */
section.dark {
  background: var(--panel);
  color: var(--white);
  h1, h2, h3 { color: var(--white); }
}

/* Yellow accent slide */
section.yellow {
  background: var(--yellow);
  color: var(--ink);
}

/* Pill tag */
.tag {
  display: inline-block;
  background: var(--yellow);
  color: var(--ink);
  font-family: 'Archivo Black', sans-serif;
  font-size: 0.75rem;
  text-transform: uppercase;
  padding: 0.3rem 0.9rem;
  border: 2px solid var(--ink);
  border-radius: 999rem;
  margin-bottom: 1rem;
}

/* Hard-shadow card */
.card {
  background: var(--ink);
  color: var(--white);
  border: 3px solid var(--white);
  border-radius: 1.45rem;
  box-shadow: 7px 7px 0 var(--ink);
  padding: 1.5rem 2rem;
}

/* CTA button style */
.btn {
  display: inline-block;
  font-family: 'Archivo Black', sans-serif;
  font-size: 0.85rem;
  text-transform: uppercase;
  background: var(--yellow);
  color: var(--ink);
  border: 2px solid var(--ink);
  border-radius: 999rem;
  padding: 0.6rem 1.4rem;
  box-shadow: 4px 4px 0 var(--ink);
}

code, pre {
  font-family: 'IBM Plex Mono', monospace;
  background: #1f1a14;
  color: #ffd60a;
  border-radius: 0.5rem;
  padding: 0.2em 0.5em;
}
```

Markdown slide file:

```markdown
---
marp: true
theme: lemoncode
paginate: true
---

<!-- Hero slide -->
# Título del
tema aquí

---
<!-- _class: dark -->

# Lo que
vamos a
ver

- Punto uno
- Punto dos
- Punto tres

---
<!-- _class: yellow -->

# Una sola idea
## Muy grande

---

## Sección normal

Texto de cuerpo con **Archivo**. Usa mayúsculas para los títulos, serif negro para cuerpo.

```

---

## Slide Entry Animation

Every slide animates its content in three sequential steps when it becomes active (`.present`). This is CSS-only — no JavaScript required.

```css
@keyframes entryFade {
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* Step 1: label — lands immediately */
.reveal .slides section.present .module-num {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both;
}
/* Step 2: main heading — delayed so label lands first */
.reveal .slides section.present h1,
.reveal .slides section.present h2,
.reveal .slides section.present h4 {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 160ms;
}
/* Step 3: body content */
.reveal .slides section.present ul,
.reveal .slides section.present pre,
.reveal .slides section.present table,
.reveal .slides section.present .cols,
.reveal .slides section.present p {
  animation: entryFade 0.4s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 320ms;
}
```

**Notes:**
- `.module-num` font-size is `1.5rem` (doubled from the original `0.75rem`) so it reads clearly as a section label before the large heading follows
- Elements using Reveal.js **fragments** (e.g. `.sdd-flow` nodes) should be excluded from step 3 to avoid CSS conflicts — fragments handle their own opacity
- The animation re-fires every time the slide is navigated to, reinforcing the sequence

---

## Presentation Conventions

- **Titles**: always UPPERCASE in Archivo Black, 1-4 words per line, stacked vertically
- **Word emphasis**: highlight key words in yellow `<span style="color:#ffd60a">word</span>` on dark slides
- **Minimal text**: never more than 5-6 lines of body per slide
- **Multi-column layout rule**: on ANY slide that uses `.cols` or `.cols-3`, ALL content — `module-num`, `h2`, body text, `idea-clave` — must live INSIDE a column `<div>`. The ONLY element allowed outside `.cols` is `.slide-logo` (it is `position:absolute` and not part of the flex flow). Never place a `module-num` or `h2` between the logo and the `.cols` opener.
- **Column vertical alignment**: `.cols` MUST always include `style="align-items:center;"`. Columns are never top-aligned (`flex-start`) — centring prevents tall columns from pushing short ones to the top of the frame.
- **Multiple text elements**: when a slide has 2+ separate body sections (e.g. "Note" + "Key idea"), wrap in `.cols` — keep all text in the left `<div>`, right `<div>` reserved for images or left empty
- **Accent use**: yellow for the most important element only — not decorative
- **Shadows**: always flat/hard (offset only, zero blur) — never soft/blurred
- **Borders**: always `2-3px solid #111111` (or `#fefaf0` on dark bg)
- **Icons**: monochrome, outline style — match ink color of section
- **Links**: IBM Plex Mono, `0.72rem`, `opacity: 0.75`, `text-decoration: underline`. Color depends on slide background:
  - **Dark slides** → `color: var(--yellow)` (yellow on dark is readable)
  - **Cream/yellow slides** → `color: var(--ink)` (yellow is invisible on light bg — always use ink)
  - Never use `color: inherit` or default browser styling.
  - **Text must be a descriptive title, never a raw URL** — follow the citation format: `Author — Title (Source, Year)` or `org/repo — Short Description`. Example: `Liu et al. — Lost in the Middle (Stanford, 2023)`, not `cs.stanford.edu/~nfliu/papers/…`.
  - Place in a `<p>` below the slide body, one link per line separated by `<br />`.

```html
<!-- On a dark slide -->
<p style="margin-top:1rem;font-family:'IBM Plex Mono',monospace;font-size:0.72rem;opacity:0.75;line-height:1.8;">
  <a href="https://…" target="_blank" style="color:var(--yellow);text-decoration:underline">Author — Title (Source, Year)</a><br />
  <a href="https://…" target="_blank" style="color:var(--yellow);text-decoration:underline">org/repo — Short Description</a>
</p>

<!-- On a cream or yellow slide -->
<p style="margin-top:1rem;font-family:'IBM Plex Mono',monospace;font-size:0.72rem;opacity:0.75;line-height:1.8;">
  <a href="https://…" target="_blank" style="color:var(--ink);text-decoration:underline">Author — Title (Source, Year)</a><br />
  <a href="https://…" target="_blank" style="color:var(--ink);text-decoration:underline">org/repo — Short Description</a>
</p>
```

---

## Quick Slide Sequence Pattern

```
1. Hero (cream)         — Opening title of the presentation
2. Agenda (dark)        — 3-5 bullet points
3. Statement (yellow)   — One key idea
4. Content (cream)      — Detail slides
5. Card grid (cream)    — 2-3 takeaways
6. CTA (dark)           — Call to action

For multi-topic presentations, repeat with a section cover between topics:
   …last slide of topic A…
→  Hero (cream, section cover) — New topic title, same module-num
   Agenda / content for topic B…
```

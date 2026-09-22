---
name: article-creator
description: Creates and reviews blog articles for the Aridane Martín portfolio. Use when drafting new posts, reviewing article drafts, or editing content for voice and style.
license: MIT
metadata:
  author: aridane-martin
  version: "1.0"
  scope: root
---

# Article Creator

Creates and reviews blog articles for the Aridane Martín portfolio. Enforces voice, style, and formatting conventions.

---

## Writing Rules

### 1. No em dashes (—)

Em dashes are an AI slop signal. They make writing sound generated rather than human.

**Banned pattern:**

```markdown
The problem isn't making those decisions — it's that six months later nobody remembers why you made them.
```

**Fix:** Rewrite with a period, comma, colon, or parentheses instead.

```markdown
The problem isn't making those decisions. Six months later, nobody remembers why you made them.
```

```markdown
The problem isn't making those decisions. It's that six months later nobody remembers why you made them.
```

**Why:** Em dashes create a faux-dramatic rhythm that AI models default to. Human writers use them sparingly — or not at all. For this blog, treat them as a hard no.

### 2. Voice

Write like you talk: direct, opinionated, no filler. One idea per paragraph. Short sentences beat long ones.

### 3. Structure

- H2s every 3-5 paragraphs
- Code examples are self-contained and runnable
- No preamble paragraphs that restate the title
- End with a concrete takeaway, not a generic conclusion

---

## Workflow

1. Draft the article in markdown
2. Run through this checklist before publishing:
   - [ ] Zero em dashes
   - [ ] No "In today's fast-paced world" openers
   - [ ] No "Let's dive in" or "Without further ado"
   - [ ] Every code block has a language tag
   - [ ] Images follow the two-image convention (WebP cover + JPG OG)
3. Save to `src/content/blog/<slug>/index.md`

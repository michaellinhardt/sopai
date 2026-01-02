---
name: skll-create-skill
description: Guides creation of Claude Code skills - modular packages that extend Claude capabilities with specialized knowledge and workflows. Use when user wants to create a skill, asks about skill format, or mentions SKILL.md files.
---

# Skill: Create Claude Code Skills

## Overview

Skills = modular packages extending Claude with specialized knowledge/workflows. On-demand "onboarding guides" for domains.

**Characteristics:**
- Model-invoked via description matching
- On-demand loading (only metadata pre-loaded)
- Context-efficient
- Composable (multiple skills work together)

## File Structure

**Minimum:** Directory with `SKILL.md`

```
skill-name/
└── SKILL.md    # Required
```

**Extended:**
```
skill-name/
├── SKILL.md              # Required - overview
├── scripts/              # Optional - executables
├── references/           # Optional - docs
└── assets/               # Optional - output files
```

## SKILL.md Format

```markdown
---
name: skill-name
description: What it does and when to use it
---

# Skill: [Name]

## Instructions
[Steps]

## Examples
[Usage]
```

### Frontmatter

**Required:**
| Field | Constraints |
|-------|-------------|
| `name` | Max 64 chars, lowercase, letters/numbers/hyphens, no "anthropic"/"claude" |
| `description` | Max 1024 chars, include WHAT + WHEN |

**Optional:**
| Field | Example |
|-------|---------|
| `allowed-tools` | `Read, Grep, Glob` |
| `model` | `claude-sonnet-4-20250514` |

**Validation:** YAML spaces (not tabs), `---` on line 1 and after frontmatter, file named `SKILL.md` (case-sensitive)

## Storage

| Location | Scope | Path |
|----------|-------|------|
| Personal | All projects | `~/.claude/skills/skill-name/` |
| Project | Single repo | `.claude/skills/skill-name/` |

## Naming

**Use gerund form:** `processing-pdfs`, `analyzing-spreadsheets`, `testing-code`

**Avoid:** Vague (`helper`, `utils`), generic (`documents`), reserved (`anthropic-*`, `claude-*`)

## Descriptions

Critical - Claude uses to decide invocation.

**Rules:**
1. Third person
2. Specific capabilities + trigger keywords
3. Include WHAT + WHEN
4. All triggers in description (body loads AFTER triggering)

**Good:**
```yaml
description: Extract text/tables from PDFs, fill forms, merge documents. Use when working with PDFs or document extraction.
```

**Bad:**
```yaml
description: Helps with documents  # Too vague
```

## Best Practices

### 1. Be Concise
Claude is smart. Only add context it lacks.

**Good:**
```markdown
## Extract PDF text
Use pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
```

### 2. Progressive Disclosure
- SKILL.md under 500 lines
- Split large content to reference files
- References one level deep

### 3. Include Concrete Examples

```markdown
**Input**: Added error handling to API endpoints
**Output**:
```
feat(api): add error handling to endpoints
- Add try-catch blocks to all route handlers
- Return consistent error response format
```
```

### 4. Test Multiple Models
Test with Haiku, Sonnet, Opus.

## Patterns

### Workflow
```markdown
## Workflow
- [ ] Step 1: Analyze
- [ ] Step 2: Process
- [ ] Step 3: Validate

**Step 1: Analyze**
[Instructions...]
```

### Template
```markdown
## Report structure
ALWAYS use:
```markdown
# [Title]
## Summary
## Findings
```
```

### Conditional
```markdown
**Creating new?** -> "Creation workflow"
**Editing existing?** -> "Editing workflow"
```

## Examples

### Simple
```markdown
---
name: explaining-code
description: Explains code with diagrams and analogies. Use when explaining how code works.
---

When explaining code:
1. **Analogy**: Compare to everyday life
2. **Diagram**: ASCII art for flow/structure
3. **Walkthrough**: What happens and why
4. **Gotchas**: Common mistakes
```

### Tool-Restricted
```markdown
---
name: reading-files-safely
description: Read files without changes. Use for read-only access.
allowed-tools: Read, Grep, Glob
---

Only use Read, Grep, Glob. Never modify files.
```

## Checklist

- [ ] Description specific with triggers
- [ ] Description has WHAT + WHEN
- [ ] SKILL.md under 500 lines
- [ ] References one level deep
- [ ] No time-sensitive info
- [ ] Consistent terminology
- [ ] Concrete examples
- [ ] Tested with real usage

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Not triggering | Add trigger keywords, include WHEN |
| Not loading | Check filename `SKILL.md`, YAML syntax, `---` line 1 |
| Changes not reflecting | Restart Claude Code |

## Quick Commands

```bash
# Personal skill
mkdir -p ~/.claude/skills/skill-name && touch ~/.claude/skills/skill-name/SKILL.md

# Project skill
mkdir -p .claude/skills/skill-name && touch .claude/skills/skill-name/SKILL.md

# Debug
claude --debug
```

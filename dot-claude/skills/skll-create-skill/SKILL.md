---
name: skll-create-skill
description: Guides creation of Claude Code skills - modular packages that extend Claude capabilities with specialized knowledge and workflows. Use when user wants to create a skill, asks about skill format, or mentions SKILL.md files.
---

# Creating Claude Code Skills

## What Are Skills

Skills are modular, self-contained packages that extend Claude's capabilities with specialized knowledge, workflows, and tools. They function as on-demand "onboarding guides" for specific domains.

**Key characteristics:**
- Model-invoked: Claude decides when to use based on description matching
- On-demand loading: Only metadata pre-loaded; full instructions load when triggered
- Context-efficient: Specialized knowledge without bloating every conversation
- Composable: Multiple skills can work together automatically

## File Structure

### Minimum Viable Skill

Every skill requires a directory with a `SKILL.md` file:

```
skill-name/
└── SKILL.md    # Required - core instructions
```

### Extended Structure

For complex skills:

```
skill-name/
├── SKILL.md              # Required - overview and quick start
├── scripts/              # Optional - executable code
│   └── helper.py
├── references/           # Optional - documentation loaded as needed
│   └── api-docs.md
└── assets/               # Optional - files used in output
    └── template.html
```

## SKILL.md Format

### Template

```markdown
---
name: skill-name
description: What it does and when to use it
---

# Skill Title

## Instructions

Step-by-step guidance.

## Examples

Concrete usage examples.
```

### Frontmatter Rules

**Required fields:**

| Field | Constraints |
|-------|-------------|
| `name` | Max 64 chars, lowercase, letters/numbers/hyphens only, no "anthropic" or "claude" |
| `description` | Max 1024 chars, must include what AND when to use |

**Optional fields:**

| Field | Example |
|-------|---------|
| `allowed-tools` | `Read, Grep, Glob` |
| `model` | `claude-sonnet-4-20250514` |

**Validation:**
- YAML uses spaces (not tabs)
- `---` on line 1 and after frontmatter
- File must be named exactly `SKILL.md` (case-sensitive)

## Storage Locations

| Location | Scope | Path |
|----------|-------|------|
| **Personal** | All your projects | `~/.claude/skills/skill-name/` |
| **Project** | Single repository | `.claude/skills/skill-name/` |

**Create personal skill:**
```bash
mkdir -p ~/.claude/skills/my-skill
# Then create SKILL.md in that directory
```

**Create project skill:**
```bash
mkdir -p .claude/skills/my-skill
# Then create SKILL.md in that directory
```

## Naming Conventions

**Use gerund form (verb + -ing):**
- `processing-pdfs`
- `analyzing-spreadsheets`
- `testing-code`
- `writing-documentation`

**Avoid:**
- Vague names: `helper`, `utils`, `tools`
- Overly generic: `documents`, `data`
- Reserved words: `anthropic-*`, `claude-*`

## Writing Descriptions

The description is critical - Claude uses it to decide when to invoke your skill.

**Guidelines:**
1. Write in third person
2. Be specific with capabilities and trigger keywords
3. Include both WHAT it does and WHEN to use it
4. Put all trigger info in description (body loads AFTER triggering)

**Good examples:**

```yaml
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDFs, forms, or document extraction.

description: Generates clear commit messages from git diffs. Use when writing commit messages or reviewing staged changes.
```

**Bad examples:**

```yaml
description: Helps with documents  # Too vague
description: Processes data        # Too generic
description: Does stuff with files # Missing trigger context
```

## Best Practices

### 1. Be Concise

Claude is already very smart. Only add context it does not have.

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

**Bad:**
```markdown
## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. There are many libraries available...
```

### 2. Use Progressive Disclosure

- Keep SKILL.md under 500 lines
- Split large content into reference files
- Keep references one level deep

```markdown
## Quick start

[Essential info here]

## Advanced features

See [REFERENCE.md](REFERENCE.md) for complete guide.
```

### 3. Include Concrete Examples

```markdown
## Commit format

**Input**: Added error handling to API endpoints
**Output**:
```
feat(api): add error handling to endpoints

- Add try-catch blocks to all route handlers
- Return consistent error response format
```
```

### 4. Test with Multiple Models

Test with Haiku, Sonnet, and Opus - what works for Opus might need more detail for Haiku.

## Common Patterns

### Workflow Pattern

```markdown
## Workflow

Copy this checklist:

```
- [ ] Step 1: Analyze input
- [ ] Step 2: Process data
- [ ] Step 3: Validate output
```

**Step 1: Analyze input**
[Instructions...]
```

### Template Pattern

```markdown
## Report structure

ALWAYS use this template:

```markdown
# [Title]

## Summary
[Overview]

## Findings
- Finding 1
- Finding 2
```
```

### Conditional Pattern

```markdown
## Workflow selection

**Creating new content?** -> Follow "Creation workflow"
**Editing existing?** -> Follow "Editing workflow"
```

## Example Skills

### Simple Skill

```markdown
---
name: explaining-code
description: Explains code with visual diagrams and analogies. Use when explaining how code works or teaching about a codebase.
---

When explaining code:

1. **Start with an analogy**: Compare to everyday life
2. **Draw a diagram**: ASCII art for flow/structure
3. **Walk through step-by-step**: What happens and why
4. **Highlight gotchas**: Common mistakes to avoid
```

### Tool-Restricted Skill

```markdown
---
name: reading-files-safely
description: Read files without making changes. Use for read-only file access.
allowed-tools: Read, Grep, Glob
---

# Safe File Reader

Only use Read, Grep, and Glob tools. Never modify files.
```

## Checklist Before Sharing

- [ ] Description is specific with trigger keywords
- [ ] Description includes both WHAT and WHEN
- [ ] SKILL.md body under 500 lines
- [ ] References one level deep max
- [ ] No time-sensitive information
- [ ] Consistent terminology
- [ ] Concrete examples included
- [ ] Tested with real usage

## Troubleshooting

**Skill not triggering:**
- Make description more specific with trigger keywords
- Include WHEN to use, not just WHAT it does

**Skill does not load:**
- Check file is named `SKILL.md` (case-sensitive)
- Validate YAML syntax (spaces not tabs)
- Ensure `---` on line 1

**Changes not reflecting:**
- Restart Claude Code after creating/updating skills

## Quick Commands

```bash
# Create personal skill
mkdir -p ~/.claude/skills/skill-name && touch ~/.claude/skills/skill-name/SKILL.md

# Create project skill
mkdir -p .claude/skills/skill-name && touch .claude/skills/skill-name/SKILL.md

# Debug skills
claude --debug
```

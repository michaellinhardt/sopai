# Claude Code Skills: Complete Guide

A comprehensive reference for creating, organizing, and managing skills in Claude Code.

---

## Table of Contents

1. [What Are Skills](#what-are-skills)
2. [Skills vs Other Claude Code Features](#skills-vs-other-claude-code-features)
3. [File Structure and Format](#file-structure-and-format)
4. [Storage Locations](#storage-locations)
5. [SKILL.md Format](#skillmd-format)
6. [Naming Conventions](#naming-conventions)
7. [Writing Effective Descriptions](#writing-effective-descriptions)
8. [Progressive Disclosure](#progressive-disclosure)
9. [Best Practices](#best-practices)
10. [Common Patterns](#common-patterns)
11. [Examples](#examples)
12. [Advanced Topics](#advanced-topics)
13. [Troubleshooting](#troubleshooting)
14. [Resources](#resources)

---

## What Are Skills

Skills are **modular, self-contained packages** that extend Claude's capabilities by providing specialized knowledge, workflows, and tools. They function as "onboarding guides" for specific domains or tasks.

### Key Characteristics

- **Model-invoked**: Claude automatically decides when to use a skill based on the request matching the skill's description
- **On-demand loading**: Only metadata (name + description) is pre-loaded; the full instructions load only when triggered
- **Context-efficient**: Skills provide specialized knowledge without bloating every conversation
- **Composable**: Multiple skills can work together automatically

### What Skills Provide

1. **Specialized workflows** - Multi-step procedures for specific domains
2. **Tool integrations** - Instructions for working with specific file formats or APIs
3. **Domain expertise** - Company-specific knowledge, schemas, business logic
4. **Bundled resources** - Scripts, references, and assets for complex and repetitive tasks

---

## Skills vs Other Claude Code Features

| Feature | Purpose | How It Runs |
|---------|---------|-------------|
| **Skills** | Specialized knowledge/workflows | Claude chooses when relevant |
| **Slash Commands** | Reusable prompts | You type `/command` explicitly |
| **CLAUDE.md** | Project-wide instructions | Every conversation |
| **Subagents** | Delegate tasks separately | Claude delegates or you invoke |
| **Hooks** | Run scripts on events | Specific tool events |
| **MCP Servers** | Connect to external tools | Claude calls tools as needed |

### When to Use Skills

Use skills when you have procedures or expertise that:
- Need to be applied repeatedly
- Are domain-specific
- Require specialized knowledge Claude doesn't have by default
- Involve multi-step workflows

### When to Use Slash Commands

Use slash commands when you want:
- Explicit, repeatable terminal entry points
- One-time instructions
- Immediate context injection

---

## File Structure and Format

### Basic Structure

Every skill consists of a **directory** containing a required `SKILL.md` file:

```
skill-name/
├── SKILL.md              # Required - core instructions
├── scripts/              # Optional - executable code
│   ├── helper.py
│   └── validate.sh
├── references/           # Optional - documentation loaded as needed
│   ├── api-docs.md
│   └── schema.md
└── assets/               # Optional - files used in output
    ├── template.html
    └── logo.png
```

### Complete Structure Example

```
pdf-processing/
├── SKILL.md              # Overview and quick start
├── FORMS.md              # Form field mappings
├── REFERENCE.md          # API details
├── scripts/
│   ├── analyze_form.py   # Extract form fields
│   ├── fill_form.py      # Fill form values
│   └── validate.py       # Validation script
└── assets/
    └── templates/
        └── summary.html
```

### Resource Types

#### Scripts (`scripts/`)

- Executable code (Python, Bash, JavaScript, etc.)
- For deterministic, repeatable tasks
- **When to include**: Same code written repeatedly or deterministic reliability needed
- **Benefits**: Token efficient, reliable, may be executed without loading into context

#### References (`references/`)

- Documentation loaded into context as needed
- **When to include**: For documentation Claude should reference while working
- **Examples**: Database schemas, API documentation, domain knowledge, company policies
- **Best practice**: For large files (>10k words), include grep search patterns in SKILL.md

#### Assets (`assets/`)

- Files not loaded into context, used in output Claude produces
- **When to include**: When skill needs files for final output
- **Examples**: Templates, images, icons, boilerplate code, fonts

---

## Storage Locations

Skills can be stored in multiple locations with different scopes:

### Location Hierarchy (Priority Order)

| Location | Scope | Path |
|----------|-------|------|
| **Enterprise** | Organization-wide | Managed settings |
| **Personal** | All your projects | `~/.claude/skills/skill-name/` |
| **Project** | Single repository | `.claude/skills/skill-name/` |
| **Plugin** | Via marketplace | `skills/skill-name/` (inside plugin) |

### Personal Skills

Available across all your projects:

```bash
mkdir -p ~/.claude/skills/my-skill
# Create SKILL.md in that directory
```

### Project Skills

Shared with your team via version control:

```bash
mkdir -p .claude/skills/my-skill
# Create SKILL.md in that directory
```

### Plugin Skills

Install from marketplace:

```bash
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
```

---

## SKILL.md Format

Every `SKILL.md` file has two parts: **YAML frontmatter** and **Markdown body**.

### Basic Template

```markdown
---
name: skill-name
description: What this skill does and when to use it
---

# Skill Title

## Instructions

Step-by-step guidance for Claude.

## Examples

Concrete usage examples.

## Guidelines

- Guideline 1
- Guideline 2
```

### Frontmatter Fields

#### Required Fields

| Field | Description | Constraints |
|-------|-------------|-------------|
| `name` | Unique identifier | Max 64 chars, lowercase, letters/numbers/hyphens only |
| `description` | What it does and when to use | Max 1024 chars, non-empty |

#### Optional Fields

| Field | Description | Example |
|-------|-------------|---------|
| `allowed-tools` | Comma-separated tools Claude can use | `Read, Grep, Glob` |
| `model` | Specific model to use | `claude-sonnet-4-20250514` |

### Validation Rules

- `name`: Maximum 64 characters, lowercase letters/numbers/hyphens only, no XML tags, no reserved words ("anthropic", "claude")
- `description`: Maximum 1024 characters, non-empty, no XML tags
- YAML uses spaces (not tabs), with `---` on line 1 and after frontmatter
- File must be named exactly `SKILL.md` (case-sensitive)

---

## Naming Conventions

### Skill Names

Use **gerund form** (verb + -ing) for clarity:

**Good examples:**
- `processing-pdfs`
- `analyzing-spreadsheets`
- `managing-databases`
- `testing-code`
- `writing-documentation`

**Acceptable alternatives:**
- Noun phrases: `pdf-processing`, `spreadsheet-analysis`
- Action-oriented: `process-pdfs`, `analyze-spreadsheets`

**Avoid:**
- Vague names: `helper`, `utils`, `tools`
- Overly generic: `documents`, `data`, `files`
- Reserved words: `anthropic-helper`, `claude-tools`

### Directory Names

- Match the skill `name` field
- Use lowercase with hyphens
- Be descriptive: `form-validation-rules/` not `doc2/`

---

## Writing Effective Descriptions

The `description` field is **critical** - Claude uses it to decide when to invoke your skill.

### Guidelines

1. **Write in third person** - The description is injected into the system prompt
2. **Be specific** - Include capabilities and trigger keywords
3. **Include both what and when** - Describe functionality AND trigger contexts
4. **Put all trigger info here** - The body only loads AFTER triggering

### Good Examples

```yaml
# PDF Processing
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.

# Excel Analysis
description: Analyze Excel spreadsheets, create pivot tables, generate charts. Use when analyzing Excel files, spreadsheets, tabular data, or .xlsx files.

# Git Commit Helper
description: Generate descriptive commit messages by analyzing git diffs. Use when the user asks for help writing commit messages or reviewing staged changes.

# Document Creation
description: Comprehensive document creation, editing, and analysis with support for tracked changes, comments, formatting preservation, and text extraction. Use when Claude needs to work with professional documents (.docx files).
```

### Bad Examples

```yaml
# Too vague
description: Helps with documents

# Too generic
description: Processes data

# Missing trigger context
description: Does stuff with files
```

---

## Progressive Disclosure

Skills use a **three-level loading system** to optimize context usage:

### Loading Levels

1. **Metadata (name + description)** - Always in context (~100 words)
2. **SKILL.md body** - When skill triggers (<5k words recommended)
3. **Bundled resources** - As needed by Claude (unlimited)

### Pattern 1: High-Level Guide with References

```markdown
---
name: pdf-processing
description: Extracts text from PDF files, fills forms, merges documents. Use for PDF tasks.
---

# PDF Processing

## Quick start

Extract text with pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## Advanced features

**Form filling**: See [FORMS.md](FORMS.md) for complete guide
**API reference**: See [REFERENCE.md](REFERENCE.md) for all methods
**Examples**: See [EXAMPLES.md](EXAMPLES.md) for common patterns
```

### Pattern 2: Domain-Specific Organization

```
bigquery-skill/
├── SKILL.md (overview and navigation)
└── references/
    ├── finance.md (revenue, billing metrics)
    ├── sales.md (opportunities, pipeline)
    ├── product.md (API usage, features)
    └── marketing.md (campaigns, attribution)
```

```markdown
# BigQuery Data Analysis

## Available datasets

**Finance**: Revenue, ARR, billing -> See [references/finance.md](references/finance.md)
**Sales**: Opportunities, pipeline -> See [references/sales.md](references/sales.md)
**Product**: API usage, features -> See [references/product.md](references/product.md)
**Marketing**: Campaigns, attribution -> See [references/marketing.md](references/marketing.md)

## Quick search

```bash
grep -i "revenue" references/finance.md
grep -i "pipeline" references/sales.md
```
```

### Pattern 3: Conditional Details

```markdown
# DOCX Processing

## Creating documents

Use docx-js for new documents. See [DOCX-JS.md](DOCX-JS.md).

## Editing documents

For simple edits, modify the XML directly.

**For tracked changes**: See [REDLINING.md](REDLINING.md)
**For OOXML details**: See [OOXML.md](OOXML.md)
```

### Important Guidelines

- **Keep SKILL.md under 500 lines** - Split content when approaching this limit
- **Keep references one level deep** - Avoid nested file references
- **Add table of contents for long files** - For reference files >100 lines
- **Use forward slashes in paths** - Works across all platforms

---

## Best Practices

### Core Principles

#### 1. Concise is Key

The context window is shared with conversation history, system prompt, and user requests.

**Default assumption**: Claude is already very smart.

Only add context Claude doesn't have. Challenge each piece:
- "Does Claude really need this explanation?"
- "Can I assume Claude knows this?"
- "Does this paragraph justify its token cost?"

**Good (concise):**
```markdown
## Extract PDF text

Use pdfplumber for text extraction:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
```

**Bad (verbose):**
```markdown
## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. There are many libraries available...
```

#### 2. Set Appropriate Degrees of Freedom

Match specificity to task fragility:

- **High freedom** (text-based instructions): Multiple valid approaches, context-dependent
- **Medium freedom** (pseudocode/scripts with parameters): Preferred patterns, some variation acceptable
- **Low freedom** (specific scripts, few parameters): Fragile operations, consistency critical

#### 3. Test with All Models

Test with Haiku, Sonnet, and Opus - what works for Opus might need more detail for Haiku.

### Content Guidelines

- **Avoid time-sensitive information** - Use "old patterns" sections if needed
- **Use consistent terminology** - Pick one term and use it throughout
- **Provide concrete examples** - Not abstract descriptions
- **Include input/output pairs** - For output-quality-dependent skills

### What NOT to Include

Do NOT create extraneous documentation:
- README.md
- INSTALLATION_GUIDE.md
- QUICK_REFERENCE.md
- CHANGELOG.md

The skill should only contain information needed for the task.

---

## Common Patterns

### Template Pattern

For strict requirements:

```markdown
## Report structure

ALWAYS use this exact template:

```markdown
# [Analysis Title]

## Executive summary
[One-paragraph overview]

## Key findings
- Finding 1
- Finding 2

## Recommendations
1. Recommendation 1
2. Recommendation 2
```
```

For flexible guidance:

```markdown
## Report structure

Here is a sensible default format, but adapt as needed:

[template...]

Adjust sections based on the specific analysis type.
```

### Examples Pattern

```markdown
## Commit message format

Generate commit messages following these examples:

**Example 1:**
Input: Added user authentication with JWT tokens
Output:
```
feat(auth): implement JWT-based authentication

Add login endpoint and token validation middleware
```

**Example 2:**
Input: Fixed bug where dates displayed incorrectly
Output:
```
fix(reports): correct date formatting in timezone conversion

Use UTC timestamps consistently across report generation
```
```

### Workflow Pattern

```markdown
## PDF form filling workflow

Copy this checklist and track progress:

```
Task Progress:
- [ ] Step 1: Analyze the form
- [ ] Step 2: Create field mapping
- [ ] Step 3: Validate mapping
- [ ] Step 4: Fill the form
- [ ] Step 5: Verify output
```

**Step 1: Analyze the form**

Run: `python scripts/analyze_form.py input.pdf`

This extracts form fields, saving to `fields.json`.

**Step 2: Create field mapping**

Edit `fields.json` to add values for each field.
[...]
```

### Feedback Loop Pattern

```markdown
## Document editing process

1. Make your edits to `word/document.xml`
2. **Validate immediately**: `python scripts/validate.py unpacked_dir/`
3. If validation fails:
   - Review the error message
   - Fix the issues
   - Run validation again
4. **Only proceed when validation passes**
5. Rebuild: `python scripts/pack.py unpacked_dir/ output.docx`
```

### Conditional Workflow Pattern

```markdown
## Document modification workflow

1. Determine the modification type:

   **Creating new content?** -> Follow "Creation workflow" below
   **Editing existing content?** -> Follow "Editing workflow" below

2. Creation workflow:
   - Use docx-js library
   - Build document from scratch
   - Export to .docx format

3. Editing workflow:
   - Unpack existing document
   - Modify XML directly
   - Validate after each change
   - Repack when complete
```

---

## Examples

### Example 1: Simple Single-File Skill

```markdown
---
name: explaining-code
description: Explains code with visual diagrams and analogies. Use when explaining how code works, teaching about a codebase, or when the user asks "how does this work?"
---

When explaining code, always include:

1. **Start with an analogy**: Compare the code to something from everyday life
2. **Draw a diagram**: Use ASCII art to show flow, structure, or relationships
3. **Walk through the code**: Explain step-by-step what happens
4. **Highlight a gotcha**: What's a common mistake or misconception?

Keep explanations conversational. For complex concepts, use multiple analogies.
```

### Example 2: Tool-Restricted Skill

```markdown
---
name: reading-files-safely
description: Read files without making changes. Use when you need read-only file access.
allowed-tools: Read, Grep, Glob
---

# Safe File Reader

This Skill provides read-only file access.

## Instructions

1. Use Read to view file contents
2. Use Grep to search within files
3. Use Glob to find files by pattern

Never modify files when this skill is active.
```

### Example 3: Multi-File Skill with Scripts

**Directory structure:**
```
pdf-processing/
├── SKILL.md
├── FORMS.md
├── REFERENCE.md
└── scripts/
    ├── analyze_form.py
    ├── fill_form.py
    └── validate.py
```

**SKILL.md:**
```markdown
---
name: pdf-processing
description: Extract text, fill forms, merge PDFs. Use when working with PDF files, forms, or document extraction. Requires pypdf and pdfplumber packages.
allowed-tools: Read, Bash(python:*)
---

# PDF Processing

## Quick start

Extract text:
```python
import pdfplumber
with pdfplumber.open("doc.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

For form filling, see [FORMS.md](FORMS.md).
For detailed API reference, see [REFERENCE.md](REFERENCE.md).

## Requirements

```bash
pip install pypdf pdfplumber
```

## Utility scripts

**analyze_form.py**: Extract form fields
```bash
python scripts/analyze_form.py input.pdf > fields.json
```

**validate.py**: Check field values
```bash
python scripts/validate.py fields.json
```

**fill_form.py**: Apply values to PDF
```bash
python scripts/fill_form.py input.pdf fields.json output.pdf
```
```

### Example 4: Commit Message Generator

```markdown
---
name: generating-commit-messages
description: Generates clear commit messages from git diffs. Use when writing commit messages or reviewing staged changes.
---

# Generating Commit Messages

## Instructions

1. Run `git diff --staged` to see changes
2. Suggest a commit message with:
   - Summary under 50 characters
   - Detailed description
   - Affected components

## Best practices

- Use present tense ("Add feature" not "Added feature")
- Explain what and why, not how
- Reference issue numbers when applicable

## Examples

**Input**: Added error handling to API endpoints
**Output**:
```
feat(api): add error handling to endpoints

- Add try-catch blocks to all route handlers
- Return consistent error response format
- Log errors with request context
```
```

---

## Advanced Topics

### Using Skills with Subagents

Skills don't auto-inherit in subagents. Explicitly list them in agent configuration:

```yaml
---
name: code-reviewer
description: Review code for quality and best practices
skills: pr-review, security-check
---
```

### MCP Tool References

For MCP tools, use fully qualified names:

```markdown
Use the BigQuery:bigquery_schema tool to retrieve table schemas.
Use the GitHub:create_issue tool to create issues.
```

Format: `ServerName:tool_name`

### Utility Scripts Best Practices

#### Handle Errors Explicitly

```python
def process_file(path):
    """Process a file, creating it if it doesn't exist."""
    try:
        with open(path) as f:
            return f.read()
    except FileNotFoundError:
        print(f"File {path} not found, creating default")
        with open(path, 'w') as f:
            f.write('')
        return ''
```

#### Document Configuration Constants

```python
# HTTP requests typically complete within 30 seconds
REQUEST_TIMEOUT = 30

# Three retries balances reliability vs speed
MAX_RETRIES = 3
```

### Distributing Skills

- **Project**: Commit `.claude/skills/` to version control
- **Plugin**: Create `skills/` directory in plugin
- **Enterprise**: Deploy via managed settings

---

## Troubleshooting

### Skill Not Triggering

**Issue**: Vague descriptions

**Fix**: Include specific capabilities and trigger keywords

**Bad**: "Helps with documents"

**Good**: "Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDFs, forms, or document extraction."

### Skill Doesn't Load

- Check file path (case-sensitive `SKILL.md`)
- Validate YAML syntax (spaces not tabs, `---` on line 1)
- Run `claude --debug` for errors

### Multiple Skills Conflict

- Make descriptions distinct with specific trigger terms
- Avoid similar descriptions

### Changes Not Reflecting

- Exit and restart Claude Code after creating/updating skills
- Clear plugin cache if using plugins:
  ```bash
  rm -rf ~/.claude/plugins/cache
  ```

---

## Resources

### Official Documentation

- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills)
- [Skill Authoring Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)

### Help Center

- [What are Skills?](https://support.claude.com/en/articles/12512176-what-are-skills)
- [Using Skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- [How to Create Custom Skills](https://support.claude.com/en/articles/12512198-creating-custom-skills)

### Engineering Blog

- [Equipping Agents with Skills](https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
- [Introducing Agent Skills](https://www.anthropic.com/news/skills)

### Community Resources

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Simon Willison on Skills](https://simonwillison.net/2025/Oct/16/claude-skills/)
- [Inside Claude Code Skills](https://mikhail.io/2025/10/claude-code-skills/)

---

## Quick Reference Card

### Minimum Viable Skill

```bash
mkdir -p ~/.claude/skills/my-skill
```

```markdown
---
name: my-skill
description: What it does and when to use it
---

# My Skill

Instructions go here.
```

### Checklist

Before sharing a skill:

- [ ] Description is specific with trigger keywords
- [ ] Description includes both what and when
- [ ] SKILL.md body is under 500 lines
- [ ] References are one level deep
- [ ] No time-sensitive information
- [ ] Consistent terminology
- [ ] Concrete examples included
- [ ] Tested with real usage

### Key Commands

```bash
# Create personal skill
mkdir -p ~/.claude/skills/skill-name

# Create project skill
mkdir -p .claude/skills/skill-name

# Install from marketplace
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills

# Debug
claude --debug
```

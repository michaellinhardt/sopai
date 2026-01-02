# Optimized Request: Enhance skll-prompt-compression with Metrics Tracking

## Context

- **Skill Location:** `dot-claude/skills/skll-prompt-compression/`
- **Workflow Folder:** `./agts/wkf.1767385361/`
- **Agent:** `agt-persona-ai-engineer` (Opus 4.5)

## Objective

Add compression metrics tracking to `skll-prompt-compression` skill:
1. Create a tool that records file size and token count
2. Tool supports snapshot history per file
3. Auto-generate before/after comparison table
4. Save compression reports to `agts/` folder

## Constraints

- **DO NOT** alter the existing compression protocol (Annex section)
- **DO NOT** modify the compression methodology
- **PRESERVE** all existing skill instructions verbatim
- **ADD** only: tool + instructions for metrics tracking

---

## Workflow

### Phase 1: Tool Design & Implementation

#### Task 1.1: Create Token Metrics Tool

**Location:** `dot-claude/skills/skll-prompt-compression/compression-metrics.sh`

**Functionality:**
- Accept file path as argument
- Calculate:
  - File size (bytes)
  - Character count
  - Token estimate (formula: `chars / 4` for approximation)
- Store snapshot in JSON format: `~/.compression-metrics/[file-hash].json`
- Support multiple snapshots per file (append mode)
- When file has existing snapshots, output comparison table

**Output Format (when previous snapshot exists):**
```
| Metric      | Before    | After     | Delta     | % Change |
|-------------|-----------|-----------|-----------|----------|
| Size (B)    | 2048      | 1024      | -1024     | -50%     |
| Characters  | 2000      | 1000      | -1000     | -50%     |
| Tokens (est)| 500       | 250       | -250      | -50%     |
```

**Output Format (first snapshot):**
```
Snapshot recorded for: [file-path]
- Size: 2048 bytes
- Characters: 2000
- Tokens (est): 500
```

#### Task 1.2: Create Report Generator

**Trigger:** After compression (when before/after snapshots exist)

**Output Location:** `./agts/[file-name].compression.md`

**Report Content:**
```markdown
# Compression Report: [file-name]

## Summary
| Metric      | Before    | After     | Reduction |
|-------------|-----------|-----------|-----------|
| ...         | ...       | ...       | ...       |

## Details
- Original Path: [path]
- Compressed: [timestamp]
- Method: Prompt Compression Protocol
```

---

### Phase 2: Skill Update

#### Task 2.1: Add Tool Usage Instructions

**Insert Location:** After `## Output` section, before `## Input Modes`

**New Section:**
```markdown
## Metrics Tracking

**Before compression:**
```bash
./compression-metrics.sh "[file-path]"
```

**After compression:**
```bash
./compression-metrics.sh "[file-path]"
```

Tool auto-generates comparison table and saves report to `./agts/[file-name].compression.md`.
```

#### Task 2.2: Update Output Section

**Modify:** Add to `## Output` section:
```markdown
Compress files directly. No confirmation. Process all files. **Always run metrics tool before/after compression.**
```

---

### Phase 3: Validation

#### Task 3.1: Verify Preservation

- [ ] Original compression protocol unchanged
- [ ] All 5 protocol steps intact
- [ ] Constraints section unchanged
- [ ] Operating Logic unchanged

#### Task 3.2: Verify Additions

- [ ] Tool exists and is executable
- [ ] Skill references tool correctly
- [ ] Report path documented

---

## Execution Instructions

Task sub-agent `agt-persona-ai-engineer` (Opus 4.5):

```
Execute workflow in `./agts/wkf.1767385361/`

1. Read existing skill: `dot-claude/skills/skll-prompt-compression/SKILL.md`
2. Create tool: `dot-claude/skills/skll-prompt-compression/compression-metrics.sh`
3. Update skill with metrics tracking instructions (preserve all existing content)
4. Validate: compression protocol section unchanged

Constraints:
- DO NOT modify Annex: Prompt Compression Protocol
- DO NOT alter compression methodology
- ONLY add: tool + usage instructions
```

# Workflow: Analyze-Review-Apply

## Purpose
Structured workflow for analyzing a problem, getting expert review, and applying fixes.

---

## Input
- **Initial Request:** [User's request describing what needs to be fixed/improved]
- **Target File(s):** [File(s) to analyze and modify]

---

## Workflow Steps

### Step 1: Initialize Workflow
1. Create workflow folder: `mkdir -p ./agts && mkdir "./agts/wkf.$(date +%s)/"`
2. Create `00.workflow.context.md` with:
   - Initial request
   - Purpose
   - Method
   - Acceptance criteria

### Step 2: Analyze
1. Read target file(s)
2. Identify gaps, issues, or missing elements
3. Write `01.analyse.md` containing:
   - Problem statement
   - Current state (with line references)
   - List of potential issues with:
     - What's wrong
     - Why it's a problem
     - How to fix it
   - Proposed solution
   - Summary table (gap, severity, fix)

### Step 3: Expert Review
1. Spawn AI Engineer sub-agent with:
   - `**Workflow folder:** /absolute/path/to/wkf.xxx/`
   - Task description
   - Context (target file content, analysis summary)
2. Sub-agent creates:
   - `02.ai-engineer.review.context.md` - Review of analysis (agree/disagree, additional insights)
   - `03.[target].proposed.md` - Full proposed revision

### Step 4: Discuss
1. Present summary of proposed changes to user
2. Highlight key decisions and rationale
3. Ask: "Ready to discuss or apply?"
4. Address any user feedback or questions

### Step 5: Apply
1. On user approval ("apply"), edit target file(s)
2. Update `00.workflow.context.md` with execution report:
   - Status: COMPLETED
   - Changes applied (with line numbers)
   - AGT files created
   - Project files edited

---

## File Naming Convention

| ID | File | Purpose |
|----|------|---------|
| 00 | `00.workflow.context.md` | Request, purpose, method, acceptance, execution report |
| 01 | `01.analyse.md` | Problem analysis |
| 02 | `02.ai-engineer.review.context.md` | Expert review |
| 03 | `03.[name].proposed.md` | Proposed revision |

---

## Example Usage

**Initial Request:**
> "Fix the authentication module - it's not validating tokens properly"

**Target File:** `src/auth/validator.js`

**Workflow Execution:**
1. Create `./agts/wkf.1768800000/`
2. Analyze `validator.js`, identify validation gaps
3. AI Engineer reviews, proposes fix
4. Discuss with user
5. Apply approved changes

---

## Task Management (TodoWrite Tool)

### Core Rules

- Tasks are NOT tied to markdown headers (H2/H3)
- Orchestrator creates ONE task per clear action:
  - Actions explicitly instructed in the request
  - Actions planned by Orchestrator itself
  - Actions instructed to sub-agents (prefixed with sub-agent ID)

### Task Naming Convention

**Format:** `[ID]. [action description]`

- Sub-agent tasks use 2-digit ID prefix: `01.`, `02.`, `03.`...
- ID = sub-agent number (starts at 01, increments per new sub-agent)
- Multiple tasks for same sub-agent share the same ID

**Example Request:**
```
## Research

SubAgent: `agt-tech-lead`
Output: `file.md`

Research the Ralph method
Write a report in file.md

### Review

SubAgent: `agt-ai-engineer`
Output: review.md

Review the file
```

**Resulting Tasks:**
```
[ ] 01. online research on Ralph method
[ ] 01. write report on Ralph method
[ ] 02. review the report
```

---

### Parallel Mode

When Orchestrator spawns sub-agents to run in parallel and has nothing else to do while waiting:

**Before Starting Sub-Agents:**
1. Save current task list state (in memory)
2. Clear all tasks
3. Pass instruction `Parallel Mode XX` to each sub-agent (XX = their ID)

**Sub-Agent Behavior (when receiving `Parallel Mode XX`):**
1. Use TodoWrite tool to list own tasks
2. Prefix all tasks with assigned ID: `XX. task description`
3. Mark tasks in_progress as work progresses
4. **MUST mark ALL own tasks as completed before returning** - This is mandatory so Orchestrator sees final state

**Example - Two Parallel Sub-Agents:**
```
[x] 01. online research on tomato
[ ] 01. write analysis on tomato
[x] 02. online research on potato
[x] 02. write analysis on potato
```

**After All Sub-Agents Complete:**
1. Orchestrator restores previous task list state
2. Add/mark completed the task representing the parallel work just done

**CONSTRAINTS:**
- NEVER use bash loops/sleep to poll sub-agent status (wastes tokens)
- Sub-agents report completion naturally via Task tool return
- Orchestrator waits for Task tool results before proceeding

---

## Notes
- Sub-agents MUST receive explicit workflow folder path
- All workflow artifacts go to `./agts/wkf.xxx/`
- Use MUST/NEVER language for constraints
- Keep analysis structured with tables for quick review

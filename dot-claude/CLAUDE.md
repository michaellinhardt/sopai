# CLAUDE.md

## Role Detection

**Check your prompt for:** `**Workflow folder:**` followed by a path.

- **Path present** -> You are a **SUB-AGENT**. Follow Sub-Agent Rules.
- **No path** -> You are the **ORCHESTRATOR**. Follow Orchestrator Rules.

---

## Orchestrator Rules

**Responsibilities:**
- Create workflow folder: `mkdir -p ./agts && mkdir "./agts/wkf.$(date +%s)/"`
- Create `00.workflow.context.md` with: request, purpose, method, acceptance criteria
- Spawn sub-agents WITH explicit `**Workflow folder:** /absolute/path/`
- Log workflow state after each task
- Write execution report on completion

**Core Directives:**
- Optimize context window: avoid unnecessary reads
- Read files partially when classifying
- Create tasks for all operations

**Delegation Rules (MANDATORY):**

Within a SubAgent block, these directives are FOR THE SUB-AGENT, not the Orchestrator:
- `Use [path]` / `Input [path]` / `Read [path]` -> sub-agent reads it
- `Output [path]` -> sub-agent writes to it
- Any file reference without explicit "Orchestrator reads" prefix

**Orchestrator behavior:**
- Pass file paths verbatim to sub-agents in their prompts
- Do NOT read files that sub-agents will process
- Only read files when explicitly instructed: "Orchestrator reads...", "You will read..."

**Example - WRONG:**
```
SubAgent: agt-rag-generator
Use `./data/input.md`
```
Orchestrator reads `./data/input.md` ❌ (pollutes context)

**Example - CORRECT:**
Orchestrator passes path to sub-agent prompt without reading it ✓

---

## Sub-Agent Rules

**CONSTRAINTS (MANDATORY):**
- NEVER create `./agts/` or `wkf.xxx/` folders
- NEVER run `mkdir` for workflow folders
- ONLY write to the provided workflow path
- If no path received: STOP and report error

**Behavior:**
- Use the exact path from `**Workflow folder:**` in your prompt
- Save outputs to that folder using naming convention
- Do not init workflow files (orchestrator handles this)

---

## Shared Rules

### Naming Convention

**Format:** `[2-digit-ID].[name].[type].md`
- No spaces/special chars, use dots
- Concise names

**Examples:** `03.sota.persona.context.md`, `12.references.log.md`

**ID Rules:**
- Start at `00` for each workflow (`00.workflow.context.md`)
- Increment sequentially: `01`, `02`, `03`...
- Files created in same step share ID (e.g., parallel sub-agent outputs)
- Check existing files in folder before assigning next ID

### File Writing Rules

**CONSTRAINTS (MANDATORY):**

1. **No path specified in request:**
   - MUST write to `./agts/wkf.xxx/`
   - MUST use naming convention

2. **Path specified in request:**
   - MUST write to the specified path
   - MUST ALSO copy to `./agts/wkf.xxx/` with `.copy` as type
   - Copy naming: `[ID].[original-filename].copy.md`
   - Example: `/project/config.md` -> also write `./agts/wkf.xxx/05.config.copy.md`

3. **Exception:** If path is already inside `./agts/wkf.xxx/`, do NOT create duplicate copy.

### File Locations

- Non-project files (memory, state, reports): `./agts/wkf.xxx/`
- Project files: specified path (with copy to wkf folder)
- Claude Code files (skills, agents): `.claude/` (local or home)

---

## Task Management

### Task Creation Rules

**Orchestrator creates tasks for:**
- One task per clear action instructed in the request
- One task per action planned by the Orchestrator itself
- Tasks delegated to sub-agents use ID prefix format: `XX. task description`

**Sub-Agent ID Prefixes:**
- Format: `XX.` where XX is a 2-digit sub-agent ID
- IDs start at `01`, increment for each new sub-agent
- All tasks for the same sub-agent share the same ID

**Example Request:**
```
## Research
SubAgent: agt-tech-lead
Research the Ralph method
Write a report in file.md

### Review
SubAgent: agt-reviewer
Review the file
```

**Resulting Tasks:**
```
[ ] 01. online research on Ralph method
[ ] 01. write report on Ralph method
[ ] 02. review the report
```

### Parallel Mode Handling

**When Orchestrator spawns parallel sub-agents:**

1. **Before starting:** Clear all current tasks (save state internally)
2. **Instruct sub-agents:** Include `Parallel Mode XX` in the prompt (XX = their ID)
3. **Sub-agent behavior:** When receiving `Parallel Mode XX`, the sub-agent lists its own tasks using the task tool with prefix `XX.`
4. **During execution:** Task list shows all sub-agent tasks with their IDs
5. **After completion:** Orchestrator restores the task list to its previous state, marking the parallel task as complete

**Example during parallel execution:**
```
[x] 01. online research on tomato
[ ] 01. write analysis on tomato
[x] 02. online research on potato
[x] 02. write analysis on potato
```

**Important:** Do NOT use token-consuming methods (bash loops, sleep/check) to track sub-agent status. Wait for sub-agents to finish and report back.

---

## Orchestrator Startup

Create `./agts` if needed, init workflow files, spawn sub-agents with paths, execute request.

**Sub-agents: This section does not apply to you.**

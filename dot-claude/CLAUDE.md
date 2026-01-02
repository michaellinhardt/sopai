# CLAUDE.md

**Role:** Orchestrator agent for persona/agent workflows.

**Core Directives:**
- Run multi-agent workflows
- Optimize context window: avoid unnecessary reads
- Read files partially when classifying
- Create tasks for all operations
- Log workflow state after each task

## Agent Files

**Workflow Folder:**
- If path provided (e.g., `./agts/wkf.xxxxxxxxx/`): use it
- Else: `mkdir -p ./agts && mkdir "./agts/wkf.$(date +%s)/"`

**Usage:**
- Save non-project files (memory, state, reports, plans) in `./agts/wkf.xxx/`
- Provide exact path to all agents
- Default save location: `agts` folder
- Explicit instruction location: follow strictly
- Project files: remain in project location

### workflow.context.md

- If exists: read `./agts/wkf.xxx/00.workflow.context.md`
- Else: create it

**Content:** Structured report: initial request, workflow purpose, method, acceptance criteria.

**On completion:** Write execution report:
- Tasks accomplished (concise summary)
- AGT files and purpose
- Project files created/edited with reason
- Agents, Personas, Skills used

### Naming Convention

**Location:** `./agts/wkf.xxx/`

**Format:** `[2-digit-ID].[name].[type].md`
- No spaces/special chars, use dots
- Concise, explicit names

**Examples:**
- `03.sota.persona.context.md`
- `05.research.plan.context.md`
- `12.references.log.md`

**ID Rules:**
- Incremental per file
- Parallel files share same ID
- Applies to all files in folder/subfolders
- Provide ID to sub-agents

**File [type]:** `context` files = `./agts/wkf.xxx/*context.md`

## Workflow Syntax

- H2 headers: create task
- H3 headers: create task with `sub:` prefix
- Sub-agent: create task with `agt:` (add `sub:` if from H3)
- Execute headers sequentially

## Remember

Startup: create `./agts` if needed, init workflow files, then execute request.

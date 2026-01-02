# CLAUDE.md

**Role:** Orchestrator agent executing persona/agent workflows.

**Core Directives:**

- Run multi-agent workflows
- Optimize context window: avoid unnecessary file reads
- Read files partially when only classifying
- Create tasks for all operations
- Provide concise workflow state & events log after each task

## Agent Files

**Workflow Folder Creation:**
If you did receive the path of the workflow folder (example `./agts/wkf.xxxxxxxxx/`), do not create it, use the given path ; else if `./agts` doesn't exists, create the folder and create: `mkdir "./agts/wkf.$(date +%s)/"`

**Usage:** You and sub-agents save non-project files (memory, workflow state, reports, plans) in this folder. Provide exact path to all agents.

When it is not specified where to save a file, it should goes into `agts` folder.

When the instructions explicitely provide a location to save a file, follow strictly the instruction.

This apply to workflow related file.

Project related files remain located where they belongs.

Example in a code repository, code files are not created inside `agts` folder.

### workflow.context.md

If `./agts/wkf.xxx/00.workflow.context.md` exist, you have to read it ; else create it

A structured report file of the initial request, what will do this workflow, how, why, etc.. any information you have so far, well structured. What is the acceptance criteria to validate the workflow.

When the workflow is over and you finished your tasks, write a report on the execution. List of tasks accomplished with very short concise summary of the task. List of AGT file related, what they used for. Project file created/edited, concise reason for each. Any relevant informations.

### Naming Convention

**Location:** `./agts/wkf.xxx/`

**Rules:**

- Extension: `[position 2 digit].[file name].[type]` before file extension (e.g., `03.sota.persona.context.md`)
- Format: no spaces, no special chars, use dots as separators
- Style: concise and explicit

**Examples:**

- `03.task.3.3.plan.context.md`
- `05.research.plan.context.md`
- `12.references.log.md`

**Indexing Position [position 2 digit]:**

- Each created file have an incremental ID
- Purpose to keep the order of creation in name
- During parallel file creation, each file have the same ID
- Example:
  - `00.workflow.context.md`
  - `01.prep.research.log.md`
  - `02.research1.context.md`
  - `02.research2.context.md`
  - ...
- It apply to any file in the folder and sub-folders.
- Provide sub-agent with the ID they have to use when creating `agts` files.

**Using file [type]:**
When instructed to give all `context` files, it imply path of files in `./agts/wkf.xxx/` finishing by `.context.md`

## Workflow Syntax

Create a task for lvl 2 headers
Create a task for lvl 3 headers, start it with `sub:`

Headers are sequence to execute one by one.

## Remember

When you start, you create `./agts` if not existing and you record your workflow, always! Before any instruction, read the request, initiate the workflow files (use request context), then execute the request.

---
name: skll-file-guide
description: Generates files.agt.md documentation from file/folder paths for agentic workflows. Use for file navigation guides, context optimization, or sub-agent file lists.
---

# Skill: File Guide Generator

Generate `files.agt.md` navigation maps for agents. Reduces context window usage.

## Purpose

Create file documentation analyzing types, relationships, relevance to requests.

## Use Cases

### 1. Full Folder Mapping
Generate complete file map of one or more folders. Use when sub-agents need to know all available files for incoming tasks.

**Invocation:** Provide folder path(s) without specific task context.
```
/file-guide ./src ./docs
```

### 2. Workflow-Specific Mapping
Given a workflow or task, analyze what files are related, explore dependencies, and generate a targeted file map.

**Invocation:** Provide task description with optional paths.
```
/file-guide implement user auth using ./src/auth and ./docs/api-spec.md
```

### 3. Sub-Agent Context Preparation
Generate file lists organized by sub-agent responsibilities, minimizing context waste for each agent.

## Output Location

**Default:** `./agts/` folder (creates `files.agt.md` or `[name].files.agt.md`)

**Custom location:** Specify output path in request.
```
/file-guide ./src --output ./src/FILES.md
/file-guide ./project --output ./agts/wkf.xxx/03.project.files.context.md
```

**In-folder placement:** When analyzing a folder, can place guide inside that folder.
```
/file-guide ./my-module --output ./my-module/files.agt.md
```

## Workflow

1. Parse request to identify referenced paths and implied file needs
2. Automatically detect relevant files from context
3. Analyze file types + relationships
4. Generate output file at specified or default location

## Automatic File Detection

The skill implicitly deduces which files belong in the file map by:

1. **Explicit paths**: Folders/files directly mentioned in the request
2. **Task inference**: Files needed based on described tasks or sub-agents
3. **Dependency analysis**: Related files discovered during exploration
4. **Context relevance**: Files matching keywords/concepts in the request

## Token Efficiency

- Read first half of file for context
- Read second half only if insufficient
- Goal: first half suffices for classification

## Exploration Scope

- List files 2 parent levels up for context
- Explore 2 levels deep in provided folders
- Skip repetitive patterns:

```
./FolderA/
  ./FolderA/img01/  [explore one]
  ./FolderA/img02/  [skip - same pattern]
  ./FolderA/img03/  [skip]
```

## Output Format

### Without Request Context

```markdown
# Files Guide for Agents

`./[path]`

- [file description]
- [relevant request parts; "none" if irrelevant]
- [irrelevant parts if applicable]
- [other instructions]
```

### With Request Context

When request includes file/folder paths OR describes tasks requiring file lists:

**First paragraph verbatim (required):**
```
This document is the list of file needed to be use to accomplish this request. Use it to provide agents with only the required files for their task, saving context window and token.
```

```markdown
# Agent File Guide

This document is the list of file needed to be use to accomplish this request. Use it to provide agents with only the required files for their task, saving context window and token.

## Project context:

- `./context.md` project context
- `./changes.md` recent changes

## [Sub-agent/Task Name]:

- [Project context files]
- `./specific/file.md` description
```

## Folder Structure

Include visualization showing hierarchy and relationships:

```
Project Context (C0 - 00 Project Context.md)
└── Defines entire project philosophy
├── Module List & Summary (C0 - 00 Module List & Content summary.md)
│   └── Shows module structure
└── Module 1 - Prompting
    ├── Module Overview (C0 - M1 - 00 Module Overview.md) <- MASTER REFERENCE
    │   └── Derives from Project Context
    │       ├── Script (C0 - M1 - 01 Script.md)
    │       │   └── Implementation of teaching sequence
    ├── Assets (Teaching Materials)
    │   ├── Japanese Menu.md
    │   └── Japanese Trip.md
    ├── plan brainstorm.md
    └── request brainstorm.md
```

## Constraints

- Max 3 header levels
- Minimal markdown formatting
- Compact structure
- Focus: clarity + token efficiency

## Context

Standalone skill, runs before sub-agent initiation. If request unknown, reverse-engineer purpose from file contents.

## Task Identification

Identify file needs by analyzing:
1. Explicit folder/file paths in the request
2. Tasks/sub-tasks that imply specific file requirements
3. Domain keywords that map to project areas

## Example Parsing

**Input:**
```
analyze ./src/auth/ and ./docs/api-spec.md for implementing user authentication, then start 2 sub-agents: one for backend auth logic, one for API documentation updates.
```

**Automatic detection identifies:**
- `./src/auth/` folder for authentication implementation
- `./docs/api-spec.md` for API specification
- Backend sub-agent needs: auth source files + related configs
- Docs sub-agent needs: API spec + related documentation

**Output:**
```markdown
# Agent File Guide

This document is the list of file needed to be use to accomplish this request. Use it to provide agents with only the required files for their task, saving context window and token.

## Project context:

- `./context.md` project context
- `./docs/architecture.md` system architecture overview

## Backend auth sub-agent:

- [Project context files]
- `./src/auth/login.ts` login handler implementation
- `./src/auth/session.ts` session management
- `./src/auth/middleware.ts` auth middleware
- `./config/auth.json` authentication configuration

## API docs sub-agent:

- [Project context files]
- `./docs/api-spec.md` current API specification
- `./docs/endpoints/` endpoint documentation folder
- `./src/auth/` reference for auth endpoints to document
```

**Generates sections based on detected paths and inferred task requirements.**

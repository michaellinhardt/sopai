---
name: skll-file-guide
description: Generates files.agt.md documentation from file/folder paths for agentic workflows. Use for file navigation guides, context optimization, or sub-agent file lists.
---

# Skill: File Guide Generator

Generate `guide.files.md` and `list.files.md` in `./agts` folder.

## Purpose

A file used inside agentic workflow by agents to know which file to read/edit to accomplish their tasks. It describes what files are and when they can be used, relatively to the task/request invoked for the file guide.

## Process

1. **Input:** Work by analyzing workflow request directly or being invoked with a specific request that can be a list of paths (folder/files) to include in the file map

2. **Write file list:** Write all file paths identified in input inside `list.files.md` - starting point for analysis

3. **Discovery mode:** Determine what each file is, how they are related, if other files should be listed. Maintain `list.files.md` with accurate list of files planned to map

4. **Study relationships:** Analyze relationships between each file and given request/workflow/task (if any). Remember the given task is not for you to do, only for context

5. **Write guide:** Once figured out, write `guide.files.md` in compressed manner using skill `skll-prompt-compression` to know how to write small AI Optimized file

6. **Answer:** Return ONLY the list of files mapped (full path) and for each, a one sentence description. Don't answer anything else to not disturb the workflow

## Rules

- Read files 100 lines at a time to preserve context, keep reading until able to explain the file
- Always write `guide.files.md` in agts folder, copy with bash when requested elsewhere
- List files 2 parent levels up for context
- Explore 2 levels deep in provided folders
- Skip repetitive patterns (e.g., `img01/`, `img02/`, `img03/` - explore one, skip rest)

## Structure for guide.files.md

```markdown
# Files Guide for Agents

## File List

[bullet list of files (full path)]

## Descriptions

`./[path]`

- [file description concise]
- [relevant request parts if any]
- [irrelevant parts if applicable]
- [other instructions]
```

# New Structure for skll-file-guide

I want to change how the skill is delivered to the LLM who read it.

Restructure the information and follow the flow I suggest.

This is not to be absolutely respected but a guideline on how to reworks it.

## New Structure

- Start to explain

Generate file `guide.files.md` in `./agts` folder.
Generate file `list.files.md` in `./agts` folder.

- Add the purpose

A file used inside agentic workflow by the agents, to know which file to read/edit to accomplish their tasks. It describe what files are and when they can be used, relatively to the task/request invoqued for the file guide.

- Use Cases

1. Input: You work by analyzing the workflow request directly or by being invoqued with a specific request that can be a list of path (folder/files) to include in the file map.

2. Write all files path identified in the input inside `list.files.md`, this is your starting point for analysis.

3. Start discovering mode, what each files are, how they are related, is there other files that should be listed, etc.. Maintain `list.files.md` with the accurate list of files that you plan to map.

4. Study the relationships between each file and the given request/workflow/task ( if any ). Remember the given task is not for you to do, only for you to have context.

5. Once you figured out all of it, write the `guide.file.md` in a compressed manner, using the skill `skll-prompt-compression` to know how to write a small AI Optimized file.

6. You answer with ONLY the list of files you mapped (full path) and for each, a one sentence description of the file. Don't answer anything else to not disturbe the workflow.

- Rule

Read a file 100 line by 100 line to preserve your context, keep reading as long as you are not able to explain the file. When you have enough to understand the file purpose, you stop.

You always right `guide.file.md` in the agts folder. You copy it with bash when requested to save it in another destination.

[ add the rule about the exploration scope ]

- Strucutre guide.file.md

```markdown
# Files Guide for Agents

## File List

[bullet list of files ( full path)]

## Descriptions

`./[path]`

- [file description concise]
- [relevant request parts if any]
- [irrelevant parts if applicable]
- [other instructions]
```
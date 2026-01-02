# Workflow


## Optimize the Initial Request below

Task sub agent Opus 4.5 `agt-persona-ai-engineer` to do the following workflow

Read the `### Initial Request`, analyze the need, clarify it.

Write `request.optimized.md` in the same folder as this file, which is the reformulation of the need, in a request file structured as a workflow, with sequential approach to execute this request with the optimal result.

### Initial Request

Edit the skill `skll-prompt-compression` to add a rule, when finishing to compress a file, always output a table with before/after, to show the size of file and number of token before / after.

You will create a tool in the skill folder ( use most appropriate format/language/etc.. ) that can be used by the model. Providing the file path as argument, and after compressing using it again with the same file path. The tool when used, record the file path + the size and token ( use formula to calc token ). When used again, it save a new snapshop of this info without erasing the previous. When receive a path that already been saved before, after saving the new snapshop, it answer the table before/after for the model. So the model dont have to calculate, it just use the tool appropriately before and after. This should be clearly instructed in the skill.

It always save in agts folder the report from the tool in a file `[file-name].compression.md`

In order to operate thise changes, task a sub-agent Opus 4.5 to do it. Instruct it to not alterate the process described in the original skill. The method to compress a prompt should remain explained in the skill in the exact same way.
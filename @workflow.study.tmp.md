@workflow.study.tmp.md

I will demonstrate a problem.

Below is an instruction passed to the Orchestrator:

```markdown
# Ralph

## Transcript

SubAgent `agt-rag-generator`
Use `./request/ralph.transcript.md`
Output `./request/ralph.rag.md`

## Fact Checks

### Not Parallel

SubAgent `agt-technical-lead`
Output: `facts.list.md` (AGT)

All facts identified in the rag.

- About popularity
- What it accomplish
- etc..

Make a one sentence per facts in this file.

### Parallel per facts listed

SubAgent `agt-technical-lead`
Output: `[snakeCaseFactShortName].check.md`

Check online about this fact. Avoid commercial / sponsored content unles it's simply documentation.

## Report

SubAgent `agt-technical-lead`
Output: `ralph.report.md`

Review all information, write me a final report on Ralph. I want to know everything, you can online search. Use our materials. If any facts are wrong or exagerated in the rag, mention it in one specific category separated.
```

This is the Orchestrator response

```orchestrator
I'll orchestrate this workflow. Let me start by setting up the workflow folder and context.

⏺ Bash(mkdir -p ./agts && mkdir "./agts/wkf.$(date +%s)/" && ls -la ./agts/ | grep wkf | tail -1)
  ⎿  drwxr-xr-x@  2 teazyou  staff   64 Jan 19 03:05 wkf.1768766701

⏺ Read(request/ralph.transcript.md)
  ⎿  Read 892 lines
```

As you can see it reads the request transcript, however in my request, only subagent works on the task itself, there is no reason for Orchestrator to pollute its context. The orchestrator context should remain as much as possible focus on orchestrating subagent and tasks. Reading this file is for the sub agent. This should be enforced. Only when explicitely stated such as `You will read online` then its for the Orchestrator and its ok. In this block of instructions:

```instructions
## Transcript

SubAgent `agt-rag-generator`
Use `./request/ralph.transcript.md`
Output `./request/ralph.rag.md`
```

It is implicit that the `Use` is for the sub agent. In that case the Orchestrator, blindly instruct the agent.
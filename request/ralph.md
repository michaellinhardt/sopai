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
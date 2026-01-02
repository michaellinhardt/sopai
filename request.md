# Workflow

## Clarify my request

Below is the description of a skill I want to create, what it should do, whats its purpose etc..

Task a sub-agent opus 4.5 to read it and generate `skill.details.md` with a more structured clarified description of my skill.

### Skill Details

Skill name: `skll-create-persona`

It describe how to create a `persona` which is similar to an agent, saved in the same location as an agent (~/.claude/agents), however there is some rules to follow.

A Persona does not carry any instruction on how to do things.

The Persona purpose is only to manipulate the prediction output of the model with vocabulary and context that lead to a prediction matching expert levels.

Example, for a technical lead persona, it does not explain how to code this or that, what are the rules of good code, how to refacto etc etc..

It just describe the profile, soft and hard skills of a world wide master in the persona provided. Or at least it only focus on the characters, the focus, the practice etc..

## Create Skills

Start an Opus 4.5 sub-agent.

- It impersonate a AI engineer expert
- It create the skill for claude-code described in `skill.details.md`
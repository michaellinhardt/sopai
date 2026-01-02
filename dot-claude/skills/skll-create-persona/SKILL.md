---
name: skll-create-persona
description: Guides creation of Persona files - character profiles that influence model predictions through expert vocabulary and mindset, distinct from agents (which contain instructions/workflows).
---

# Skill: Create Persona

Guide for creating **Persona** files for Claude Code. Personas enhance model predictions via rich contextual vocabulary and domain expertise attributes.

---

## Quick Start

1. Define expert identity
2. Establish expertise domains
3. Describe soft skills & communication style
4. Capture mindset & character traits
5. Save to `~/.claude/agents/agt-persona-[name].md`

---

## Understanding Personas

### Definition

Persona = **character profile** influencing Claude's prediction/generation. Shapes *voice*, *perspective*, *expertise depth* through statistical correlation with expert vocabulary.

### Key Principle

Persona does NOT teach/instruct. It *embodies* expertise so predictions naturally align with expert-level discourse. Describes *who* expert is, not *what/how* they do.

### Persona vs Agent

| Aspect | Persona | Agent |
|--------|---------|-------|
| **Purpose** | Influence predictions via character context | Execute tasks with specific instructions |
| **Content** | Character traits, expertise domains, mindset | Workflows, rules, methodologies |
| **Behavior** | Shapes *how* responses framed | Defines *what/how* to do |

---

## Template

```markdown
# Persona: [Role Title]

Impersonate the following persona.

## Profile
[1-3 sentences: expertise level, years experience, domain authority, professional background]

## Expertise Domains
- [Primary domain/specialization]
- [Secondary domain]
- [Additional deep knowledge areas]
- [Associated tools/technologies]

## Communication Style
[2-3 sentences: direct/verbose, formal/casual, teaching style, explanation approach]

## Mindset
- [Core professional value/principle]
- [Trade-off approach]
- [Protective/skeptical areas]
- [Pragmatism vs perfectionism stance]

## Focus Areas
- [Natural attention areas]
- [Priority quality dimensions]
- [Typical trade-off preferences]
```

---

## Step-by-Step Guide

### Step 1: Define Profile

Concise expert description:
- Expertise level (years, mastery tier)
- Domain authority (specialist, lead, architect)
- Professional background

**Example:** "Battle-tested technical lead, 12+ years building distributed systems at scale. Led 8-15 engineer teams across multiple successful product launches."

### Step 2: Establish Expertise Domains

List hard skills/knowledge areas:
- Technical specializations
- Mastered tools/technologies
- Depth indicators (e.g., "deep expertise in X")

**Example:**
```
- System architecture and design patterns
- Performance optimization at scale
- Kubernetes and cloud-native infrastructure
```

### Step 3: Describe Communication Style

Capture interaction patterns:
- Direct or diplomatic?
- Analogies or formal definitions?
- Questions first or solutions first?

**Example:** "Direct and precise. Explains complex concepts via practical analogies. Asks probing questions before proposing solutions. Values clarity over cleverness."

### Step 4: Capture Mindset

Core thinking patterns:
- Favored trade-offs
- Skepticism/enthusiasm areas
- Guiding principles

**Example:**
```
- Pragmatic perfectionist: knows when "good enough" is right
- Thinks in trade-offs, not absolutes
- Protective of team velocity and developer experience
- Skeptical of hype, validated by production evidence
```

### Step 5: Define Focus Areas

What persona naturally notices/prioritizes:

**Example:**
```
- Long-term maintainability over short-term speed
- Clear abstractions and boundaries
- Observable, debuggable systems
```

---

## Include

| Element | Description |
|---------|-------------|
| Expertise markers | Years experience, domain mastery level |
| Character traits | Professional values, cognitive tendencies |
| Soft skills | Communication style, decision-making approach |
| Hard skills | Technical domains, tools, specializations |
| Focus areas | What they notice, prioritize, value |

---

## Exclude

| Excluded | Reason |
|----------|--------|
| How-to instructions | Personas describe *who*, not *how* |
| Methodologies/processes | Belong in agents/skills |
| Rules/guidelines | Prescriptive content contradicts persona purpose |
| Checklists/procedures | Operational, not character content |
| Conditional logic | "If X then Y" belongs in workflows |

---

## Examples

### Good Persona

```markdown
# Persona: Security Architect

Impersonate the following persona.

## Profile
Seasoned security architect, 15 years enterprise systems experience. Recognized expert in threat modeling and defense-in-depth. Background: financial services, healthcare compliance.

## Expertise Domains
- Application security and secure SDLC
- Threat modeling and risk assessment
- Identity and access management
- Compliance frameworks (SOC2, HIPAA, PCI-DSS)

## Communication Style
Precise and evidence-based. Frames security concerns as business risk. Patient with non-security stakeholders. Never alarmist, always thorough.

## Mindset
- Instinctively notices attack vectors in any design
- Assumes breach mentality: plans for when, not if
- Values defense-in-depth over single protection points
- Pragmatic on security trade-offs vs usability

## Focus Areas
- Authentication/authorization boundaries
- Data flow and trust boundaries
- Audit trails and forensic readiness
- Third-party integration risks
```

### Anti-Pattern (Agent Content, Not Persona)

```markdown
# NOT a Persona - This is Agent Content

## Security Review Process
1. Check authentication vulnerabilities
2. Review authorization logic
3. Scan for injection points
4. Check dependency vulnerabilities

## Rules
- All code must pass security scan before merge
- No secrets in code repositories
- Use parameterized queries only
```

---

## Naming Convention

**Location:** `~/.claude/agents/`

**Format:** `agt-persona-[name].md` (kebab-case)

**Examples:**
- `agt-persona-tech-lead.md`
- `agt-persona-security-architect.md`
- `agt-persona-ux-researcher.md`
- `agt-persona-data-engineer.md`

**Rules:**
- Prefix: `agt-persona-`
- Name: kebab-case (lowercase, hyphens)
- Keep concise but descriptive

---

## Validation Checklist

- [ ] Header follows `# Persona: [Role Title]`?
- [ ] Starts with `Impersonate the following persona.`?
- [ ] Describes *who* expert is, not *what* they do?
- [ ] No how-to instructions or step-by-step processes?
- [ ] Focus on character, mindset, expertise markers?
- [ ] Communication style clearly defined?
- [ ] Focus areas about priorities, not procedures?
- [ ] Saved as `~/.claude/agents/agt-persona-[name].md`?

---

## When to Use

**Use Persona when:**
- Need outputs reflecting deep field expertise
- Want consistent voice/perspective across interactions
- Seek expert-level thinking without explicit methodology
- Simulating specific professional perspective

**Use Agent instead when:**
- Need specific task execution with defined steps
- Need process enforcement or rule compliance
- Need conditional logic or workflows

---

## Summary

Persona = character profile influencing Claude's predictions via expertise context. Focus: expert's identity, not methods. Critical distinction: Personas shape output quality through statistical correlation with expert vocabulary, not explicit instruction.

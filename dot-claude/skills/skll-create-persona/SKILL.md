---
name: skll-create-persona
description: Guides creation of Persona files - character profiles that influence model predictions through expert vocabulary and mindset, distinct from agents (which contain instructions/workflows).
---

# Skill: Create Persona

This skill guides you through creating a **Persona** file for Claude Code. A Persona enhances model predictions by providing rich contextual vocabulary and character attributes associated with domain expertise.

---

## Quick Start

To create a persona, you will:
1. Define the expert identity
2. Establish expertise domains
3. Describe soft skills and communication style
4. Capture mindset and character traits
5. Save to `~/.claude/agents/agt-persona-[name].md`

---

## Understanding Personas

### What is a Persona?

A Persona is a **character profile** that influences how Claude predicts and generates responses. It shapes the *voice*, *perspective*, and *expertise depth* of outputs through statistical correlation with expert vocabulary.

### Key Principle

A Persona does NOT teach or instruct. It *embodies* expertise so that predictions naturally align with expert-level discourse. Think of it as describing *who* the expert is, not *what* they do or *how* they do it.

### Persona vs Agent

| Aspect | Persona | Agent |
|--------|---------|-------|
| **Purpose** | Influence prediction patterns through character context | Execute tasks with specific instructions |
| **Content** | Character traits, expertise domains, mindset | Workflows, rules, methodologies |
| **Behavior** | Shapes *how* responses are framed | Defines *what* to do and *how* to do it |

---

## Persona Template

Use this template structure when creating a persona:

```markdown
# [Role Title] Persona

## Profile
[1-3 sentences describing expertise level, years of experience, domain authority, and professional background]

## Expertise Domains
- [Primary domain and specialization]
- [Secondary domain]
- [Additional areas of deep knowledge]
- [Tools and technologies associated with expertise]

## Communication Style
[Describe how this persona communicates: direct/verbose, formal/casual, teaching style, explanation approach. 2-3 sentences]

## Mindset
- [Core professional value or principle]
- [How they approach trade-offs]
- [What they are protective of or skeptical about]
- [Their relationship with pragmatism vs perfectionism]

## Focus Areas
- [What they naturally pay attention to]
- [Quality dimensions they prioritize]
- [Trade-offs they typically favor]
```

---

## Step-by-Step Guide

### Step 1: Define the Profile

Start with a concise description of the expert:
- What is their expertise level? (years, mastery tier)
- What is their domain authority? (specialist, lead, architect)
- What is their professional background?

**Example:**
> "A battle-tested technical lead with 12+ years building distributed systems at scale. Led teams of 8-15 engineers across multiple successful product launches."

### Step 2: Establish Expertise Domains

List the hard skills and knowledge areas:
- Technical specializations
- Tools and technologies they master
- Depth indicators (e.g., "deep expertise in X")

**Good Example:**
```
- System architecture and design patterns
- Performance optimization at scale
- Kubernetes and cloud-native infrastructure
```

### Step 3: Describe Communication Style

Capture how this persona interacts:
- Are they direct or diplomatic?
- Do they explain through analogies or formal definitions?
- Do they ask questions before proposing or lead with solutions?

**Good Example:**
> "Direct and precise. Explains complex concepts through practical analogies. Asks probing questions before proposing solutions. Values clarity over cleverness."

### Step 4: Capture Mindset

This is the core of the persona - their thinking patterns:
- What trade-offs do they favor?
- What are they skeptical or enthusiastic about?
- What principles guide their decisions?

**Good Example:**
```
- Pragmatic perfectionist: knows when "good enough" is right
- Thinks in trade-offs, not absolutes
- Protective of team velocity and developer experience
- Skeptical of hype, validated by production evidence
```

### Step 5: Define Focus Areas

What does this persona naturally notice and prioritize?

**Good Example:**
```
- Long-term maintainability over short-term speed
- Clear abstractions and boundaries
- Observable, debuggable systems
```

---

## What to INCLUDE

| Element | Description |
|---------|-------------|
| **Expertise markers** | Years of experience, domain mastery level |
| **Character traits** | Professional values, cognitive tendencies |
| **Soft skills** | Communication style, decision-making approach |
| **Hard skills** | Technical domains, tools, specializations |
| **Focus areas** | What they notice, prioritize, and value |

---

## What to EXCLUDE

| Excluded Element | Why It Does Not Belong |
|------------------|------------------------|
| **How-to instructions** | Personas describe *who*, not *how* |
| **Methodologies or processes** | These belong in agents or skills |
| **Rules or guidelines** | Prescriptive content contradicts persona purpose |
| **Checklists or procedures** | Operational content, not character content |
| **Conditional logic** | "If X then Y" belongs in workflows |

---

## Examples

### Good Persona Example

```markdown
# Security Architect Persona

## Profile
A seasoned security architect with 15 years experience in enterprise systems. Recognized expert in threat modeling and defense-in-depth strategies. Background includes financial services and healthcare compliance environments.

## Expertise Domains
- Application security and secure SDLC
- Threat modeling and risk assessment
- Identity and access management
- Compliance frameworks (SOC2, HIPAA, PCI-DSS)

## Communication Style
Precise and evidence-based. Frames security concerns in terms of business risk. Patient when explaining to non-security stakeholders. Never alarmist but always thorough.

## Mindset
- Instinctively notices attack vectors in any design
- Assumes breach mentality: plans for when, not if
- Values defense-in-depth over single points of protection
- Pragmatic about security trade-offs vs usability

## Focus Areas
- Authentication and authorization boundaries
- Data flow and trust boundaries
- Audit trails and forensic readiness
- Third-party integration risks
```

### What NOT to Create (Agent Content, Not Persona)

```markdown
# NOT a Persona - This is Agent Content

## Security Review Process
1. First check for authentication vulnerabilities
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

**Format:** `agt-persona-[name].md` (kebab-case name)

**Examples:**
- `agt-persona-tech-lead.md`
- `agt-persona-security-architect.md`
- `agt-persona-ux-researcher.md`
- `agt-persona-data-engineer.md`

**Rules:**
- Must start with `agt-persona-` prefix
- Name portion uses kebab-case (lowercase, hyphens)
- Keep name concise but descriptive

---

## Validation Checklist

Before finalizing your persona, verify:

- [ ] Does it describe *who* the expert is, not *what* they do?
- [ ] Are there no how-to instructions or step-by-step processes?
- [ ] Does it focus on character, mindset, and expertise markers?
- [ ] Is the communication style clearly defined?
- [ ] Are the focus areas about priorities, not procedures?
- [ ] Is the file saved as `~/.claude/agents/agt-persona-[name].md`?

---

## When to Use a Persona

**Use a Persona when:**
- You need outputs reflecting deep expertise in a specific field
- You want consistent voice and perspective across interactions
- You seek expert-level thinking without explicit methodology
- You are simulating a specific professional perspective

**Use an Agent instead when:**
- You need to execute specific tasks with defined steps
- You need process enforcement or rule compliance
- You need conditional logic or workflows

---

## Summary

A Persona is a character profile that influences Claude's predictions through expertise context. Focus on describing the expert's identity, not their methods. The distinction is critical: Personas shape output quality through statistical correlation with expert vocabulary, not through explicit instruction.

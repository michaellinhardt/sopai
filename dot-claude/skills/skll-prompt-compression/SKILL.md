---
name: skll-prompt-compression
description: Optimize AI documents/prompts reducing token consumption while preserving semantic authenticity. Use for prompt compression, token optimization, size reduction, efficiency improvement. Accepts file paths or direct content.
---

# Skill: Prompt Compression

## Purpose

Semantic optimization/prompt compression for agentic AI. Analytical, precise, surgical approach. Preserve original intent.

## Context

Agentic workflow. Autonomous. Rewrite files/folders directly.

## Output

Compress files directly. No confirmation. Process all files.

## Input Modes

1. **File Path:** File/folder path. Compress, overwrite original.
2. **Direct Content:** String content. Write to specified path (default: `compressed-output.md`).

**Examples:**
- `/path/to/prompt.md`
- `/path/to/prompts/`
- `"Prompt text..."` + optional output path

## Mission

Reduce token count, improve accuracy. Guarantee 100% semantic/intentional fidelity.

## Capabilities

- **Compression:** Lexical restructuring, redundancy/filler pruning
- **Semantic Analysis:** Extract core intent, verify fidelity
- **Tokenomics:** LLM cost/performance optimization
- **Technical Writing:** Concise, unambiguous, structured (JSON/YAML/Markdown)

## Protocol Dependency

- **Mandatory:** Use *only* "Prompt Compression Protocol" annex below
- **Modular:** Consult/apply step-by-step per request (allows protocol updates)

## Operating Logic

1. **Fidelity First:** 100% preservation of intent/constraints/format/nuance. Precedence over compression.
2. **Pre-Analysis:** Evaluate before protocol. Refuse if optimal or risky.
3. **Apply Protocol:** Execute annex steps if safe.
4. **Verify:** Fidelity check (Step 5).

## Directives

- Follow protocol sequentially
- Justify non-actions
- Markdown output
- Compression only (no augmentation)
- Rewrite files directly

## Constraints

- **Strictly** follow annex protocol
- **Never** modify if semantic integrity uncertain
- **Never** invent/hallucinate
- **Return** original if no safe compression

---

# Annex: Prompt Compression Protocol

**Objective:** Reduce tokens. 100% preservation of intent/meaning/constraints/output. Fidelity > compression.

**Procedure:** Execute sequentially.

## Step 1: Lexical/Structural Reconstruction

Reformat for token efficiency. Preserve meaning.

- Locate prose instructions
- Convert to structured formats:
  - Bullet/numbered lists
  - JSON/YAML schemas
- Use keywords/abbreviations:
  - "I would like you to provide me with a summary of..." -> "Summarize:"
  - Standard abbrevs (e.g., i.e., NLP, JSON)

## Step 2: Redundancy Pruning

Remove low-information tokens.

- Remove fillers ("please," "if you could")
- Prune redundant descriptors ("very detailed, comprehensive, and long" -> "detailed")
- Consolidate repeated constraints
- Preserve syntactic integrity

## Step 3: Context/Example Compression (Caution)

For large example/context blocks only.

- **Factual context:** Extract critical sentences verbatim (no rewrite)
- **Stylistic context:** Abstractive summarization (paraphrase essence)
  - Risk: hallucination/drift. Use sparingly.

## Step 4: Hierarchical Condensation

For extremely long context:

1. Segment into logical chunks
2. Summarize each chunk
3. Concatenate summaries
4. Generate master summary (replaces original)

## Step 5: Fidelity Check (Mandatory)

Final validation:

1. Compare original vs compressed
2. Verify: intent identical?
3. Verify: all constraints present?
4. Check: nuance/tone preserved?
5. If loss detected: revert, accept less compression. **Fidelity primary.**

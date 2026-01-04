# Documentation Framework for AI Agent Collaboration

## Specification Report

---

## 1. Problem Statement

**Core challenge:** AI agents have limited context windows. Loading entire project documentation at once is inefficient and counterproductive.

**Goal:** Create a modular, interconnected documentation system that:
- Splits documentation into smaller, focused files
- Connects information through a trackable linking system
- Provides "just enough" context for any task (not more, not less)
- Enables multiple AI agents to collaborate on the same project
- Tracks dependencies for safe deletion/refactoring

---

## 2. Chosen Approach

### Method: Zettelkasten + IDs (Ranked #1)

**Why chosen:**
- Atomic note structure maps perfectly to "one feature, one file"
- Explicit ID wrapping (`[[FEAT-XXX]]`) is easy to parse with regex
- Flat by default, hierarchy possible through naming
- Simplest to implement as a tool
- Battle-tested methodology

**Implementation:** Tool-based (not MCP)

### Alternative Methods Considered

| Rank | Method | Verdict |
|------|--------|---------|
| 🥇 | Zettelkasten + IDs | **Chosen** - simplest, matches original vision |
| 🥈 | Graph Database | Good for complex projects (50+ features), overkill otherwise |
| 🥉 | Wiki Backlinks | Auto-tracking is nice, but name-based linking is fragile |
| - | ADRs | For decisions, not features - different mental model |
| - | Docusaurus/MkDocs | Too rigid, relative paths break on refactor |
| - | Monorepo style | Only works if feature = package |

---

## 3. File Structure

### Chosen: Flat Folder + One File Per Feature + Sections

```
/docs
  _overview.md              ← Always loaded first (project map + patterns)
  _map.json                 ← Machine-readable index with tags/relationships
  _glossary.md              ← Optional: terminology definitions
  
  FEAT-001-authentication.md
  FEAT-002-password-reset.md
  FEAT-003-user-profile.md
  FEAT-004-file-storage.md
  FEAT-005-user-settings.md
  ...
```

**Why flat folder:**
- Simpler tooling
- No deep navigation
- All features visible at once

**Why one file per feature:**
- One file = one mental unit
- Human-readable without tooling
- No decision fatigue about file placement

**Why sections within file:**
- Tool can parse and load specific sections only
- Enables cross-cutting queries ("all database schemas")
- Keeps related information together

---

## 4. Feature File Template

```markdown
# Feature Name [[FEAT-XXX]]

## META
- Status: draft | in-progress | stable | deprecated
- Owner: team-name
- Related: [[FEAT-YYY]], [[FEAT-ZZZ]]

## FUNCTIONAL
Business perspective: what the feature does, user stories, business rules.

## TECHNICAL
Implementation perspective: how it works, architecture decisions, code patterns.

## DATABASE
Tables, schemas, relationships, migrations.

### Tables
- `table_name` (column1, column2, ...)

### Relationships
...

## API
Endpoints, request/response formats, authentication requirements.

### POST /endpoint
...

## UI
Screens, components, user flows, design notes.

## DEPENDENCIES
External services, libraries, third-party integrations.

## TESTING
Test scenarios, edge cases, coverage notes.
```

### Section Reference

| Section | Purpose | Include When |
|---------|---------|--------------|
| **META** | Status, owner, relationships | Always |
| **FUNCTIONAL** | What it does (business) | Always |
| **TECHNICAL** | How it works (implementation) | Always |
| **DATABASE** | Tables, schemas | Feature touches DB |
| **API** | Endpoints, contracts | Feature has API |
| **UI** | Screens, components | Feature has frontend |
| **DEPENDENCIES** | External services | Has external deps |
| **TESTING** | Test scenarios | Optional but useful |

---

## 5. ID System

### Format
```
[[FEAT-XXX-000]]        → Feature reference
[[FEAT-XXX-000#section]] → Specific section (optional)
```

### Examples
```
[[FEAT-001]]            → Authentication feature
[[FEAT-001#database]]   → Database section of authentication
[[FEAT-002]]            → Password reset feature
```

### Rules
- Every feature gets a unique ID
- IDs are wrapped in double brackets for easy regex parsing
- When mentioning another feature in documentation, always use its ID
- Tool parses all IDs and builds relationship metadata automatically

---

## 6. Map File Specification

**File:** `_map.json`

```json
{
  "features": {
    "FEAT-001": {
      "name": "Authentication",
      "description": "User login, logout, session management",
      "tags": ["user", "auth", "login", "session", "security"],
      "file": "FEAT-001-authentication.md",
      "sections": ["meta", "functional", "technical", "database", "api"],
      "status": "stable",
      "related": ["FEAT-002", "FEAT-003"]
    },
    "FEAT-002": {
      "name": "Password Reset",
      "description": "Forgot password flow, reset tokens",
      "tags": ["password", "reset", "email", "security"],
      "file": "FEAT-002-password-reset.md",
      "sections": ["meta", "functional", "technical", "api"],
      "status": "stable",
      "related": ["FEAT-001"]
    }
  },
  "section_types": [
    "meta",
    "functional", 
    "technical",
    "database",
    "api",
    "ui",
    "dependencies",
    "testing"
  ]
}
```

### Map File Purpose
- Machine-readable index of all features
- Tags enable keyword-based discovery
- Tracks which sections exist per feature
- Stores relationships (bidirectional awareness)
- Tool uses this internally for queries

---

## 7. Overview File Specification

**File:** `_overview.md`

**Purpose:** Solves the "cold start problem" - how does an agent know which features to load for a new task?

```markdown
# Project Overview

## Architecture Summary
Brief description of tech stack and high-level architecture.

## Feature Categories

### Category Name (e.g., User Management)
- [[FEAT-001]] Authentication - login, logout, session
- [[FEAT-002]] Password Reset - forgot password flow
- [[FEAT-003]] User Profile - profile data, avatar

### Category Name (e.g., Infrastructure)
- [[FEAT-004]] File Storage - handles all file uploads
- [[FEAT-010]] Email Service - transactional emails

## Common Patterns

### Pattern Name (e.g., Adding File Upload to a Feature)
1. Check [[FEAT-004]] File Storage for upload API
2. Identify which feature owns the data
3. Check UI feature for where it appears

### Pattern Name (e.g., Adding New API Endpoint)
1. Check [[FEAT-050]] API Standards for conventions
2. ...

## Cross-Cutting Concerns
- All images go through [[FEAT-004]] File Storage
- All user-facing pages use [[FEAT-060]] Design System
- All database changes require [[FEAT-070]] DB Migrations
```

### Overview File Rules
- Agent ALWAYS loads this first before any task
- Provides mental map of entire project
- Common patterns guide agent to relevant features
- Cross-cutting concerns prevent missed dependencies

---

## 8. Tool Behavior Specification

### Supported Queries

| Query | Returns |
|-------|---------|
| `get_overview()` | Full `_overview.md` content |
| `get_map()` | Full `_map.json` content |
| `get_doc("FEAT-001")` | Full feature file |
| `get_doc("FEAT-001", sections=["technical"])` | Only TECHNICAL section |
| `get_doc("FEAT-001", sections=["technical", "database"])` | Multiple sections |
| `get_docs_by_section("database")` | DATABASE section from all features |
| `get_doc("FEAT-001", with_related=true)` | Feature + all related features |
| `get_doc("FEAT-001", sections=["technical"], with_related=true)` | Technical sections of feature + related |
| `search_features(tags=["upload", "image"])` | Features matching tags |
| `get_references("FEAT-001")` | All features that reference FEAT-001 |

### Tool Responsibilities
1. Parse files for `[[FEAT-XXX]]` patterns on every write
2. Update `_map.json` relationships automatically
3. Serve context bundles based on queries
4. Validate ID format on documentation changes
5. Report orphaned references when features are deleted

---

## 9. Agent Workflow

### Standard Task Workflow

```
STEP 1: LOAD OVERVIEW
├── Tool: get_overview()
├── Returns: Project structure, categories, patterns
└── Agent builds mental map of project

STEP 2: IDENTIFY RELEVANT FEATURES
├── Agent reads task: "Implement upload profile picture in settings"
├── Agent checks Common Patterns in overview
├── Agent identifies: FEAT-003, FEAT-004, FEAT-005
└── Agent determines which sections needed

STEP 3: LOAD SPECIFIC DOCUMENTATION
├── Tool: get_doc("FEAT-004", sections=["technical", "api"])
├── Tool: get_doc("FEAT-003", sections=["database"])
├── Tool: get_doc("FEAT-005", sections=["technical", "ui"])
└── Agent now has exactly needed context

STEP 4: IMPLEMENT
├── Agent works with focused context
├── Agent references other features using [[FEAT-XXX]] format
└── Agent saves work

STEP 5: UPDATE DOCUMENTATION (if needed)
├── Agent updates relevant feature docs
├── Tool parses new [[FEAT-XXX]] references
└── Tool updates _map.json relationships
```

### System Prompt Instructions for Agents

```markdown
## Documentation Protocol

1. **Always start with overview**: Before any task, call get_overview() to understand project structure

2. **Reference features by ID**: Use [[FEAT-XXX]] format when mentioning any feature in documentation

3. **Request minimal context**: Only load sections you need, not entire files

4. **Check common patterns**: Overview contains patterns for common tasks - follow them

5. **Update docs when implementing**: If you create or modify features, update the corresponding documentation

6. **Before deleting a feature**: Query get_references("FEAT-XXX") to understand impact
```

---

## 10. Key Design Decisions Summary

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Folder structure | Flat | Simpler tooling, all features visible |
| File granularity | One file per feature | One mental unit, human-readable |
| Aspect handling | Sections within file | Tool parses them, enables cross-queries |
| Linking method | ID-based `[[FEAT-XXX]]` | Easy regex, explicit, unambiguous |
| Discovery method | Overview file + tags | Solves cold start, enables keyword search |
| Tool vs MCP | Tool | Simpler, no server infrastructure needed |
| Relationship tracking | Automatic via parsing | Tool extracts IDs on every write |

---

## 11. File Checklist for New Projects

```
/docs
  □ _overview.md          (create first - project map)
  □ _map.json             (can be auto-generated initially)
  □ _glossary.md          (optional - domain terms)
  □ FEAT-001-*.md         (first feature)
  □ ...
```

### Minimum Viable Setup
1. Create `_overview.md` with architecture summary and initial feature list
2. Create `_map.json` with first features indexed
3. Create first feature file using template
4. Implement tool with basic `get_overview()` and `get_doc()` functions
5. Add automatic ID parsing and relationship tracking

---

## 12. Next Steps

1. **Design tool API** - Define exact function signatures and response formats
2. **Create file templates** - Starter templates for overview, map, and feature files
3. **Implement parser** - Regex for `[[FEAT-XXX]]` extraction
4. **Build relationship tracker** - Update map on doc changes
5. **Test with sample project** - Validate with real feature set
6. **Write agent instructions** - System prompt for documentation protocol

---

*Report generated from conversation on 2025-01-04*
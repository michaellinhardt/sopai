# sopai - Project Overview

## Summary

**Name:** sopai
**Type:** CLI tool (npm global package)
**Purpose:** Dev Framework For AI Agent
**Repository:** github.com/michaellinhardt/sopai
**Entry Point:** `src/index.js`
**License:** MIT

## Description

sopai is a development framework designed to enhance AI agent workflows, particularly with Claude Code. It provides CLI commands and configuration structures that help orchestrate multi-agent workflows, manage context, and streamline AI-assisted development.

## Architecture

```
sopai/
├── src/
│   └── index.js          # CLI entry point
├── dot-claude/           # Claude Code configuration templates
│   └── CLAUDE.md         # Workflow orchestration instructions
├── docs/                 # Documentation
└── package.json          # npm package configuration
```

## Key Concepts

### dot-claude Configuration

The `dot-claude/` folder contains Claude Code configuration files that define:

- **Workflow orchestration rules** for multi-agent systems
- **Agent file management** conventions (agts folder, naming)
- **Context optimization** directives
- **Sequence execution** patterns

When initialized, these files are symlinked to `~/.claude/` to configure Claude Code behavior globally.

### Workflow System

The framework implements a structured workflow system:

1. **Workflow Folder:** `./agts/wkf.[timestamp]/` stores workflow artifacts
2. **Context Files:** `*.context.md` track workflow state and reports
3. **Sequences:** Modular workflow segments executed conditionally
4. **File Naming:** `[index].[name].[type].md` convention for organization

### Agent Files (AGT)

Non-project files generated during workflows:
- Memory and state persistence
- Workflow reports and plans
- Sub-agent communication artifacts

Located in `./agts/` to separate from project source code.

## CLI Commands

### Current

```bash
sopai              # Display help/info
```

### Planned

```bash
sopai init         # Link dot-claude/ to ~/.claude/
```

The `init` command will:
- Create symlinks from `dot-claude/` contents to `~/.claude/`
- Handle existing links gracefully (skip without error)
- Support dynamic linking of new files on subsequent runs

## Claude Code Integration

sopai integrates with Claude Code by:

1. **Configuration Distribution:** `dot-claude/CLAUDE.md` provides workflow instructions to Claude Code via symlink to `~/.claude/CLAUDE.md`
2. **Workflow Standards:** Defines consistent patterns for multi-agent orchestration
3. **Context Management:** Provides conventions for managing AI context windows efficiently

## Installation

```bash
npm install -g sopai
```

## Usage Pattern

1. Install sopai globally
2. Run `sopai init` in a project to link configurations
3. Use Claude Code with workflow-aware instructions
4. Workflows create artifacts in `./agts/` folder

## For AI Agents

When working with sopai projects:

- Check for `./agts/` folder for workflow context
- Read `CLAUDE.md` for orchestration instructions
- Follow file naming conventions for AGT files
- Use sequences for modular workflow execution
- Optimize context window by reading files partially when classifying

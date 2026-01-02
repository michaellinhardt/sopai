# sopai init

## Overview

The `sopai init` command links Claude Code configuration files from the project's `dot-claude/` folder to the user's home directory `~/.claude/`.

This enables project-specific Claude Code configurations to be version-controlled within the repository while being accessible system-wide by Claude Code.

## Purpose

- **Configuration Sharing**: Share Claude Code settings across team members via version control
- **Project-Specific Setup**: Each project can define its own Claude Code configuration
- **Easy Onboarding**: New contributors run `sopai init` to get the project's Claude settings

## Quick Start

```bash
# Install sopai globally
npm install -g sopai

# Navigate to your project
cd your-project

# Initialize Claude Code configuration
sopai init
```

## How It Works

1. Scans the `dot-claude/` folder in your project root
2. Creates `~/.claude/` directory if it doesn't exist
3. Creates symbolic links for each item in `dot-claude/` to `~/.claude/`
4. Skips items that are already correctly linked
5. Reports linked and skipped items

## Documentation

- [Functional Documentation](./functional.md) - User-facing behavior, use cases, expected outputs
- [Technical Documentation](./technical.md) - Implementation details, algorithm, error handling

## Example

Given a project structure:
```
your-project/
  dot-claude/
    CLAUDE.md
    settings.json
    commands/
      custom-command.md
```

Running `sopai init` creates:
```
~/.claude/
  CLAUDE.md -> your-project/dot-claude/CLAUDE.md
  settings.json -> your-project/dot-claude/settings.json
  commands/ -> your-project/dot-claude/commands/
```

## Related

- [Project Overview](../project.md)

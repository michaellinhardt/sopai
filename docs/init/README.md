# sopai init

## Overview

The `sopai init` command links Claude Code configuration files from the **sopai npm package's built-in `dot-claude/` folder** to the user's home directory `~/.claude/`.

This is a global command that works from anywhere - it always links the configuration files bundled with the sopai package itself.

## Purpose

- **Standardized Setup**: Provides consistent Claude Code configuration from the sopai package
- **Global Command**: Run from any directory - no project-specific folder required
- **Easy Installation**: Single command to set up Claude Code with sopai's default configuration

## Quick Start

```bash
# Install sopai globally
npm install -g sopai

# Initialize Claude Code configuration (run from anywhere)
sopai init
```

## How It Works

1. Locates the `dot-claude/` folder within the sopai package installation directory
2. Creates `~/.claude/` directory if it doesn't exist
3. Creates symbolic links for each item in the package's `dot-claude/` to `~/.claude/`
4. Skips items that are already correctly linked
5. Reports linked and skipped items

## Documentation

- [Functional Documentation](./functional.md) - User-facing behavior, use cases, expected outputs
- [Technical Documentation](./technical.md) - Implementation details, algorithm, error handling

## Example

The sopai package contains:
```
sopai/                          # npm package installation
  dot-claude/
    CLAUDE.md
    settings.json
    commands/
      custom-command.md
```

Running `sopai init` (from any directory) creates:
```
~/.claude/
  CLAUDE.md -> /path/to/sopai/dot-claude/CLAUDE.md
  settings.json -> /path/to/sopai/dot-claude/settings.json
  commands/ -> /path/to/sopai/dot-claude/commands/
```

## Related

- [Project Overview](../project.md)

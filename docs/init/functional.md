# Functional Documentation: sopai init

## Command Syntax

```bash
sopai init
```

No arguments or flags required. This is a global command that works from any directory.

## User-Facing Behavior

### Prerequisites

1. sopai must be installed globally via npm (`npm install -g sopai`)
2. The sopai package includes a `dot-claude/` folder with default configuration

### Execution Flow

1. **Locate Source**: Command finds the `dot-claude/` folder within the sopai package installation
2. **Directory Creation**: Creates `~/.claude/` if it doesn't exist
3. **Scanning**: Reads all items (files and folders) in the package's `dot-claude/`
4. **Linking**: Creates symbolic links for each item to `~/.claude/`
5. **Reporting**: Outputs summary of actions taken

## Use Cases

### Use Case 1: First-Time Setup

**Scenario**: Developer installs sopai and wants to set up Claude Code configuration.

**Steps**:
1. Install sopai globally: `npm install -g sopai`
2. Run `sopai init` (from any directory)

**Expected Output**:
```
sopai init - Linking Claude Code configuration

Created directory: ~/.claude/
Linked: CLAUDE.md -> ~/.claude/CLAUDE.md
Linked: settings.json -> ~/.claude/settings.json
Linked: commands/ -> ~/.claude/commands/

Summary: 3 items linked, 0 skipped
```

### Use Case 2: Re-Running After Package Update

**Scenario**: sopai package is updated with new configuration files, user re-runs init.

**Steps**:
1. Update sopai: `npm update -g sopai`
2. Run `sopai init`

**Expected Output**:
```
sopai init - Linking Claude Code configuration

Skipped (already linked): CLAUDE.md
Skipped (already linked): settings.json
Linked: new-config.json -> ~/.claude/new-config.json

Summary: 1 item linked, 2 skipped
```

### Use Case 3: Re-Running Without Changes

**Scenario**: User runs `sopai init` when everything is already linked.

**Expected Output**:
```
sopai init - Linking Claude Code configuration

Skipped (already linked): CLAUDE.md
Skipped (already linked): settings.json

Summary: 0 items linked, 2 skipped
All configuration already linked.
```

### Use Case 4: Permission Error

**Scenario**: User lacks permission to create `~/.claude/` or symlinks.

**Expected Output**:
```
sopai init - Linking Claude Code configuration

Error: Permission denied - Unable to create ~/.claude/
Please check your permissions or run with appropriate privileges.
```

**Exit Code**: 1

### Use Case 5: Conflicting File Exists

**Scenario**: A regular file (not symlink) already exists at target location.

**Expected Output**:
```
sopai init - Linking Claude Code configuration

Warning: ~/.claude/CLAUDE.md exists and is not a symlink
  - Backup or remove it manually to allow linking
Linked: settings.json -> ~/.claude/settings.json

Summary: 1 item linked, 0 skipped, 1 warning
```

## Expected Outputs

### Success Messages

| Situation | Message Format |
|-----------|----------------|
| Directory created | `Created directory: ~/.claude/` |
| Item linked | `Linked: {name} -> ~/.claude/{name}` |
| Item skipped | `Skipped (already linked): {name}` |
| All done | `Summary: X items linked, Y skipped` |

### Error Messages

| Situation | Message Format |
|-----------|----------------|
| Permission denied | `Error: Permission denied - {details}` |
| Generic error | `Error: {error message}` |

### Warning Messages

| Situation | Message Format |
|-----------|----------------|
| File exists (not symlink) | `Warning: ~/.claude/{name} exists and is not a symlink` |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success (all items linked or skipped) |
| 1 | Error (permission denied, etc.) |

## Behavior Rules

1. **Idempotent**: Running multiple times produces the same result
2. **Non-destructive**: Never overwrites existing files that aren't symlinks
3. **Graceful**: Continues processing after skips/warnings
4. **Informative**: Always reports what was done

## Files Linked

The command links all items in `dot-claude/` including:

- `CLAUDE.md` - Main Claude Code instructions
- `settings.json` - Claude Code settings
- `commands/` - Custom slash commands directory
- Any other files or folders added to `dot-claude/`

## Symlink Details

- **Type**: Symbolic links (soft links)
- **Direction**: `~/.claude/{item}` -> `{sopai-package}/dot-claude/{item}`
- **Resolution**: Absolute paths for reliability

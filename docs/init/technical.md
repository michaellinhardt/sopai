# Technical Documentation: sopai init

## Implementation Overview

The `sopai init` command is implemented in Node.js as part of the sopai CLI tool. It uses native Node.js modules for file system operations and cross-platform compatibility.

## Dependencies

### Node.js Built-in Modules

```javascript
const fs = require('fs');
const path = require('path');
const os = require('os');
```

### Module Purposes

| Module | Purpose |
|--------|---------|
| `fs` | File system operations (symlink, lstat, readdir, mkdir) |
| `path` | Cross-platform path manipulation |
| `os` | Get user home directory |

## File Structure

```
src/
  index.js          # CLI entry point with command routing
  commands/
    init.js         # sopai init implementation
```

## Algorithm

### Main Flow

```
1. START
2. Get source directory: process.cwd() + '/dot-claude'
3. Get target directory: os.homedir() + '/.claude'
4. Validate source exists
   - If not: print error, exit(1)
5. Create target directory if not exists
   - mkdir(targetDir, { recursive: true })
6. Read source directory contents
   - fs.readdirSync(sourceDir)
7. For each item in source:
   a. Compute source path: sourceDir + '/' + item
   b. Compute target path: targetDir + '/' + item
   c. Check if target exists:
      - If symlink pointing to source: skip (already linked)
      - If regular file/dir: warn, continue
      - If not exists: create symlink
8. Print summary
9. END (exit 0)
```

### Pseudocode

```javascript
async function init() {
  const cwd = process.cwd();
  const sourceDir = path.join(cwd, 'dot-claude');
  const targetDir = path.join(os.homedir(), '.claude');

  // Validate source
  if (!fs.existsSync(sourceDir)) {
    console.error('Error: No dot-claude/ folder found');
    process.exit(1);
  }

  // Create target directory
  if (!fs.existsSync(targetDir)) {
    fs.mkdirSync(targetDir, { recursive: true });
    console.log(`Created directory: ${targetDir}`);
  }

  // Process items
  const items = fs.readdirSync(sourceDir);
  let linked = 0;
  let skipped = 0;
  let warnings = 0;

  for (const item of items) {
    const sourcePath = path.join(sourceDir, item);
    const targetPath = path.join(targetDir, item);

    const result = await linkItem(sourcePath, targetPath, item);
    if (result === 'linked') linked++;
    else if (result === 'skipped') skipped++;
    else if (result === 'warning') warnings++;
  }

  // Print summary
  console.log(`\nSummary: ${linked} items linked, ${skipped} skipped`);
}
```

## Core Functions

### 1. linkItem(sourcePath, targetPath, itemName)

Creates a symlink from targetPath to sourcePath, handling existing items.

```javascript
async function linkItem(sourcePath, targetPath, itemName) {
  try {
    // Check if target already exists
    const targetExists = fs.existsSync(targetPath);

    if (targetExists) {
      const stats = fs.lstatSync(targetPath);

      if (stats.isSymbolicLink()) {
        // Check if symlink points to our source
        const linkTarget = fs.readlinkSync(targetPath);
        if (linkTarget === sourcePath) {
          console.log(`Skipped (already linked): ${itemName}`);
          return 'skipped';
        }
      }

      // File/dir exists but is not our symlink
      console.log(`Warning: ${targetPath} exists and is not a symlink`);
      console.log(`  - Backup or remove it manually to allow linking`);
      return 'warning';
    }

    // Create symlink
    fs.symlinkSync(sourcePath, targetPath);
    console.log(`Linked: ${itemName} -> ${targetPath}`);
    return 'linked';

  } catch (error) {
    console.error(`Error linking ${itemName}: ${error.message}`);
    return 'error';
  }
}
```

### 2. isAlreadyLinked(targetPath, expectedSource)

Checks if a symlink exists and points to the expected source.

```javascript
function isAlreadyLinked(targetPath, expectedSource) {
  try {
    const stats = fs.lstatSync(targetPath);
    if (!stats.isSymbolicLink()) {
      return false;
    }
    const actualTarget = fs.readlinkSync(targetPath);
    return actualTarget === expectedSource;
  } catch (error) {
    return false;
  }
}
```

## Error Handling

### Error Types and Handling

| Error | Code | Handling |
|-------|------|----------|
| Source folder not found | `ENOENT` | Print error, exit(1) |
| Permission denied (read) | `EACCES` | Print error, exit(1) |
| Permission denied (write) | `EACCES` | Print error, exit(1) |
| Symlink creation failed | Various | Print warning, continue |
| File exists at target | - | Print warning, skip item |

### Error Messages

```javascript
const ERROR_MESSAGES = {
  NO_SOURCE: 'Error: No dot-claude/ folder found in current directory.\nCreate a dot-claude/ folder with your Claude Code configuration files.',
  PERMISSION_DENIED: 'Error: Permission denied - {details}\nPlease check your permissions or run with appropriate privileges.',
  GENERIC: 'Error: {message}'
};
```

## Cross-Platform Considerations

### Path Handling

```javascript
// Always use path.join for cross-platform compatibility
const targetDir = path.join(os.homedir(), '.claude');

// Never hardcode path separators
// BAD:  const targetDir = os.homedir() + '/.claude';
// GOOD: const targetDir = path.join(os.homedir(), '.claude');
```

### Symlink Types (Windows)

On Windows, symlink type matters:

```javascript
// Detect if source is directory or file
const isDirectory = fs.statSync(sourcePath).isDirectory();

// On Windows, specify type for directories
if (process.platform === 'win32' && isDirectory) {
  fs.symlinkSync(sourcePath, targetPath, 'dir');
} else {
  fs.symlinkSync(sourcePath, targetPath);
}
```

### Home Directory

```javascript
// Use os.homedir() for cross-platform home directory
const homeDir = os.homedir();
// Returns: '/Users/username' (macOS), '/home/username' (Linux), 'C:\Users\username' (Windows)
```

## Code Structure

### Entry Point (src/index.js)

```javascript
#!/usr/bin/env node

const args = process.argv.slice(2);
const command = args[0];

switch (command) {
  case 'init':
    require('./commands/init')();
    break;
  default:
    console.log('Usage: sopai <command>');
    console.log('Commands:');
    console.log('  init    Link Claude Code configuration');
    process.exit(1);
}
```

### Init Command (src/commands/init.js)

```javascript
const fs = require('fs');
const path = require('path');
const os = require('os');

module.exports = async function init() {
  console.log('sopai init - Linking Claude Code configuration\n');

  const cwd = process.cwd();
  const sourceDir = path.join(cwd, 'dot-claude');
  const targetDir = path.join(os.homedir(), '.claude');

  // Implementation here...
};
```

## Testing

### Manual Test Cases

1. **Fresh install**: Remove `~/.claude/`, run `sopai init`
2. **Re-run**: Run `sopai init` twice consecutively
3. **Add new file**: Add file to `dot-claude/`, run `sopai init`
4. **Conflicting file**: Create regular file in `~/.claude/`, run `sopai init`
5. **Missing source**: Run from directory without `dot-claude/`
6. **Permission test**: Test with read-only home directory

### Verification Commands

```bash
# Check if symlinks were created correctly
ls -la ~/.claude/

# Verify symlink targets
readlink ~/.claude/CLAUDE.md

# Test idempotency
sopai init && sopai init
```

## Implementation Checklist

For implementing agents, verify these requirements:

- [ ] Uses `fs` module for file operations
- [ ] Uses `path.join()` for all path construction
- [ ] Uses `os.homedir()` for home directory
- [ ] Checks symlink existence with `fs.lstatSync()` and `isSymbolicLink()`
- [ ] Reads symlink target with `fs.readlinkSync()`
- [ ] Creates symlinks with `fs.symlinkSync()`
- [ ] Creates directory with `fs.mkdirSync(targetDir, { recursive: true })`
- [ ] Handles all error cases gracefully
- [ ] Prints appropriate messages for each action
- [ ] Returns exit code 0 on success, 1 on error
- [ ] Continues processing after warnings/skips
- [ ] Uses absolute paths for symlink targets

## Complete Implementation Reference

```javascript
// src/commands/init.js
const fs = require('fs');
const path = require('path');
const os = require('os');

function isAlreadyLinked(targetPath, expectedSource) {
  try {
    const stats = fs.lstatSync(targetPath);
    if (!stats.isSymbolicLink()) return false;
    return fs.readlinkSync(targetPath) === expectedSource;
  } catch {
    return false;
  }
}

function linkItem(sourcePath, targetPath, itemName) {
  try {
    if (fs.existsSync(targetPath)) {
      if (isAlreadyLinked(targetPath, sourcePath)) {
        console.log(`Skipped (already linked): ${itemName}`);
        return 'skipped';
      }
      console.log(`Warning: ~/.claude/${itemName} exists and is not a symlink`);
      console.log(`  - Backup or remove it manually to allow linking`);
      return 'warning';
    }

    const isDir = fs.statSync(sourcePath).isDirectory();
    if (process.platform === 'win32' && isDir) {
      fs.symlinkSync(sourcePath, targetPath, 'dir');
    } else {
      fs.symlinkSync(sourcePath, targetPath);
    }
    console.log(`Linked: ${itemName} -> ~/.claude/${itemName}`);
    return 'linked';
  } catch (error) {
    if (error.code === 'EACCES') {
      console.error(`Error: Permission denied - Unable to link ${itemName}`);
    } else {
      console.error(`Error linking ${itemName}: ${error.message}`);
    }
    return 'error';
  }
}

module.exports = function init() {
  console.log('sopai init - Linking Claude Code configuration\n');

  const cwd = process.cwd();
  const sourceDir = path.join(cwd, 'dot-claude');
  const targetDir = path.join(os.homedir(), '.claude');

  // Validate source directory
  if (!fs.existsSync(sourceDir)) {
    console.error('Error: No dot-claude/ folder found in current directory.');
    console.error('Create a dot-claude/ folder with your Claude Code configuration files.');
    process.exit(1);
  }

  // Create target directory
  try {
    if (!fs.existsSync(targetDir)) {
      fs.mkdirSync(targetDir, { recursive: true });
      console.log(`Created directory: ~/.claude/`);
    }
  } catch (error) {
    if (error.code === 'EACCES') {
      console.error('Error: Permission denied - Unable to create ~/.claude/');
      console.error('Please check your permissions or run with appropriate privileges.');
    } else {
      console.error(`Error: ${error.message}`);
    }
    process.exit(1);
  }

  // Process items
  const items = fs.readdirSync(sourceDir);
  let linked = 0, skipped = 0, warnings = 0;

  for (const item of items) {
    const sourcePath = path.join(sourceDir, item);
    const targetPath = path.join(targetDir, item);
    const result = linkItem(sourcePath, targetPath, item);

    if (result === 'linked') linked++;
    else if (result === 'skipped') skipped++;
    else if (result === 'warning') warnings++;
  }

  // Summary
  const parts = [`${linked} items linked`, `${skipped} skipped`];
  if (warnings > 0) parts.push(`${warnings} warnings`);
  console.log(`\nSummary: ${parts.join(', ')}`);

  if (linked === 0 && skipped > 0) {
    console.log('All configuration already linked.');
  }
};
```

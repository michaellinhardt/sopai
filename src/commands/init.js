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

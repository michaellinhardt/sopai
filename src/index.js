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
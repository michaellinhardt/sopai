# Skill Description: Docs Skill

This skill centralize project documentation. It comes with a framework on how to use the documentation for a development project.

The skill instruct the agent on how to use the tool that comes with the skill ( a script ).

Below we describe the script (tool) that will be added to the skill, we work mainly on the tool now.

## Folder `./docs`

The tool works on the folder `./docs` of the current project and manage all the content of this folder. No agents write or read it, it all passes by the tool.

## SQLite

The tool use SQLite to manage meta data about every files inside the folder. The SQLite file is generated in `./docs` its namede `DocsTool` ( with proper extension ).

## Folder `./docs/inputs`

When the tool receive a command. If the const SAVE_INPUTS is on, it always save the entire parameters he received in `./docs/inputs/[timestamp unix].input.md` This for debug

## Auto generate asset

When ./docs or the SQL file does not exist, the tool when used, generates it.

## List of command from the tool

- One command to obtain the 

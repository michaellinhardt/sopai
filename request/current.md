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

## Challenges

When creating or editing new docs, the model should have means to know if any related docs already exist or even maybe there is docs on the feature already. It needs a way to search existing content.

## Auto generate asset

When ./docs or the SQL file does not exist, the tool when used, generates it.

## Files Metadata

Each files have metadata associated and saved in the SQLite.

description: [one sentence describing the file, to help agent to know if they need it or not]
sections: a sections ID, from available sections ID, each file have one from the list
path: [file path]

### Meta Data Example

```json
[{
    id: "123123",
    path: "./file/path.md",
    description: "the description",
    sections: "functional",
},{
    id: "123123",
    path: "./file/path.md",
    description: "the description",
    sections: "database",
}]
```

## Files Map Metadata

The relationship between files is stored in a separate table.
We create links between feature.


## Sections

Default sesctions are:

- functional: functional documentation
- technical: technical documentation
- architecture: code/folders, design pattern, architecture etc..
- ui-ux: related to ui or ux
- database: related to database structure, tables etc..
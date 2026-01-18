Use: @workflow.study.tmp.md

We work on `~/.claude/CLAUDE.md`

  The Orchestrator MUST use the task tool as follow, but not only, if requested by user, other task can
  be listed.

  I dont want the task to be related to header anymore.

  The Orchestrator will create one task per clear action instructed in the request, or per action planned to do by itself.

  It also create task for every clear actio instructed to sub agent, with prefix `01 `. The number is the subagent id, start 1, increment for each new. If one subagent have multiple task, they are listed with the same id

  What task to create ? One per main action to do in the header section.

  Example:

  ```request input
  ## Research

  SubAgent: `agt-tech-lean`
  Output: `file.md`

  Research the Ralph method

  Write a report in file.md

  ### Review

  Sub Agent
  Output: review.md

  Review the file
  ```

  ```task
  [ ] 01. online research on Ralph method
  [ ] 01. write report on ralph method
  [ ] 02. review the report
  ```

  When Orchestrator wait for parallel subagent to finish:

  - Clear all task
  - Create a new task list, one per sub agent '#1: ' with what they are doing (number as id for agent). You
  list all main task per subagent, example:

  ```task
  [x] 01. online research on tomato
  [ ] 01. write analysis on tomato
  [x] 02. online research on tomato
  [x] 02. write analysis on tomato
  ```

  Visually, we Orchestrator wait for parallel agent to all complete, we should see the list of task of those sub agent. Do not use any method to track the status that would consume token, such as a bash loop to sleep and check result. If the subagent is busy, wait for it to finish and inform you. 

  - if possible for the sub agent to use the same task tool, it should be instructed to complete the task or add task itself !

  OK so new idea ! when the orchestrator wait for sub agent to finish (one or many) without having anything to do: the orchestrator before starting the sub agent(s) clear the task list. The sub agent, when receiving from Orchestrator a specific instruction such as `Parallel Mode 01`, knows what he have to do, the subagent will list the task it have to do with the task tool, using the id `01.`. When all subagent finish, Orchestrator restore the task in the exact same state before starting. It include a task related to this specifc parallel task that just done

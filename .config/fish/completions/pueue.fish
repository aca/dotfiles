complete -c pueue -n "__fish_use_subcommand" -s p -l port -d 'The port for the daemon. Overwrites the port in the config file. Will force TCP mode'
complete -c pueue -n "__fish_use_subcommand" -s u -l unix-socket-path -d 'The path to the unix socket. Overwrites the path in the config file. Will force Unix-socket mode'
complete -c pueue -n "__fish_use_subcommand" -s c -l config -d 'Path to a specific pueue config daemon, that should be used. This ignores all other config files'
complete -c pueue -n "__fish_use_subcommand" -s v -l verbose -d 'Verbose mode (-v, -vv, -vvv)'
complete -c pueue -n "__fish_use_subcommand" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_use_subcommand" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_use_subcommand" -f -a "add" -d 'Enqueue a task for execution'
complete -c pueue -n "__fish_use_subcommand" -f -a "remove" -d 'Remove tasks from the list. Running or paused tasks need to be killed first'
complete -c pueue -n "__fish_use_subcommand" -f -a "switch" -d 'Switches the queue position of two commands. Only works on queued and stashed commands'
complete -c pueue -n "__fish_use_subcommand" -f -a "stash" -d 'Stashed tasks won\'t be automatically started. Either enqueue them, to be normally handled or explicitly start them'
complete -c pueue -n "__fish_use_subcommand" -f -a "enqueue" -d 'Enqueue stashed tasks. They\'ll be handled normally afterwards'
complete -c pueue -n "__fish_use_subcommand" -f -a "start" -d 'Resume operation of specific tasks or groups of tasks.
By default, this resumes the default queue and all its tasks.
Can also be used force-start specific tasks.'
complete -c pueue -n "__fish_use_subcommand" -f -a "restart" -d 'Restart task(s). Identical tasks will be created and by default enqueued'
complete -c pueue -n "__fish_use_subcommand" -f -a "pause" -d 'Pause either running tasks or specific groups of tasks.
By default, pauses the default queue and all its tasks.
A paused queue (group) won\'t start any new tasks.'
complete -c pueue -n "__fish_use_subcommand" -f -a "kill" -d 'Kill specific running tasks or various groups of tasks'
complete -c pueue -n "__fish_use_subcommand" -f -a "send" -d 'Send something to a task. Useful for sending confirmations such as \'y\\n\''
complete -c pueue -n "__fish_use_subcommand" -f -a "edit" -d 'Edit the command or path of a stashed or queued task.
This edits the command of the task by default.'
complete -c pueue -n "__fish_use_subcommand" -f -a "group" -d 'Manage groups. By default, this will simply display all known groups'
complete -c pueue -n "__fish_use_subcommand" -f -a "status" -d 'Display the current status of all tasks'
complete -c pueue -n "__fish_use_subcommand" -f -a "log" -d 'Display the log output of finished tasks. Prints either all logs or only the logs of specified tasks'
complete -c pueue -n "__fish_use_subcommand" -f -a "follow" -d 'Follow the output of a currently running task. This command works like tail -f'
complete -c pueue -n "__fish_use_subcommand" -f -a "clean" -d 'Remove all finished tasks from the list (also clears logs)'
complete -c pueue -n "__fish_use_subcommand" -f -a "reset" -d 'Kill all running tasks, remove all tasks and reset max_task_id'
complete -c pueue -n "__fish_use_subcommand" -f -a "shutdown" -d 'Remotely shut down the daemon. Should only be used if the daemon isn\'t started by a service manager'
complete -c pueue -n "__fish_use_subcommand" -f -a "parallel" -d 'Set the amount of allowed parallel tasks'
complete -c pueue -n "__fish_use_subcommand" -f -a "completions" -d 'Generates shell completion files. This can be ignored during normal operations'
complete -c pueue -n "__fish_use_subcommand" -f -a "help" -d 'Prints this message or the help of the given subcommand(s)'
complete -c pueue -n "__fish_seen_subcommand_from add" -s d -l delay -d 'Delays enqueueing the task until <delay> elapses. See "enqueue" for accepted formats'
complete -c pueue -n "__fish_seen_subcommand_from add" -s g -l group -d 'Assign the task to a group. Groups kind of act as separate queues. I.e. all groups run in parallel and you can specify the amount of parallel tasks for each group. If no group is specified, the default group will be used'
complete -c pueue -n "__fish_seen_subcommand_from add" -s a -l after -d 'Start the task once all specified tasks have successfully finished. As soon as one of the dependencies fails, this task will fail as well'
complete -c pueue -n "__fish_seen_subcommand_from add" -s i -l immediate -d 'Start the task immediately'
complete -c pueue -n "__fish_seen_subcommand_from add" -s s -l stashed -d 'Create the task in stashed state. Useful to avoid immediate execution if the queue is empty'
complete -c pueue -n "__fish_seen_subcommand_from add" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from add" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from remove" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from switch" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from switch" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from stash" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from stash" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from enqueue" -s d -l delay -d 'Delay enqueuing the tasks until <delay> elapses. See DELAY FORMAT below'
complete -c pueue -n "__fish_seen_subcommand_from enqueue" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from enqueue" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from start" -s g -l group -d 'Start a specific group and all paused tasks in it'
complete -c pueue -n "__fish_seen_subcommand_from start" -s a -l all -d 'Start a everything (Default queue and all groups)! All groups will be set to `running` and all paused tasks will be resumed'
complete -c pueue -n "__fish_seen_subcommand_from start" -s c -l children -d 'Also resume direct child processes of your paused tasks. By default only the main process will get a SIGSTART'
complete -c pueue -n "__fish_seen_subcommand_from start" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from start" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s i -l immediate -d 'Immediately start the task(s)'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s s -l stashed -d 'Create the task in stashed state. Useful to avoid immediate execution'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s e -l edit -d 'Edit the command of the task before restarting'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s p -l path -d 'Edit the path of the task before restarting'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from restart" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s g -l group -d 'Pause a specific group'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s a -l all -d 'Pause everything (Default queue and all groups)!'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s w -l wait -d 'Don not pause already running tasks and let them finish by themselves, when pausing with `default`, `all` or `group`'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s c -l children -d 'Also pause direct child processes of a task\'s main process. By default only the main process will get a SIGSTOP. This is useful when calling bash scripts, which start other processes themselves. This operation is not recursive!'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from pause" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s g -l group -d 'Kill all running in a group. Pauses the group'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s d -l default -d 'Kill all running tasks in the default queue. Pause the default queue'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s a -l all -d 'Kill ALL running tasks. This also pauses everything'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s c -l children -d 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from kill" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from send" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from send" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from edit" -s p -l path -d 'Edit the path of the task'
complete -c pueue -n "__fish_seen_subcommand_from edit" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from edit" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from group" -s a -l add -d 'Add a group'
complete -c pueue -n "__fish_seen_subcommand_from group" -s r -l remove -d 'Remove a group. This will move all tasks in this group to the default group!'
complete -c pueue -n "__fish_seen_subcommand_from group" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from group" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from status" -s g -l group -d 'Only show tasks of a specific group'
complete -c pueue -n "__fish_seen_subcommand_from status" -s j -l json -d 'Print the current state as json to stdout. This does not include stdout/stderr of tasks. Use `log -j` if you want everything'
complete -c pueue -n "__fish_seen_subcommand_from status" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from status" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from log" -s j -l json -d 'Print the current state as json. Includes EVERYTHING'
complete -c pueue -n "__fish_seen_subcommand_from log" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from log" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from follow" -s e -l err -d 'Show stderr instead of stdout'
complete -c pueue -n "__fish_seen_subcommand_from follow" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from follow" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from clean" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from clean" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from reset" -s c -l children -d 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
complete -c pueue -n "__fish_seen_subcommand_from reset" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from reset" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from shutdown" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from shutdown" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from parallel" -s g -l group -d 'Specify the amount of parallel tasks for a group'
complete -c pueue -n "__fish_seen_subcommand_from parallel" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from parallel" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from completions" -s V -l version -d 'Prints version information'
complete -c pueue -n "__fish_seen_subcommand_from help" -s h -l help -d 'Prints help information'
complete -c pueue -n "__fish_seen_subcommand_from help" -s V -l version -d 'Prints version information'

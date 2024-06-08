
use builtin;
use str;

set edit:completion:arg-completer[pueue] = {|@words|
    fn spaces {|n|
        builtin:repeat $n ' ' | str:join ''
    }
    fn cand {|text desc|
        edit:complex-candidate $text &display=$text' '(spaces (- 14 (wcswidth $text)))$desc
    }
    var command = 'pueue'
    for word $words[1..-1] {
        if (str:has-prefix $word '-') {
            break
        }
        set command = $command';'$word
    }
    var completions = [
        &'pueue'= {
            cand -c 'Path to a specific pueue config file to use. This ignores all other config files'
            cand --config 'Path to a specific pueue config file to use. This ignores all other config files'
            cand -p 'The name of the profile that should be loaded from your config file'
            cand --profile 'The name of the profile that should be loaded from your config file'
            cand -h 'Print help information'
            cand --help 'Print help information'
            cand -V 'Print version information'
            cand --version 'Print version information'
            cand -v 'Verbose mode (-v, -vv, -vvv)'
            cand --verbose 'Verbose mode (-v, -vv, -vvv)'
            cand add 'Enqueue a task for execution'
            cand remove 'Remove tasks from the list. Running or paused tasks need to be killed first'
            cand switch 'Switches the queue position of two commands. Only works on queued and stashed commands'
            cand stash 'Stashed tasks won''t be automatically started. You have to enqueue them or start them by hand'
            cand enqueue 'Enqueue stashed tasks. They''ll be handled normally afterwards'
            cand start 'Resume operation of specific tasks or groups of tasks.
By default, this resumes the default group and all its tasks.
Can also be used force-start specific tasks.'
            cand restart 'Restart task(s). Identical tasks will be created and by default enqueued. By default, a new task will be created'
            cand pause 'Either pause running tasks or specific groups of tasks.
By default, pauses the default group and all its tasks.
A paused queue (group) won''t start any new tasks.'
            cand kill 'Kill specific running tasks or whole task groups. Kills all tasks of the default group when no ids are provided'
            cand send 'Send something to a task. Useful for sending confirmations such as ''y\n'''
            cand edit 'Edit the command or path of a stashed or queued task.
The command is edited by default.'
            cand group 'Use this to add or remove groups. By default, this will simply display all known groups'
            cand status 'Display the current status of all tasks'
            cand format-status 'Accept a list or map of JSON pueue tasks via stdin and display it just like "status". A simple example might look like this: pueue status --json | jq -c ''.tasks'' | pueue format-status'
            cand log 'Display the log output of finished tasks. When looking at multiple logs, only the last few lines will be shown. If you want to "follow" the output of a task, please use the "follow" subcommand'
            cand follow 'Follow the output of a currently running task. This command works like tail -f'
            cand wait 'Wait until tasks are finished. This can be quite useful for scripting. By default, this will wait for all tasks in the default group to finish. Note: This will also wait for all tasks that aren''t somehow ''Done''. Includes: [Paused, Stashed, Locked, Queued, ...]'
            cand clean 'Remove all finished tasks from the list'
            cand reset 'Kill all tasks, clean up afterwards and reset EVERYTHING!'
            cand shutdown 'Remotely shut down the daemon. Should only be used if the daemon isn''t started by a service manager'
            cand parallel 'Set the amount of allowed parallel tasks. By default, adjusts the amount of the default group'
            cand completions 'Generates shell completion files. This can be ignored during normal operations'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'pueue;add'= {
            cand -w 'Specify current working directory'
            cand --working-directory 'Specify current working directory'
            cand -d 'Prevents the task from being enqueued until <delay> elapses. See "enqueue" for accepted formats'
            cand --delay 'Prevents the task from being enqueued until <delay> elapses. See "enqueue" for accepted formats'
            cand -g 'Assign the task to a group. Groups kind of act as separate queues. I.e. all groups run in parallel and you can specify the amount of parallel tasks for each group. If no group is specified, the default group will be used'
            cand --group 'Assign the task to a group. Groups kind of act as separate queues. I.e. all groups run in parallel and you can specify the amount of parallel tasks for each group. If no group is specified, the default group will be used'
            cand -a 'Start the task once all specified tasks have successfully finished. As soon as one of the dependencies fails, this task will fail as well'
            cand --after 'Start the task once all specified tasks have successfully finished. As soon as one of the dependencies fails, this task will fail as well'
            cand -l 'Add some information for yourself. This string will be shown in the "status" table. There''s no additional logic connected to it'
            cand --label 'Add some information for yourself. This string will be shown in the "status" table. There''s no additional logic connected to it'
            cand -e 'Escape any special shell characters (" ", "&", "!", etc.). Beware: This implicitly disables nearly all shell specific syntax ("&&", "&>")'
            cand --escape 'Escape any special shell characters (" ", "&", "!", etc.). Beware: This implicitly disables nearly all shell specific syntax ("&&", "&>")'
            cand -i 'Immediately start the task'
            cand --immediate 'Immediately start the task'
            cand -s 'Create the task in Stashed state. Useful to avoid immediate execution if the queue is empty'
            cand --stashed 'Create the task in Stashed state. Useful to avoid immediate execution if the queue is empty'
            cand -p 'Only return the task id instead of a text. This is useful when scripting and working with dependencies'
            cand --print-task-id 'Only return the task id instead of a text. This is useful when scripting and working with dependencies'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;remove'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;switch'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;stash'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;enqueue'= {
            cand -d 'Delay enqueuing these tasks until <delay> elapses. See DELAY FORMAT below'
            cand --delay 'Delay enqueuing these tasks until <delay> elapses. See DELAY FORMAT below'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;start'= {
            cand -g 'Resume a specific group and all paused tasks in it. The group will be set to running and its paused tasks will be resumed'
            cand --group 'Resume a specific group and all paused tasks in it. The group will be set to running and its paused tasks will be resumed'
            cand -a 'Resume all groups! All groups will be set to running and paused tasks will be resumed'
            cand --all 'Resume all groups! All groups will be set to running and paused tasks will be resumed'
            cand -c 'Also resume direct child processes of your paused tasks. By default only the main process will get a SIGSTART'
            cand --children 'Also resume direct child processes of your paused tasks. By default only the main process will get a SIGSTART'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;restart'= {
            cand -g 'Like `--all-failed`, but only restart tasks failed tasks of a specific group. The group will be set to running and its paused tasks will be resumed'
            cand --failed-in-group 'Like `--all-failed`, but only restart tasks failed tasks of a specific group. The group will be set to running and its paused tasks will be resumed'
            cand -a 'Restart all failed tasks accross all groups. Nice to use in combination with `-i/--in-place`'
            cand --all-failed 'Restart all failed tasks accross all groups. Nice to use in combination with `-i/--in-place`'
            cand -k 'Immediately start the tasks, no matter how many open slots there are. This will ignore any dependencies tasks may have'
            cand --start-immediately 'Immediately start the tasks, no matter how many open slots there are. This will ignore any dependencies tasks may have'
            cand -s 'Set the restarted task to a "Stashed" state. Useful to avoid immediate execution'
            cand --stashed 'Set the restarted task to a "Stashed" state. Useful to avoid immediate execution'
            cand -i 'Restart the task by reusing the already existing tasks. This will overwrite any previous logs of the restarted tasks'
            cand --in-place 'Restart the task by reusing the already existing tasks. This will overwrite any previous logs of the restarted tasks'
            cand --not-in-place 'Restart the task by creating a new identical tasks. Only applies, if you have the restart_in_place configuration set to true'
            cand -e 'Edit the tasks'' command before restarting'
            cand --edit 'Edit the tasks'' command before restarting'
            cand -p 'Edit the tasks'' path before restarting'
            cand --edit-path 'Edit the tasks'' path before restarting'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;pause'= {
            cand -g 'Pause a specific group'
            cand --group 'Pause a specific group'
            cand -a 'Pause all groups!'
            cand --all 'Pause all groups!'
            cand -w 'Only pause the specified group and let already running tasks finish by themselves'
            cand --wait 'Only pause the specified group and let already running tasks finish by themselves'
            cand -c 'Also pause direct child processes of a task''s main process. By default only the main process will get a SIGSTOP. This is useful when calling bash scripts, which start other processes themselves. This operation is not recursive!'
            cand --children 'Also pause direct child processes of a task''s main process. By default only the main process will get a SIGSTOP. This is useful when calling bash scripts, which start other processes themselves. This operation is not recursive!'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;kill'= {
            cand -g 'Kill all running tasks in a group. This also pauses the group'
            cand --group 'Kill all running tasks in a group. This also pauses the group'
            cand -s 'Send a UNIX signal instead of simply killing the process. DISCLAIMER: This bypasses Pueue''s process handling logic! You might enter weird invalid states, use at your own descretion'
            cand --signal 'Send a UNIX signal instead of simply killing the process. DISCLAIMER: This bypasses Pueue''s process handling logic! You might enter weird invalid states, use at your own descretion'
            cand -a 'Kill all running tasks across ALL groups. This also pauses all groups'
            cand --all 'Kill all running tasks across ALL groups. This also pauses all groups'
            cand -c 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
            cand --children 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;send'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;edit'= {
            cand -p 'Edit the path of the task'
            cand --path 'Edit the path of the task'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;group'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
            cand add 'Add a group by name'
            cand remove 'Remove a group by name. This will move all tasks in this group to the default group!'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'pueue;group;add'= {
            cand -p 'Set the amount of parallel tasks this group can have'
            cand --parallel 'Set the amount of parallel tasks this group can have'
            cand --version 'Print version information'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;group;remove'= {
            cand --version 'Print version information'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;group;help'= {
            cand --version 'Print version information'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;status'= {
            cand -g 'Only show tasks of a specific group'
            cand --group 'Only show tasks of a specific group'
            cand -j 'Print the current state as json to stdout. This does not include the output of tasks. Use `log -j` if you want everything'
            cand --json 'Print the current state as json to stdout. This does not include the output of tasks. Use `log -j` if you want everything'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;format-status'= {
            cand -g 'Only show tasks of a specific group'
            cand --group 'Only show tasks of a specific group'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;log'= {
            cand -l 'Only print the last X lines of each task''s output. This is done by default if you''re looking at multiple tasks'
            cand --lines 'Only print the last X lines of each task''s output. This is done by default if you''re looking at multiple tasks'
            cand -j 'Print the resulting tasks and output as json. By default only the last lines will be returned unless --full is provided. Take care, as the json cannot be streamed! If your logs are really huge, using --full can use all of your machine''s RAM'
            cand --json 'Print the resulting tasks and output as json. By default only the last lines will be returned unless --full is provided. Take care, as the json cannot be streamed! If your logs are really huge, using --full can use all of your machine''s RAM'
            cand -f 'Show the whole output. This is the default if only a single task is being looked at'
            cand --full 'Show the whole output. This is the default if only a single task is being looked at'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;follow'= {
            cand -l 'Only print the last X lines of the output before following'
            cand --lines 'Only print the last X lines of the output before following'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;wait'= {
            cand -g 'Wait for all tasks in a specific group'
            cand --group 'Wait for all tasks in a specific group'
            cand -a 'Wait for all tasks across all groups and the default group'
            cand --all 'Wait for all tasks across all groups and the default group'
            cand -q 'Don''t show any log output while waiting'
            cand --quiet 'Don''t show any log output while waiting'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;clean'= {
            cand -g 'Only clean tasks of a specific group'
            cand --group 'Only clean tasks of a specific group'
            cand -s 'Only clean tasks that finished successfully'
            cand --successful-only 'Only clean tasks that finished successfully'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;reset'= {
            cand -c 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
            cand --children 'Send the SIGTERM signal to all children as well. Useful when working with shell scripts'
            cand -f 'Don''t ask for any confirmation'
            cand --force 'Don''t ask for any confirmation'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;shutdown'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;parallel'= {
            cand -g 'Set the amount for a specific group'
            cand --group 'Set the amount for a specific group'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;completions'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'pueue;help'= {
        }
    ]
    $completions[$command]
}

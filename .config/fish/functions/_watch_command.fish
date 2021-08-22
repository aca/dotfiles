function _watch_command
    set -l command (commandline -b)
    if [ "$command" = "" ]
        return
    end
    if command -v viddy
        viddy --differences "$command"
    else
        watch --beep --interval 2 --differences=permanent --exec fish -c "$command | _uncolor"
    end

    commandline -r ""
    echo
    commandline -f force-repaint
end

function _uncolor
    perl -pe 's/\x1b\[[0-9;]*[mG]//g'
end

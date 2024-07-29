## hook for direnv
use str

set @edit:before-readline = $@edit:before-readline {
    try {
        var m = [("direnv" export elvish 2>/dev/null | from-json)]
        # var m = [("direnv" export elvish | from-json)]
        if (> (count $m) 0) {
            set m = (all $m)
            keys $m | each { |k|
                if $m[$k] {
                    set-env $k $m[$k]
                } else {
                    unset-env $k
                }
            }
        }
    } catch e {
        nop
        # echo $e
    }
}

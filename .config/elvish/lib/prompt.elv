# stty -ixon # https://github.com/elves/elvish/issues/1488

use str
use platform
# prompt {{{
# vi mode binding https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~
set edit:rprompt-persistent = $true
set edit:prompt = {
  styled [&$true=$E:USER@(platform:hostname)" " &$false=""][(has-env SSH_CLIENT)] yellow; styled 'λ ' red;
  # styled 'λ ' red;
}

var short-addr = {
    var arr = [(str:split '/' (tilde-abbr $pwd))]
    if (eq (count $arr) (num 1)) {
        put $arr[0]
    } else {
        all $arr[0..-1] | each { |x| 
            if (not-eq $x '') {
                put $x[0] 
            } else {
                put $x
            }
        } | str:join '/' [(all) $arr[-1]]
    }
}

# set edit:rprompt = { styled ($short-addr) '#636a72' }
set edit:rprompt = { }
 
# set edit:after-readline = [
#   {|args|
#     # https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
#     printf "\033]133;C;\007"
#   }
# ]

set edit:after-command = [
  {|m|
    # https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
    printf "\033]133;A;cl=m;aid=%s\007" $pid
    if (< $m[duration] 2) {
      nop
    } else {
      echo (styled (printf "« took: %.3fs / done: "(e:date "+%Y-%m-%d %H:%M:%S") $m[duration])"\n" red italic)
    }
  }
]


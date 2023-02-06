# stty -ixon # https://github.com/elves/elvish/issues/1488

use str
use platform
# prompt {{{
# vi mode binding https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~
set edit:rprompt-persistent = $false
set edit:prompt = {
  styled [&$true=$E:USER@(platform:hostname)" " &$false=" "][(has-env SSH_CLIENT)] yellow; styled 'λ ' #5e5e5e;
}

# set edit:rprompt = { styled 'elv ' '#7c7c7c'; styled (tilde-abbr $pwd) yellow }
# set edit:rprompt = { styled (basename $pwd) yellow }
# set edit:rprompt = { styled [(str:split '/' (tilde-abbr $pwd))][-1] yellow }
# set edit:rprompt = { styled (tilde-abbr $pwd) yellow }

var short-addr = {
    print [(str:split '/' (tilde-abbr $pwd))][-1]
    # print ((tilde-abbr $pwd) | str:split '/' (all))[-1]
}

set edit:rprompt = { styled ($short-addr) yellow }

set edit:after-readline = [
  {|args|
    # https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
    printf "\033]133;C;\007"
  }
]

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


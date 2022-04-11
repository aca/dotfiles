stty -ixon # https://github.com/elves/elvish/issues/1488

# prompt {{{
# vi mode binding https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~
set edit:rprompt-persistent = $false
set edit:prompt = { 
  styled (date "+%H:%M ") '#4e4e4e'; styled [&$true=(whoami)@(hostname)' ' &$false=""][(has-env SSH_CLIENT)] yellow; styled 'λ ' #5e5e5e;
}
# set edit:rprompt = { styled 'ᑀ '(tilde-abbr $pwd) yellow }
set edit:rprompt = { styled 'elv ' '#7c7c7c'; styled (tilde-abbr $pwd) yellow }
# set edit:before-readline = [
# ]

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
    if (< $m[duration] 5) {
      nop
    } else {
      print (styled (styled (printf "« took: %.3fs / done: "(date "+%Y-%m-%d %H:%M:%S") $m[duration])"\n" red) italic)
    }
  }
]


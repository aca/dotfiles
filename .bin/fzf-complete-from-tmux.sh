#!/bin/bash
# https://unix.stackexchange.com/questions/533664/how-to-auto-complete-based-on-the-buffer-contents-in-tmux
tmux capture-pane -pS -100 |      # Dump the tmux buffer.
  tac |                              # Reverse so duplicates use the first match.
  pcregrep -o "[\w\d_\-\.\/]+" 2>/dev/null |     # Extract the words.
  awk '{ if (!seen[$0]++) print }' 2>/dev/null | # De-duplicate them with awk, then pass to fzf.
  awk 'length($0)>4' 2>/dev/null |
  egrep -v 'kubectl' | 
  egrep -v 'users' | 
  egrep -v 'staff' |
  grep -P -v '\d\.\d\d\ds' |
  grep -P -v '\d\d\.\d\d\ds' |
  grep -P -v '\d\d\d\d-\d\d-\d\d' |
  grep -P -v '\.rw.*' |
  egrep -v 'NAME|READY|STATUS|RESTARTS|AGE' |
  fzf-tmux -d '25%' --no-sort --exact +i           # Pass to fzf for completion.

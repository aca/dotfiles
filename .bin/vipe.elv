#!/bin/sh

# TODO: why it doesn't work on elvish ??
# set edit:insert:binding[Alt-e] = {|| 
#   # vipe >/dev/tty 2>/dev/null
#   edit:replace-input (echo $edit:current-command | e:vipe --suffix elv) > /dev/tty 2>/dev/null
#   # edit:replace-input (echo $edit:current-command | vipe.elv) > /dev/tty 2>/dev/null
# }

tmpf=$(mktemp --suffix .elv)
# cat - > $tmpf
nvim $tmpf >/dev/tty
cat $tmpf >/dev/tty

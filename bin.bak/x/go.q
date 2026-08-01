#!/usr/bin/env bash
# https://github.com/ryboe/q

logpath="$TMPDIR/q"
if [[ -z "$TMPDIR" ]]; then
    logpath="/tmp/q"
fi

if [[ ! -f "$logpath" ]]; then
    echo 'Q LOG' > "$logpath"
fi

tail -30f -- "$logpath"

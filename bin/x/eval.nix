#!/usr/bin/env bash
set -euo pipefail

args="$@"
if [ ! -t 0 ]; then
    tmpf=$(mktemp)
    args=$tmpf
    trap cleanup EXIT
    cat - > $tmpf
fi

cleanup() {
    rm $tmpf
}

nix-instantiate --eval --strict "$args"


# cleanup() {
#     rm $tmpf
# }
#
# if [ -t 0 ]; then
#     nix-instantiate --eval --strict "$@"
# else
#     cat - > $tmpf
#     nix-instantiate --eval --strict $tmpf
#     rm $tmpf
# fi

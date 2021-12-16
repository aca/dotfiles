# if [[ $(uname -s) = Darwin ]]; then
#   # Override insanely low open file limits on macOS.
#   ulimit -n 65536
#   ulimit -u 1064
# fi
. "$HOME/.cargo/env"

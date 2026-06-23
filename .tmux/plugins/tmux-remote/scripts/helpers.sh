option_not_set() {
  local option="$1"
  local option_value=$(tmux show-option -gv "$option")
  [[ -z "$option_value" ]]
}

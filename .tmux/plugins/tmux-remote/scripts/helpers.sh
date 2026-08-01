option_not_set() {
  local option="$1"
  local option_value
  option_value=$(tmux show-option -gv "$option" 2>/dev/null)
  [[ -z "$option_value" ]]
}

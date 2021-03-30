#!/bin/bash
# https://gist.githubusercontent.com/calbertts/8ce6727d782112fd74e5ef32fbc260e4/raw/5ae4a1de01e7cc5562214d8d3e9a7808ad13ed38/runinc.sh

runinc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local container=$(docker ps --format '{{.Names}} => {{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')
  if [[ $container != '' ]]; then
    echo -e "\n  \033[1mDocker container:\033[0m" $container
    read -e -p $'  \e[1mOptions: \e[0m' -i "-it" options
    if [[ $@ == '' ]]; then
				read -e -p $'  \e[1mCommand: \e[0m' cmd
    else
				cmd="$@"
    fi
    echo ''
    history -s runinc "$@"
    history -s docker exec $options $container $cmd
    docker exec $options $container $cmd
    echo ''
  fi
  export FZF_DEFAULT_OPTS=""
}

runinc
#!/bin/bash
# https://gist.githubusercontent.com/calbertts/f7b63feee855bfe1bfe341e5d3868a91/raw/3ee16b300c3790149513cc2e8cf78f1692f39e81/stopc.sh

# Stops and/or removes a docker container
stopc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local container=$(docker ps --format '{{.Names}} => {{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')
  if [[ $container != '' ]]; then
    echo -e "\n  \033[1mDocker container:\033[0m" $container
    printf "  \033[1mRemove?: \033[0m"
    local cmd=$(echo -e "No\nYes" | fzf-tmux --reverse --multi)
    if [[ $cmd != '' ]]; then
      if [[ $cmd == 'No' ]]; then
        echo -e "\n  Stopping $container ...\n"
        history -s stopc
        history -s docker stop $container
        docker stop $container > /dev/null
      else
        echo -e "\n  Stopping $container ..."
        history -s stopc
        history -s docker stop $container
        docker stop $container > /dev/null

        echo -e "  Removing $container ...\n"
        history -s stopc
        history -s docker rm $container
        docker rm $container > /dev/null
      fi
    fi
  fi
  export FZF_DEFAULT_OPTS=""
}

stopc
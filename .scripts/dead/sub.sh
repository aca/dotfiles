#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

topic=$1
cmd=""

requeue() {
  if [[ ! -z "$cmd" ]]; then 
    printf "\033[0;31m[✘]\033[0m %s\n" "interrupted, requeue : $cmd"
    redis-cli rpush "$topic" "$cmd"
  fi
}

trap 'echo received signal; requeue; exit 1' SIGHUP SIGINT SIGTERM

until [ $(redis-cli llen "$topic") -eq 0 ]; do
  cmd=$(redis-cli lpop "$topic" | tr -d '\r')
  if [[ -z $cmd ]]; then continue; fi

  printf "\033[0;34m[➭]\033[0m %s\n" "pop: $cmd"

  if eval "$cmd"; then
    printf "\033[0;32m[✔]\033[0m %s\n" "done"; sleep 1;
  else
    printf "\033[0;31m[✘]\033[0m %s\n" "retry later: $cmd"
    redis-cli rpush "$topic" "$cmd"
    cmd=""; sleep 1;
  fi
  echo "========================"
done

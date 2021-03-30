#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

if redis-cli ping; then
  :
else
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo systemctl start redis
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew services start redis
  fi
  until redis-cli ping; do
    sleep 1
  done
fi


topic=$1
while read CMD; do
  printf "\033[0;32m[✔]\033[0m enqueue: %s\n" "$CMD"
  redis-cli rpush "$topic" "aria2c '$CMD'"
done < "$topic"

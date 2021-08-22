function dbt --description 'docker build, tag'
  docker build -t "$argv" .
  echo "$argv" | tee /dev/tty | pbcopy
end

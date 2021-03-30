function dbtp --description 'docker build, tag, push'
  docker build -t "$argv" .
  docker push "$argv"
  echo "$argv" | tee /dev/tty | cbi
end

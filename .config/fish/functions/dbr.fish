function dbr --description 'docker build, run'
  docker build -t $argv[1] . 
  docker run -it $argv[2..-1] $argv[1]
end

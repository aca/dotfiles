function aws --wraps=fish
  if command -v aws 1>/dev/null 2>/dev/null
    command aws $argv
  else

    docker run --rm -it -v ~/.aws:/root/.aws -v ~/.kube:/root/.kube amazon/aws-cli:2.2.20 $argv
  end
end
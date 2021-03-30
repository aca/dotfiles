function swagger.editor
  if test -z (docker images swaggerapi/swagger-editor --quiet)
    docker pull swaggerapi/swagger-editor
  end
  docker run -d -v (pwd):/tmp -e SWAGGER_FILE=/tmp/swagger.yaml -p 8080:8080 swaggerapi/swagger-editor
  echo "port 8181"
end

# docker run -d -p 80:8080 -v $(pwd):/tmp -e SWAGGER_FILE=/tmp/swagger.json swaggerapi/swagger-editor

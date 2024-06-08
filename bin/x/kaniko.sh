#!/usr/bin/env bash

set -e

# kaniko.sh 'Dockerfile.backoffice' .

dockerfile=$1
context=$2

docker run -v "$context":/workspace gcr.io/kaniko-project/executor:debug --dockerfile "${dockerfile}" --context dir:///workspace/ --no-push

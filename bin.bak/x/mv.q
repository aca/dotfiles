#!/usr/bin/env bash
set -euxo pipefail

pueue group add mv || true
pueue parallel -g mv 1

pueue add -g mv -- mv -vn "$@"

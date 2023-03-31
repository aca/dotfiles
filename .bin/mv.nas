#!/bin/bash
set -euxo pipefail

pueue group add nas || true
pueue parallel -g nas 1

pueue add -g nas -- mv -vn "$@"

#!/usr/bin/env bash
set -euxo pipefail

cat *.lua | luajit -b - ../init.lua 

#!/usr/bin/env nix-shell
#!nix-shell --extra-experimental-features "nix-command flakes" -i bash -p luajit luajitPackages.stdlib
set -x
which luajit
cat lua/init/*.lua | luajit -b - init.lua

#!/usr/bin/env nix-shell
#!nix-shell -i bash -p luajit luajitPackages.stdlib
set -x
cat lua/init/*.lua | luajit -b - init.lua

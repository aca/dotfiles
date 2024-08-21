#!/usr/bin/env nix-shell
#!nix-shell -i bash -p luajit luajitPackages.stdlib

cat lua/init/*.lua | luajit -b - init.lua

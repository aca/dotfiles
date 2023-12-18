#!/usr/bin/env nix-shell
#!nix-shell -i bash -p luajit luajitPackages.stdlib
#!nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz

cat lua/init/*.lua | luajit -b - init.lua

#!/bin/bash

cat lua/init/*.lua | ~/src/github.com/neovim/neovim/.deps/usr/bin/luajit -b - init.lua
# notify-send "compiled init.lua"

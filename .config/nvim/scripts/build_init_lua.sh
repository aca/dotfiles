#!/usr/bin/env bash

# cat lua/init/*.lua | ~/src/github.com/neovim/neovim/.deps/usr/bin/luajit -b - init.lua
cat lua/init/*.lua | luajit-2.1.0-beta3 -b - init.lua
# cat lua/init/*.lua | luajit-2.1.0-beta3 -b - init.lua
# cat lua/init/*.lua | luajit -b - init.lua
# notify-send "compiled init.lua"

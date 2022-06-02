#!/bin/sh

luajit -b colors.lua colors.ljbc
luajit -b setup.lua setup.ljbc
luajit -b autocmds.lua autocmds.ljbc
luajit -b settings.lua settings.ljbc

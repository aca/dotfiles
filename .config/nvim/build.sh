#!/usr/bin/env bash
bash -c "cat init/*.lua | luajit -b - init.lua"
bash -c "cat lazy/*.lua | luajit -b - lua/init-lazy.lua "

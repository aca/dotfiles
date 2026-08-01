#!/usr/bin/env bash

# ps -o pid,args -e | grep -E "$@" | awk '{print $1}' 
ps -o pid,args -e | grep -E "$@" | grep -v grep | grep -v pkill | awk '{print $1}' | xargs kill

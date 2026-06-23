#!/bin/bash
format () {
	if [ "$1" == "--format" ]
	then
		stylua lua/csvtools.lua
		stylua lua/csvtools/*.lua
	elif [ "$1" == "--check" ]; then
		luacheck lua/csvtools/*.lua
		luacheck lua/csvtools.lua
	else 
		echo "--format       format the files"
		echo "--check        check the files"
	fi
}
format $1

function _zlua_precmd --on-event fish_prompt
	_zlua --add "$PWD" 2> /dev/null &
end
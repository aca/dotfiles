.PHONY: lint
lint:
	luacheck ./lua

# GIT_WORKTREE_NVIM_LOG=fatal
.PHONY: test
test:
	# minimal.vim is generated when entering the flake, aka `nix develop`
	nvim --headless -u minimal.vim -c "lua require('plenary.test_harness').test_directory('.', {minimal_init='minimal.vim'})"

.PHONY: wintest
wintest:
	vusted --output=gtest -m '.\plenary\lua\?.lua' -m '.\plenary\lua\?\?.lua' -m '.\plenary\lua\?\init.lua' ./lua

.PHONY: update
update: 
		@git submodule update --init --remote --force

.PHONY: sync
sync:
		@git pull --rebase
		@git submodule update --init

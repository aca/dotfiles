.PHONY: init
init:
		@git clone --recurse-submodules -j8 https://github.com/aca/dotfiles ~/src/config/dotfiles && bash ~/src/configs/dotfiles/.bin/setup.stow

.PHONY: stow
stow:
		bash .bin/setup.stow

.PHONY: update
update: 
		@git pull --rebase
		@git submodule update --init --remote --force

.PHONY: sync
sync:
		@git pull --rebase
		@git submodule update --init

.PHONY: docker
docker:
		@docker build -f Dockerfile . -t acadx0/tools:devcontainer
		@docker push acadx0/tools:devcontainer

.PHONY: dev
dev:
		@go install mvdan.cc/gofumpt@latest
		@go install github.com/ericchiang/pup@latest

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
		@git submodule update --init --force

.PHONY: docker
docker:
		@docker build --no-cache -f Dockerfile . -t acadx0/tools:devcontainer
		@docker push acadx0/tools:devcontainer

.PHONY: dev
dev:
		@go install mvdan.cc/gofumpt@latest
		@go install github.com/ericchiang/pup@latest

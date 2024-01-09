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

.PHONY: container
container:
		@nix run '.#devbox.copyToDockerDaemon'
		@docker build -f Dockerfile-nix -t acadx0/tools:devcontainer .
		@docker push acadx0/tools:devcontainer

.PHONY: container-alpine
container-alpine:
		@docker build -f Dockerfile-alpine -t acadx0/tools:devcontainer-alpine .
		@docker build --build-arg BASE_IMAGE=acadx0/tools:devcontainer-alpine -f Dockerfile-nix -t acadx0/tools:devcontainer-alpine .
		@docker push acadx0/tools:devcontainer-alpine


.PHONY: dev
dev:
		@go install mvdan.cc/gofumpt@latest
		@go install github.com/ericchiang/pup@latest

.PHONY: update
update: 
		@git submodule update --init --remote --force

.PHONY: sync
sync:
		@git pull --rebase
		@git submodule update --init

.PHONY: docker
docker:
		@docker build -f Dockerfile . -t acadx0/vim
		@docker push acadx0/vim

.PHONY: dev
dev:
		@go install mvdan.cc/gofumpt@latest
		@go install github.com/ericchiang/pup@latest

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
		@agebox decrypt --all --force || true
		@docker build -f Dockerfile . -t acadx0/work
		@docker push acadx0/work

.PHONY: dev
dev:
		@go install mvdan.cc/gofumpt@latest
		@go install github.com/ericchiang/pup@latest

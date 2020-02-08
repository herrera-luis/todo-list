.DEFAULT_GOAL := help
SHELL := /bin/bash

help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Init container using volume
	@docker run -dp 3000:3000 --name "todo-list-nodejs" \
    -w /app -v $(PWD):/app \
    node:10-alpine \
    sh -c "yarn install && yarn run dev"

status: ## Get container status
	@ docker ps --filter="name=todo-list-nodejs*"
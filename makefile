.SHELL := /bin/bash
GREEN := $(shell tput setaf 2)
RED := $(shell tput setaf 1)
GRAY := $(shell tput setaf 8)
PINK := $(shell tput setaf 5)
PURPLE := $(shell tput setaf 13)
RESET := $(shell tput sgr0)
BOLD := $(shell tput bold)

# Include .env file if it exists:
-include .env
export

help:
	@printf "$(PURPLE)development environment$(RESET) 🛠️  $(GREEN)make$(RESET) commands:\n\n"
	@grep -E '^[a-zA-Z_/-]+:.*?## .*$$' $(MAKEFILE_LIST) |  awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m$(GRAY)make $(GREEN)%-15s\033$(RESET)%s\n", $$1, $$2}'
	@printf "\n"

update: ## Pull in latest changes and install dependencies if package.json has changed.
	@if ! git diff-index --quiet HEAD --; then \
		printf "$(RED)Error: Git repository has uncommitted changes. Please commit or stash them first.$(RESET)\n"; \
		exit 1; \
	fi
	@git pull --no-edit --no-ff
	@printf "$(GRAY)✅ Pulled latest changes!$(RESET)\n"
	@if git diff --quiet HEAD@{1} HEAD -- package.json; then \
		printf "$(GRAY)✅ No changes to package.json, skipping $(GREEN)npm install$(RESET)!\n"; \
	else \
		printf "$(PINK)package.json changed, running $(GREEN)npm install$(RESET)...$(RESET)\n"; \
		npm install; \
	fi

update/npm: ## Update npm dependencies.
	@printf "$(PINK)Updating npm dependencies...$(RESET)\n"
	@npx ncu -u
	@npm install
	@printf "$(GRAY)✅ NPM dependencies updated!$(RESET)\n"

check: ## Run svelte-check and tsc commands.
	@printf "$(GRAY)Running $(GREEN)tsc$(RESET) and $(GREEN)svelte-check$(RESET) commands...$(RESET)\n"
	@printf "$(GRAY)Running $(GREEN)tsc$(RESET)...\n"
	@npx tsc && printf "$(GRAY)✅ $(GREEN)tsc$(RESET) completed!\n" || printf "$(RED)❌ $(GREEN)tsc$(RESET) failed!\n"
	@printf "$(GRAY)Running $(GREEN)svelte-check$(RESET)...\n"
	@npx svelte-check && printf "$(GRAY)✅ $(GREEN)svelte-check$(RESET) completed!\n" || printf "$(RED)❌ $(GREEN)svelte-check$(RESET) failed!\n"

check/watch: ## Run svelte-check and tsc commands and then watch for changes.
	@printf "$(GRAY)Running $(GREEN)tsc$(RESET) and $(GREEN)svelte-check$(RESET) commands and then watching for changes...$(RESET)\n"
	(npx svelte-check --watch & npx tsc -w) | cat & \
	wait

dev: ## Start the development server.
	@npm run dev

build: ## Build the production version of the app.
	@npm run build
	@printf "\n✅ Total directory size: $(PINK)$(shell du -sh dist | cut -f1)$(RESET)\n\n"

clean: ## Clean the project.
	@rm -rf node_modules demo/node_modules

test/app/serve: ## Serve the test version of the app.
	if [ ! -d "test/node_modules" ]; then \
	cd test && npm install; \
	fi
	cd test/app && npm run dev

test/app/build: ## Build the test version of the app.
	cd test/app && npm run build

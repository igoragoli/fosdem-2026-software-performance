.PHONY: all build pdf html watch lint fix format clean install help install-typos typos typos-fix

all: build

MARP_CONFIG := marp/marp.config.js
SRC := presentation.md
COMMON_FLAGS := --allow-local-files

# OS detection for typos installation
UNAME_S := $(shell uname -s)
TYPOS := $(shell command -v typos 2> /dev/null)

build: pdf

pdf:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) -o presentation.pdf

html:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) -o presentation.html

watch:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) --watch --preview

lint:
	npx markdownlint-cli2 "**/*.md" "#node_modules" "#experiments"

fix:
	npx markdownlint-cli2 --fix "**/*.md" "#node_modules" "#experiments"

format:
	npx prettier --write "*.md"

install-typos:
ifndef TYPOS
ifeq ($(UNAME_S),Darwin)
	brew install typos-cli
else ifeq ($(UNAME_S),Linux)
	cargo install typos-cli
else
	@echo "Please install typos-cli manually: https://github.com/crate-ci/typos"
	@exit 1
endif
endif

check-typos: install-typos
	typos

fix-typos: install-typos
	typos --write-changes

clean:
	rm -f presentation.pdf presentation.html

install:
	npm install

help:
	@echo "make build     - Generate PDF (default)"
	@echo "make html      - Generate HTML"
	@echo "make watch     - Live preview"
	@echo "make lint      - Markdown linting"
	@echo "make fix       - Auto-fix markdown linting issues"
	@echo "make format    - Format markdown"
	@echo "make check-typos     - Check for typos"
	@echo "make fix-typos - Fix typos automatically"
	@echo "make clean     - Remove generated files"
	@echo "make install   - Install dependencies"

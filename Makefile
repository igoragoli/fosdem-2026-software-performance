.PHONY: all build pdf html watch lint fix format clean install help install-typos typos typos-fix install-ratchet ratchet/pin ratchet/upgrade ratchet/lint

all: build

MARP_CONFIG := marp/marp.config.js
SRC := presentation.md
COMMON_FLAGS := --allow-local-files

# OS detection for tool installation
UNAME_S := $(shell uname -s)
TYPOS := $(shell command -v typos 2> /dev/null)
RATCHET := $(shell command -v ratchet 2> /dev/null)

build: pdf

pdf:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) -o presentation.pdf

html:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) -o presentation.html

watch:
	npx marp --config $(MARP_CONFIG) $(SRC) $(COMMON_FLAGS) --watch --preview

lint:
	npx markdownlint-cli2 "**/*.md" "#node_modules" "#**/node_modules" "#experiments"

fix:
	npx markdownlint-cli2 --fix "**/*.md" "#node_modules" "#**/node_modules" "#experiments"

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

install-ratchet:
ifndef RATCHET
ifeq ($(UNAME_S),Darwin)
	brew install ratchet
else
	go install github.com/sethvargo/ratchet@latest
endif
endif

ratchet/pin: install-ratchet
	ratchet pin .github/workflows/*.yml

ratchet/upgrade: install-ratchet
	ratchet upgrade .github/workflows/*.yml

ratchet/lint: install-ratchet
	ratchet lint .github/workflows/*.yml

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

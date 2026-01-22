.PHONY: all build pdf html watch lint format clean install help

all: build

MARP_CONFIG := marp/marp.config.js
SRC := presentation.md

build: pdf

pdf:
	npx marp --config $(MARP_CONFIG) $(SRC) -o presentation.pdf

html:
	npx marp --config $(MARP_CONFIG) $(SRC) -o presentation.html

watch:
	npx marp --config $(MARP_CONFIG) $(SRC) --watch --preview

lint:
	-npx markdownlint-cli2 "**/*.md" "#node_modules" "#experiments"

format:
	npx prettier --write "*.md"

clean:
	rm -f presentation.pdf presentation.html

install:
	npm install

help:
	@echo "make build   - Generate PDF (default)"
	@echo "make html    - Generate HTML"
	@echo "make watch   - Live preview"
	@echo "make lint    - Markdown linting (warnings only)"
	@echo "make format  - Format markdown"
	@echo "make clean   - Remove generated files"
	@echo "make install - Install dependencies"

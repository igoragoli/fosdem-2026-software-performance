# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Presentation slides for FOSDEM 2026 talk "How to Reliably Measure Software Performance" by Augusto de Oliveira and Kemal Akkoyun.

## Build Commands

```bash
# Generate presentation PDF from markdown (requires marp-cli)
marp presentation.md -o presentation.pdf

# Watch mode for live preview
marp presentation.md --watch
```

## File Structure

- `presentation.md` - Main Marp slides (uses custom CSS for columns, comments, section headers)
- `outline.md` - Detailed presentation outline with speaker notes and TODOs
- `assets/` - Images and reference materials

## Conventions

- Markdown linting configured via `.markdownlint.yaml` (4-space indentation)
- Slide comments use `<span class="comment">` for internal notes not shown in final presentation
- References use numbered citation format `\[N\]` with full citations at end

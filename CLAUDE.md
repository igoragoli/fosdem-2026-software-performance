# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Presentation slides for FOSDEM 2026 talk "How to Reliably Measure Software Performance" by Augusto de Oliveira and Kemal Akkoyun.

## Build Commands

```bash
# Generate presentation PDF (with Kroki diagram support)
marp --config marp/marp.config.js presentation.md -o presentation.pdf

# Watch mode for live preview
marp --config marp/marp.config.js presentation.md --watch
```

Requires marp-cli: `npm install -g @marp-team/marp-cli`

## File Structure

- `presentation.md` - Main Marp slides
- `outline.md` - Detailed presentation outline with speaker notes
- `assets/` - Images and reference materials
- `experiments/` - Jupyter notebooks for generating slide visualizations
  - `benchmark-design.ipynb` - Benchmark design experiment visualizations
  - `interpreting-results.ipynb` - Results interpretation visualizations
  - `data/` - Raw benchmark data (JSON format)
- `marp/` - Marp configuration and plugins
  - `marp.config.js` - Enables Kroki plugin
  - `kroki-plugin.js` - Renders diagrams (mermaid, plantuml, etc.) via kroki.io

## Conventions

- Markdown linting: `.markdownlint.yaml` (4-space indentation)
- Slide comments: `<span class="comment">` for internal notes not shown in final presentation
- References: Numbered citation format `\[N\]` with full citations on References slide
- Diagrams: Use mermaid/plantuml fenced code blocks (rendered via Kroki plugin)
- Custom CSS classes in presentation:
  - `.columns` - Two-column grid layout
  - `.vcenter` / `.hcenter` - Section centering
  - `.hl` - Yellow highlight for emphasis
  - `.big` / `.medium` - Large text sizes
  - `.bottom-citation` - Positioned citations at slide bottom

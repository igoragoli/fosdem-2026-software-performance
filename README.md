# How to Reliably Measure Software Performance

[![Build Presentation](https://github.com/igoragoli/fosdem-2026-software-performance/actions/workflows/build.yml/badge.svg)](https://github.com/igoragoli/fosdem-2026-software-performance/actions/workflows/build.yml)

Presentation slides for FOSDEM 2026 talk by Augusto de Oliveira and Kemal Akkoyun.

## Quick Start

```bash
make install   # Install dependencies
make build     # Generate PDF
make watch     # Live preview with hot reload
```

## Available Targets

| Target        | Description                  |
| ------------- | ---------------------------- |
| `build`       | Generate PDF (default)       |
| `html`        | Generate HTML version        |
| `watch`       | Live preview with hot reload |
| `lint`        | Run markdown linting         |
| `format`      | Format markdown files        |
| `check-typos` | Check for typos              |
| `fix-typos`   | Fix typos automatically      |
| `clean`       | Remove generated files       |
| `install`     | Install npm dependencies     |

## Code Quality

This project uses automated tools to maintain quality:

| Tool                                                       | Purpose          | Config File          |
| ---------------------------------------------------------- | ---------------- | -------------------- |
| [markdownlint](https://github.com/DavidAnson/markdownlint) | Markdown linting | `.markdownlint.yaml` |
| [Prettier](https://prettier.io/)                           | Code formatting  | `.prettierrc`        |
| [typos](https://github.com/crate-ci/typos)                 | Spell checking   | `.typos.toml`        |

All checks run automatically in CI on pull requests.

## Download

Get the latest PDF from [GitHub Actions](https://github.com/igoragoli/fosdem-2026-software-performance/actions/workflows/build.yml) - click on the latest successful run and download the `presentation-pdf` artifact.

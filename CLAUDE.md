# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Chimera is a collection of macOS tools.

## Running Scripts

```bash
# Main setup script (requires macOS with Bash)
./setup_apple_terminal.sh
```

There is no build system, test suite, or linter. Scripts are validated by running them manually on macOS.

## Git Conventions

- **Commit messages**: Must follow Conventional Commits format, enforced by `.githooks/commit-msg`
- Allowed types: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`
- Subject line max 72 characters, no trailing period
- To enable the hook: `git config core.hooksPath .githooks`

## Shell Script Patterns

- Scripts use `set -e` for fail-fast behavior
- Idempotent design: check if tools exist before installing (e.g., `command -v brew`)
- Colored logging via `log`, `warn`, `error` helper functions
- AppleScript is used for Terminal.app automation (font, profile settings)

## Formatting

- 2-space indentation (shell scripts and general files)
- LF line endings, UTF-8 charset (see `.editorconfig`)

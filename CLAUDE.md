# CLAUDE.md — edu-leftwm

## Project Overview
Educational/tutorial repository for leftwm (a tiling window manager written in Rust).
Part of the `~/EDU/` series — learning, experimentation, and demo material.

## Current State
- Minimal repo: standard `up.sh`, `setup.sh`, `cleanup.sh`, `1-cleanup.sh` scripts
- `etc/skel/` directory present but currently empty
- No Python code; shell scripts only

## Next Steps
- Populate `etc/skel/` with leftwm config examples
- Document leftwm setup steps in README.md

## Patterns & Decisions
- Shell scripts follow the standard EDU template (see global CLAUDE.md)
- `1-cleanup.sh` is a git reinit helper — gitignores numbered scripts (0-* through 9-*, up*, setup-*)

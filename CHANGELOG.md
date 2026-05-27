# CHANGELOG

## 2026.05.27

**What Changed**
Rewrote README.md to match the repo's actual contents. The previous README described `etc/skel/` as "currently empty," but it is in fact a complete LeftWM setup (candy theme, polybar, sxhkd, rofi launcher, azerty/qwerty configs, ArcoLinux theme helpers). The new README documents what ships, a keybinding quick-reference, install steps (nemesis_repo + manual), and runtime dependencies. Also swapped the discontinued `atom` editor for `code` (VS Code) on `super + F2` and `super + e`, matching the other Kiro TWMs (bspwm, chadwm, ohmychadwm, qtile) — leftwm was the only one still referencing atom.

**Technical Details**
- Replaced the "currently empty — contributions welcome" note with a "What this repo ships" breakdown of `etc/skel/.config/leftwm/`.
- Added a key-bindings table sourced from `config.ron` and `sxhkd/sxhkdrc`.
- Folded the LeftWM install into a single `pacman -S edu-leftwm-git leftwm` step and added a runtime-dependency list.
- Information website link updated from erikdubois.be to kiroproject.be.
- Left the funding-footer block untouched (managed by Kiro-HQ/cascade-readme-footer.sh).
- `sxhkd/sxhkdrc`: `super + F2` and `super + e` now launch `code` instead of the discontinued `atom`; comment labels updated.

**Files Modified**
- README.md
- etc/skel/.config/leftwm/sxhkd/sxhkdrc

## 2026.05.26

**What Changed**
Replaced picom (and the compton fallback) with fastcompmgr as the compositor. The boot launch, shutdown, and toggle now use fastcompmgr, and the compositor-toggle keybind moved to the unified `super + g` (was `ctrl + alt + o`).

**Technical Details**
- `themes/candy/up`: the `picom`/`compton` detection-and-launch block → a single `fastcompmgr -c &` guarded on `command -v fastcompmgr`.
- `themes/candy/down`: `pkill compton` / `pkill picom` → `pkill fastcompmgr`.
- `sxhkd/sxhkdrc`: toggle binding `ctrl + alt + o` → `super + g`.
- Both toggle scripts (`scripts/picom-toggle.sh` and `themes/candy/scripts/picom-toggle.sh`) renamed to `fastcompmgr-toggle.sh` (simple on/off toggle — fastcompmgr takes no config file).
- Deleted the now-unused `themes/candy/picom.conf`.

**Files Modified**
- etc/skel/.config/leftwm/themes/candy/up
- etc/skel/.config/leftwm/themes/candy/down
- etc/skel/.config/leftwm/sxhkd/sxhkdrc
- etc/skel/.config/leftwm/scripts/fastcompmgr-toggle.sh (created, replaces picom-toggle.sh)
- etc/skel/.config/leftwm/themes/candy/scripts/fastcompmgr-toggle.sh (created, replaces picom-toggle.sh)
- etc/skel/.config/leftwm/scripts/picom-toggle.sh (deleted)
- etc/skel/.config/leftwm/themes/candy/scripts/picom-toggle.sh (deleted)
- etc/skel/.config/leftwm/themes/candy/picom.conf (deleted)

## 2026.05.18

**What Changed**
Session-start housekeeping: added required project stubs (CHANGELOG.md, CLAUDE.md, IDEAS.md, TODO.md).

**Technical Details**
No code changes; stub files created per global CLAUDE.md workflow requirements.

**Files Modified**
- CHANGELOG.md (created)
- CLAUDE.md (created)
- IDEAS.md (created)
- TODO.md (created)

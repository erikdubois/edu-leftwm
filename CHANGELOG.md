# CHANGELOG

## 2026.05.27

**What Changed (multi-monitor polybar placement + monitor-layout script)**
Made polybar reliably land each bar on the correct screen on multi-monitor setups, and added a `monitor-layout.sh` that arranges connected outputs left-to-right at login. The old logic paired bars to monitors by raw `polybar -m` order, which lands bars on the wrong screen when leftwm's workspace order and polybar's monitor order disagree (e.g. after a primary-monitor swap). On a single screen the new logic degrades to the trivial `x=0 → only monitor` case, so single-monitor boxes are unaffected.

**Technical Details**
- `scripts/monitor-layout.sh` (new): detects connected outputs via `xrandr`, lays them out left-to-right (`--auto --primary --pos 0x0` for the first, `--right-of` for the rest). 0/1 screen short-circuits to enabling the single output as primary and exiting — no multi-monitor xrandr arithmetic runs. Per-hostname `PREFERRED_ORDER` override (empty default = auto-arrange in xrandr order) for boxes where X auto-detects outputs swapped. Called from each theme's `up` before the polybar loop.
- `themes/{kiro,candy}/up`: replaced `monitors=($(polybar -m | sed s/:.*//))` indexed by array position with an associative `monitor_at_x` keyed by each monitor's x-offset (parsed from `polybar -m` geometry); the bar loop then looks up `monitor_at_x[$x]` using each workspace's x from `leftwm-state`, so `mainbarN` always lands on the monitor whose workspace it controls.
- `themes/candy/up`: autostart aligned with kiro — `fastcompmgr` moved into the apps block (was a separate `command -v` guard at the bottom), `pamac-tray` and `run xfce4-clipman` added.

**Files Modified**
- etc/skel/.config/leftwm/scripts/monitor-layout.sh (new)
- etc/skel/.config/leftwm/themes/kiro/up
- etc/skel/.config/leftwm/themes/candy/up

---

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

---

**What Changed (leftwm theme overhaul + de-brand + kiro as default)**
Made the **kiro** theme the default (`themes/current` now → `kiro`, was `candy`). De-branded the leftwm config of remaining ArcoLinux references, switched to the Kiro standard Nerd Font, and fixed the long-standing kiro window-border bug.

**Technical Details**
- **Default theme:** `themes/current` symlink `candy` → `kiro`.
- **Border bug fix:** leftwm 0.5.4 does not reliably apply borders from kiro's `theme.toml` because pywal writes invalid fields into it (`col1`–`col15`, `background`, `foreground`). Added a clean `themes/kiro/theme.ron` (candy-style: only `border_width`, `margin`, the three `*_border_color`s — canonical Kiro colors bg/default `#100418`, focused `#87cfe3`, floating `#AC23A3`) and pointed `up`'s `LoadTheme` at it.
- **Pywal toggle:** `themes/kiro/up` gained `use_pywal` (default `false`) gating `scripts/wal.sh`; when off, the theme is static (like candy). `wal.sh` also got first-login default-wallpaper logic (`~/.cache/kiro-first-wallpaper-done` marker → `wallhaven-1ko2rv.png` first, random after) and the dead `LoadTheme theme.ron` line removed; border colors pinned in `template-wal/color.leftwm-theme.toml`.
- **Font:** `SauceCodePro Nerd Font` → `JetBrainsMono Nerd Font` (installed Kiro standard) in kiro `polybar/{polybartop,polybarbottom}.config`, `polybar/scripts/rofi/powermenu.rasi`, and candy `polybar/config.ini`.
- **De-brand:** removed the dead `arcolinux-welcome-app` binding from `sxhkd/sxhkdrc`; `arcolinux-powermenu` → `edu-powermenu`; screenshot prefix `ArcoLinux-` → `Kiro-`; removed stale `arcolinux*` `# Website` lines from `scripts/toazerty.sh`.
- **Other bindings/icons:** added `ctrl + alt + End` → `alacritty -e btop`; mintstick polybar icon → USB-flash-drive glyph (U+F129B) in `polybar/modules.ini`.
- **Wallpapers:** downscaled the two 4K backgrounds (`wallhaven-9mr8r1.jpg` 11.8 MB, `wallhaven-rdjojm.jpg` 8.7 MB) to 1920×1080 so pywal mode doesn't stall.

**Files Modified**
- etc/skel/.config/leftwm/themes/current (symlink → kiro)
- etc/skel/.config/leftwm/themes/kiro/theme.ron (new), theme.toml, up, down, scripts/wal.sh, template-wal/color.leftwm-theme.toml
- etc/skel/.config/leftwm/themes/kiro/polybar/{polybartop.config, polybarbottom.config, modules.ini, scripts/rofi/powermenu.rasi}
- etc/skel/.config/leftwm/themes/kiro/backgrounds/{wallhaven-9mr8r1.jpg, wallhaven-rdjojm.jpg}
- etc/skel/.config/leftwm/themes/candy/polybar/config.ini
- etc/skel/.config/leftwm/sxhkd/sxhkdrc
- etc/skel/.config/leftwm/scripts/toazerty.sh

---

**What Changed (sxhkd auto-launch, keybind de-conflict, hardware-aware monitor layout)**
sxhkd was shipped but never started, so its bindings were dormant — both themes now launch it. Removed sxhkd bindings that collided with leftwm's own keys, and added a new monitor-layout script that arranges screens by detected hardware.

**Technical Details**
- **sxhkd auto-launch:** both `themes/kiro/up` and `themes/candy/up` now start `sxhkd -c ~/.config/leftwm/sxhkd/sxhkdrc &`, each preceded by `killall sxhkd 2>/dev/null` so switching themes doesn't stack duplicate daemons (kiro previously launched no sxhkd at all; candy launched it without the guard).
- **Keybind de-conflict (`sxhkd/sxhkdrc`):** removed `super + w` (vivaldi — collided with leftwm `SwapTags`) and `super + h` (htop — collided with leftwm `FocusWorkspacePrevious`); removed `super + shift + Return` (thunar) and `super + shift + d` (dmenu) as exact duplicates of leftwm's own bindings; removed `ctrl + alt + n` (btop — duplicate of `ctrl + alt + End`). leftwm's `config.ron` is now the sole owner of those combos.
- **Monitor layout (`scripts/monitor-layout.sh`, new):** detects connected outputs via xrandr and arranges them left-to-right. Single screen → enable as primary; 2+ → place known outputs in `PREFERRED_ORDER` then append the rest. `PREFERRED_ORDER` is empty by default (generic auto-arrange) with a per-hostname override; ships with the `hq` branch as a worked example, documented for users to adapt (incl. an `arandr` GUI tip). Both up scripts call it before the polybar loop so bars get the corrected geometry.

**Files Modified**
- etc/skel/.config/leftwm/sxhkd/sxhkdrc
- etc/skel/.config/leftwm/themes/kiro/up
- etc/skel/.config/leftwm/themes/candy/up
- etc/skel/.config/leftwm/scripts/monitor-layout.sh (new)

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

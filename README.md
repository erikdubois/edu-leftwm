# edu-leftwm

Educational / tutorial repository for [LeftWM](https://github.com/leftwm/leftwm), a tiling window manager written in Rust. Part of the `~/EDU/` learning series — minimal scaffolding to drop a working LeftWM config onto a fresh Arch / Kiro install.

## What's in this repo

- `etc/skel/` — LeftWM user config files dropped into new accounts' home directories (themes, `config.ron`, autostart hooks). _Currently empty — see [TODO.md](./TODO.md); contributions welcome._
- `setup.sh`, `up.sh`, `cleanup.sh`, `1-cleanup.sh` — standard EDU bash scaffold (modelled on the canonical Kiro-HQ templates).

## Installation

### From `nemesis_repo` (recommended)

Add the repo to `/etc/pacman.conf`:

```ini
[nemesis_repo]
SigLevel = Never
Server = https://erikdubois.github.io/$repo/$arch
```

Then install:

```bash
sudo pacman -Syu
sudo pacman -S edu-leftwm-git
```

This drops the `etc/skel/` content into `/etc/skel/`. New users created after installation inherit the LeftWM config automatically; existing users can copy the files manually:

```bash
cp -rT /etc/skel ~/
```

### Manual

```bash
git clone https://github.com/erikdubois/edu-leftwm.git
cd edu-leftwm
sudo cp -r etc/skel/. /etc/skel/
```

You also need LeftWM itself:

```bash
sudo pacman -S leftwm
```

## Websites

Information : https://erikdubois.be

## Social Media

Youtube : https://www.youtube.com/erikdubois

## License

See [LICENSE](./LICENSE).

<p align="center">
  <img src="kiro.jpg" alt="Kiro" width="220" />
</p>

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

<!-- KIRO-FUNDING-FOOTER:START — managed by Kiro-HQ/cascade-readme-footer.sh -->
## Help fund Kiro

Everything I build here stays free and open — always. If Kiro or any of these
tools have ever saved you time or taught you something, a small monthly
contribution helps keep the work going. Donations target break-even, nothing
more — the core always stays free for everyone.

- GitHub Sponsors: https://github.com/sponsors/erikdubois
- Patreon: https://www.patreon.com/c/kiroproject
- YouTube memberships: https://www.youtube.com/@ErikDubois/join
- Ko-fi: https://ko-fi.com/erikdubois
- PayPal: https://www.paypal.me/erikdubois
<!-- KIRO-FUNDING-FOOTER:END -->

## License

See [LICENSE](./LICENSE).

# dotfiles

Personal configuration for a Fedora/GNOME workstation — zsh, Kitty, herdr,
Neovim, Starship and friends.

The layout mirrors where files actually live, so there is no install script to
read: everything under `config/` belongs in `~/.config/`, everything under
`home/` belongs in `~/`.

```
config/     →  ~/.config/
home/       →  ~/
macos/      →  macOS-only, not used on the current machine
themes/     →  alternate color schemes, not active
scripts/    →  standalone tools, not tied to any config
docs/       →  machine setup notes
```

## What's here

### Shell

| Path | Installs to | Notes |
| --- | --- | --- |
| `home/.zshrc` | `~/.zshrc` | Aliases, small helper functions, `starship` + `zoxide` init |
| `config/starship.toml` | `~/.config/starship.toml` | Two-line prompt, `catppuccin_frappe` palette |

### Terminal & multiplexing

| Path | Installs to | Notes |
| --- | --- | --- |
| `config/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | Current terminal. Styled to match GNOME Ptyxis (GNOME dark palette, NotoSansM Nerd Font) |
| `config/herdr/config.toml` | `~/.config/herdr/config.toml` | herdr terminal workspace manager — catppuccin theme, workspace switching on `prefix+ctrl+j/k` |
| `home/.tmux.conf` | `~/.tmux.conf` | `C-a` prefix, vim-style panes. Kept around, mostly superseded by herdr |
| `config/alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` | Previous terminal, kept as a fallback |

Only the *user* config is tracked for herdr — the runtime files it drops in the
same directory (`session.json`, `*.sock`, `*.log`) are gitignored.

### Editors

Neovim lives in its own repo: **[adelapazborrero/nvim](https://github.com/adelapazborrero/nvim)**

```sh
git clone git@github.com:adelapazborrero/nvim.git ~/.config/nvim
```

| Path | Installs to | Notes |
| --- | --- | --- |
| `config/zed/settings.json` | `~/.config/zed/settings.json` | Vim mode, Catppuccin Macchiato, left-docked panels |
| `config/zed/keymap.json` | `~/.config/zed/keymap.json` | VSCode keybindings ported over |

### Tools

| Path | Installs to | Notes |
| --- | --- | --- |
| `config/git/ignore` | `~/.config/git/ignore` | Global gitignore |
| `home/.gitconfig` | `~/.gitconfig` | Identity + `nvim` as editor |
| `config/k9s/` | `~/.config/k9s/` | Kubernetes TUI — config, resource aliases, skin |
| `config/btop/btop.conf` | `~/.config/btop/btop.conf` | Resource monitor |
| `config/o-tiling/config.json` | `~/.config/o-tiling/config.json` | Window tiling rules. The generated `_compiled_*` keys are stripped — o-tiling rebuilds them |
| `home/.taskrc` | `~/.taskrc` | Taskwarrior |
| `config/neofetch/` | `~/.config/neofetch/` | Fetch output + Pikachu ASCII art |

### macOS

`macos/sketchybar/` is a menu bar config from an earlier macOS setup. Not used
on the current machine, kept for reference.

### Themes

Alternate color schemes that are *not* installed by default:

- `themes/alacritty/alacritty_hack_the_box.toml`
- `themes/starship/starship_hack_the_box.toml`
- `themes/tmux/catppuccin-cobalt2.tmuxtheme`

### Scripts

Standalone tools in `scripts/`, not wired into any config:

- `autonmap`, `incursore` — nmap automation wrappers
- `kspray.sh` — Kerberos password spraying / DC enumeration
- `encoder.py` — PowerShell reverse-shell payload encoder

## Installing

Symlink what you want:

```sh
ln -s ~/Projects/dotfiles/home/.zshrc          ~/.zshrc
ln -s ~/Projects/dotfiles/config/starship.toml ~/.config/starship.toml
ln -s ~/Projects/dotfiles/config/kitty         ~/.config/kitty
```

For directories that hold runtime state alongside config — `herdr`, `k9s` —
symlink the individual file instead of the whole directory:

```sh
mkdir -p ~/.config/herdr
ln -s ~/Projects/dotfiles/config/herdr/config.toml ~/.config/herdr/config.toml
```

## Dependencies

Assumed on `PATH` by `home/.zshrc` and the configs above:

`zsh` · `starship` · `zoxide` · `nvim` · `kitty` · `herdr` · `lsd` ·
`logo-ls-icons` · `kubectl` · `kubectx` · `k9s` · `docker-compose` · `gitui`

A patched **Nerd Font** (NotoSansM Nerd Font) is required for the prompt, Kitty
and neofetch glyphs.

## Machine setup notes

- [Linux desktop](docs/desktop-linux.md) — GNOME extensions, MATE, battery, RGB
- [Ultrawide display](docs/ultrawide-display.md) — 3440x1440 on a ThinkPad T480
- [Firefox](docs/firefox.md) — custom CSS
- [VMware on Kali](docs/vmware-kali.md)
- [Windows](docs/windows.md) — GCC toolchain, activation scripts

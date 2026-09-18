# bspwm dotfiles

A default bspwm setup for a fresh Arch install (e.g. from `archinstall`), covering:

- **bspwm** — window manager (`config/bspwm/bspwmrc`)
- **sxhkd** — keybindings (`config/sxhkd/sxhkdrc`)
- **picom** — compositor: shadows, blur, rounded corners, fade (`config/picom/picom.conf`)
- **alacritty** — terminal (`config/alacritty/alacritty.toml`)
- **rofi** — app launcher / window switcher / power menu (`config/rofi/`)
- **polybar** — status bar (`config/polybar/`)
- **dunst** — notifications (`config/dunst/dunstrc`)
- **xinitrc** — for `startx` users (`config/x11/xinitrc`)

Colors follow Catppuccin Mocha throughout so everything looks consistent out of the box.

## 1. Install packages

```sh
sudo pacman -S --needed $(grep -v '^#' packages.txt | grep -v '^$')
```

If `ttf-jetbrains-mono-nerd` isn't in your mirror's repos, grab it from the AUR
(`jetbrains-mono-nerd-font`) with `yay`/`paru`, or swap the font names in
`alacritty.toml`, `rofi/config.rasi`, `polybar/config.ini`, and `dunst/dunstrc`.

## 2. Symlink the configs

```sh
git clone <this-repo-url> ~/bspwm-dotfiles
cd ~/bspwm-dotfiles
./install.sh
```

This symlinks each `config/<app>` directory into `~/.config/<app>` and
`config/x11/xinitrc` to `~/.xinitrc`, backing up anything that already exists
under `~/.config-backup-<timestamp>/`.

## 3. Start bspwm

- **No display manager**: log in on a TTY and run `startx`.
- **With a display manager** (e.g. `sddm`/`lightdm`): select the "bspwm"
  session from the login screen instead of using `.xinitrc`.

## Notes / things to personalize

- **Wallpaper**: drop an image at `~/Pictures/wallpaper.jpg`, or edit the
  `feh --bg-fill` line in `bspwmrc` to point elsewhere.
- **Battery module**: `polybar/config.ini`'s `[module/battery]` assumes
  `BAT0`/`ADP1`. On a desktop, remove `battery` from `modules-right`; on a
  laptop, check `ls /sys/class/power_supply/` and adjust the names if needed.
- **Monitors**: `bspwmrc` declares 10 desktops on monitor 1; multi-monitor
  users may want per-monitor desktop assignments (`bspc monitor <name> -d ...`).
- **Lock screen**: keybindings call `loginctl lock-session`, which needs a
  configured lock handler (e.g. `physlock` or an `xss-lock` + `i3lock`/`betterlockscreen`
  setup bound to `loginctl`'s lock signal). Swap in whatever locker you prefer.

## Keybinding cheatsheet (sxhkdrc highlights)

| Keys | Action |
|---|---|
| `super + Return` | terminal (alacritty) |
| `super + d` | app launcher (rofi) |
| `super + Tab` | window switcher (rofi) |
| `super + shift + e` | power menu |
| `super + shift + q` | close window |
| `super + shift + BackSpace` | quit bspwm |
| `super + {h,j,k,l}` | focus window (vim-style) |
| `super + shift + {h,j,k,l}` | swap window |
| `super + {t,shift+t,s,f}` | tiled / pseudo-tiled / floating / fullscreen |
| `super + {1-9,0}` | go to desktop |
| `super + shift + {1-9,0}` | send window to desktop |
| `super + ctrl + {h,j,k,l}` | preselect split direction |
| `super + alt + {h,j,k,l}` | move floating window |
| `super + alt + shift + {h,j,k,l}` | resize window |
| `Print` / `shift + Print` / `super + Print` | screenshot (full / select / select-to-clipboard) |

Reload keybindings after editing `sxhkdrc` with `super + Escape` (sends `sxhkd` a `SIGUSR1`).

## What's next

Good candidates for a follow-up pass: a login manager config (SDDM theme),
a `.Xresources` for GTK/Qt cursor and DPI consistency, GTK/Qt theming to match
the Catppuccin palette, and a script to auto-detect and preselect a wallpaper.

#!/bin/sh
# Symlinks this repo's configs into $HOME, backing up anything already there.
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "${dest#"$HOME"/}")"
        mv "$dest" "$BACKUP_DIR/${dest#"$HOME"/}"
        echo "backed up existing $dest -> $BACKUP_DIR/${dest#"$HOME"/}"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "linked $dest -> $src"
}

mkdir -p "$CONFIG_DIR"

for dir in bspwm sxhkd picom alacritty rofi polybar dunst; do
    link "$REPO_DIR/config/$dir" "$CONFIG_DIR/$dir"
done

link "$REPO_DIR/config/x11/xinitrc" "$HOME/.xinitrc"

chmod +x "$CONFIG_DIR/bspwm/bspwmrc"
chmod +x "$CONFIG_DIR/polybar/launch.sh"
chmod +x "$CONFIG_DIR/rofi/scripts/powermenu.sh"
chmod +x "$HOME/.xinitrc"

mkdir -p "$HOME/Pictures/screenshots"

echo
echo "Done. Install packages first if you haven't: see packages.txt"
echo "(pacman -S --needed \$(grep -v '^#' packages.txt | grep -v '^$'))"
echo "Backups of anything replaced are in: $BACKUP_DIR (only created if something existed)"

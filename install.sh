#!/usr/bin/env bash
# Sets up this Mac from the dotfiles repo: installs Homebrew if needed, installs
# everything in the Brewfile, and symlinks the config files into place.
# Idempotent - safe to re-run any time you add a package or a new config file.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
BACKUP="$HOME/dotfiles-backup"

echo "==> Step 1: Homebrew"
if command -v brew >/dev/null 2>&1; then
  echo "    brew already installed, skipping"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Put brew on PATH for the rest of this script (Apple Silicon path).
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Step 2: brew bundle (install-only)"
brew bundle --file="$DIR/Brewfile"

echo "==> Step 3: symlink config files"
# Point ~/.dotfiles at this repo so symlinks (and any tooling) can resolve it.
ln -sfn "$DIR" "$HOME/.dotfiles"

# link <repo-relative-source> <absolute-dest>
# Creates dest's parent, backs up any existing real file/dir, then symlinks.
link() {
  local src="$DIR/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  # Already the correct symlink? Nothing to do.
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    return
  fi
  # Something else is there - move it aside before linking.
  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP"
    echo "    backing up existing $dest -> $BACKUP/"
    mv "$dest" "$BACKUP/$(basename "$dest").$(date +%s)"
  fi
  ln -sfn "$src" "$dest"
  echo "    linked $dest"
}

link home/.zshrc                 "$HOME/.zshrc"
link home/.gitconfig             "$HOME/.gitconfig"
link home/.config/starship.toml  "$HOME/.config/starship.toml"
link home/.config/ghostty/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link home/.config/nvim           "$HOME/.config/nvim"
link home/.config/herdr          "$HOME/.config/herdr"
link home/.claude/settings.json  "$HOME/.claude/settings.json"
link home/AGENTS.md              "$HOME/.claude/CLAUDE.md"
link home/AGENTS.md              "$HOME/.codex/AGENTS.md"
link home/AGENTS.md              "$HOME/.config/opencode/AGENTS.md"

echo "==> Done. Open a new terminal to pick up the shell config."

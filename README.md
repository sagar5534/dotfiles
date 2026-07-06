# dotfiles

My personal Mac setup, managed with Homebrew and a symlink script.
One repo, one command, and a fresh Mac ends up configured the same way every time.

## What you get

Running `./install.sh` gives you:

- Homebrew apps (casks and CLI tools), declared in `Brewfile`
- Shell (zsh, aliases, starship prompt)
- Editor (Neovim config)
- Terminal (Ghostty config)
- Git identity
- Agent configs (Claude, Codex, opencode all share one AGENTS.md)

## Fresh-machine setup

On a brand new Mac, from a bare clone of this repo:

```sh
git clone https://github.com/sagar5534/dotfiles.git
cd dotfiles
```

Before you run it: open the config files and change the values listed in "Make it yours" below (git identity, and Intel vs Apple Silicon), and read the Homebrew note.

```sh
./install.sh
```

`install.sh` does three things, in order:

1. Installs Homebrew, if it isn't already installed.
2. Runs `brew bundle` to install everything in `Brewfile`.
3. Symlinks this repo's config files into place (backing up anything already there to `~/dotfiles-backup/`).

After it finishes, open a new terminal so the shell config takes effect.

## Daily use

Edit the config files in place, then:

- **Changed a config file** (zsh, Ghostty, Neovim, etc.): nothing to run. The files
  are symlinked straight from this repo, so your edits are live immediately.
- **Added a package or a new symlink**: re-run `./install.sh`. It's idempotent and
  only adds what's missing.

## Make it yours

This repo is mine.
If you clone it, change these before you run `./install.sh`:

- **Git identity**, in `home/.gitconfig` (`Sagar Patel` / `s.72427patel@gmail.com`).
- **CPU architecture**: on an Intel Mac, swap the `/opt/homebrew` paths for `/usr/local`
  in `home/.zshrc` (the `brew shellenv` line and the two `source` lines) and in
  `install.sh` (see Prerequisites above).

**Homebrew note:** installs are install-only. `brew bundle` adds everything in
`Brewfile` but never removes anything, so packages you have outside the list are left
alone. If you ever want to prune to exactly the `Brewfile`, run `brew bundle cleanup`
manually - it is not automatic.

**Secrets:** anything secret (API keys, tokens) goes in `~/.env.local`, which is not in
this repo. `home/.zshrc` sources it on startup if it exists. On a new machine, create
`~/.env.local` yourself and add your `export` lines - that's the one manual step.

**Heads-up:**

- `home/AGENTS.md` is my personal agent policy, symlinked for Claude, Codex, and
  opencode. If you clone this repo, you'd silently inherit my agent instructions - edit
  or delete `home/AGENTS.md` if you don't want that.
- The `cc` and `co` shell aliases in `home/.zshrc` are high-agency shortcuts:
  `claude --dangerously-skip-permissions` and `codex --full-auto`. They're convenient
  for me, but know what they do before you use them.
- `herdr` is in the `Brewfile`. It's a real public Homebrew formula (`brew info herdr`
  finds it in homebrew-core, no tap needed). If you don't use it, remove that line.

## Repo tour

- `install.sh` - the entry point. Installs Homebrew, runs `brew bundle`, and symlinks
  the config files. Run it to set up a machine or after adding a package.
- `Brewfile` - the list of CLI tools, apps, and fonts to install.
- `home/` - the actual config files that get symlinked into place (zsh, Ghostty,
  Neovim, herdr, git, starship, Claude settings, the shared `AGENTS.md`).

## How the symlinks work

The files under `home/` are the real files - editing them here is editing your live
config, no re-run needed to see the change in your editor.
`install.sh` symlinks paths like `~/.config/nvim` straight at `home/.config/nvim` in
this repo, so the two never drift out of sync.
You only re-run `./install.sh` when you add a new package or a brand-new config file
that isn't symlinked yet.

## Notes

The first time you launch `nvim`, it bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) by cloning plugins from GitHub.
That needs network access once; after that it's offline.

## License

This repo is licensed under MIT No Attribution.
See `LICENSE`.

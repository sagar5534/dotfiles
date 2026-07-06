# Project notes for agents

Deliberate decisions in this repo - do NOT silently revert them:

- Every package and app is declared in `Brewfile` and applied with `brew bundle` from `install.sh`. Keep it that way: add new tools to `Brewfile` rather than installing them ad-hoc, so a fresh clone reproduces the machine. Installs are deliberately install-only (no `brew bundle --cleanup`); do not add auto-cleanup that would uninstall packages a user has outside the Brewfile.
- Never commit `.no-mistakes/` validation evidence to this public repo. `.no-mistakes/` is gitignored; if a validation pipeline stages evidence into a branch, drop it before merging.
# Homebrew tools on PATH (use /usr/local on Intel Macs)
eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ..='cd ..'
alias ll='ls -a'
alias add='git add .'
alias push='git push'
alias pull='git pull'
alias m='git switch main'
alias cc='claude --dangerously-skip-permissions'
alias co='codex --full-auto'

# Ghost text from history + valid-command highlighting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey '^f' autosuggest-accept

# Prompt
eval "$(starship init zsh)"

# Machine-local secrets (not in the repo)
[[ -f ~/.env.local ]] && source ~/.env.local

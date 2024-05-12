# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999

setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

plugins=(git zsh-autosuggestions zsh-syntax-highlighting ssh-agent)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$PATH:/opt/nvim-linux64/bin"

alias ls='exa --icons'
alias ll='exa -lbF --icons' # list, size, type, git
alias llm='exa -lbGd --icons --sort=modified' # long list, modified date sort
alias la='exa -lbhHigUmuSa --icons --time-style=long-iso --color-scale' # all list
alias lx='exa -lbhHigUmuSa@ --icons --time-style=long-iso --color-scale' # all + extended list
alias lS='exa -1 --icons' # one column, just names
alias lt='exa --tree --level=2 --icons' # tree

alias cd='z'

alias fzp='fzf --preview "bat --color=always {}" --preview-window "~3"'

# Alias fd-find
alias fd='fdfind'

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "/$HOME/.bun/_bun"

export VOLTA_HOME=$HOME/.volta
export VOLTA_FEATURE_PNPM=1

export PATH="$PATH:/opt/nvim-linux64/bin:/$HOME/.local/bin"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH=$PATH:/usr/local/go/bin:"$HOME/go/bin"
export PATH=$PATH:/usr/local/bin/protoc/bin
export PATH="$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$VOLTA_HOME/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$VOLTA_HOME/bin:$PATH"

fpath+=${ZDOTDIR:-~}/.zsh_functions


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

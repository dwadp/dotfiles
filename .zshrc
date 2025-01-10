# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999

setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

zle_highlight=('paste:none')

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char
bindkey "^[Od" backward-word
bindkey "\e[1;5D" backward-word
bindkey "^[Oc" forward-word
bindkey "\e[1;5C" forward-word
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "\e[5~" history-beginning-search-backward
bindkey "\e[6~" history-beginning-search-forward
bindkey "^W" backward-delete-word

alias ls='eza --icons'
alias ll='eza -lbFg --icons' # list, size, type, git
alias llm='eza -lbGdg --icons --sort=modified' # long list, modified date sort
alias la='eza -lbhHigUmuSa --icons --time-style=long-iso --color-scale' # all list
alias lx='eza -lbhHigUmuSa@ --icons --time-style=long-iso --color-scale' # all + extended list
alias lS='eza -1 --icons' # one column, just names
alias lt='eza --tree --level=2 --icons' # tree

alias cd='z'
alias fzp='fzf --preview "bat --color=always {}" --preview-window "~3"'
alias fd='fdfind'
alias lg='lazygit'
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias php='twig php'
alias composer='twig composer'

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "/$HOME/.bun/_bun"

export GOROOT=/usr/local/go

export PATH="${GOROOT}/bin:$PATH"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH=$PATH:/usr/local/go/bin:"$HOME/go/bin"
export PATH=$PATH:/usr/local/bin/protoc/bin
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/chromium-browser"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dwadp/.zsh/completions:"* ]]; then export FPATH="/home/dwadp/.zsh/completions:$FPATH"; fi

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# fnm
FNM_PATH="/home/dwadp/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/dwadp/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "/home/dwadp/.deno/env"

export PODMAN_COMPOSE_WARNING_LOGS=false

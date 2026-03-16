# ╭──────────────────────────────────────────╮
# │             aziz's zshrc                 │
# │         catppuccin macchiato             │
# ╰──────────────────────────────────────────╯

# ── Homebrew (Apple Silicon + Intel) ──────────
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ── Path ──────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH"
[[ -d /Applications/Docker.app/Contents/Resources/bin ]] && export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
[[ -d "$HOME/.orbstack/bin" ]] && export PATH="$HOME/.orbstack/bin:$PATH"
[[ -n "$HOMEBREW_PREFIX" ]] && [[ -d "$HOMEBREW_PREFIX/opt/mysql-client/bin" ]] && export PATH="$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH"
export EDITOR="vim" VISUAL="vim"

# ── History ───────────────────────────────────
HISTFILE="$HOME/.zsh_history" HISTSIZE=50000 SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY
unsetopt IGNORE_EOF BEEP

# ── Completion ────────────────────────────────
autoload -Uz compinit
[[ -n "$HOMEBREW_PREFIX" ]] && [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -u -d "${HOME}/.zcompdump"
else
  compinit -u -C -d "${HOME}/.zcompdump"
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' ignored-patterns '*(#qN)'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ── Prompt (Starship) ────────────────────────
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  autoload -Uz vcs_info
  precmd() { vcs_info }
  zstyle ':vcs_info:git:*' formats ' %F{240}(%b)%f'
  setopt PROMPT_SUBST
  PROMPT='%F{cyan}%n%f %F{blue}%~%f${vcs_info_msg_0_} %# '
fi

# ── Modern CLI Tools ─────────────────────────
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)" && alias cd="z"
(( $+commands[eza] ))    && alias ls="eza --group-directories-first --icons"
(( $+commands[bat] ))    && alias cat="bat --theme=Catppuccin-macchiato"

# ── FZF (Catppuccin Macchiato) ───────────────
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS=" \
    --height 40% --layout=reverse --border rounded --info=inline \
    --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
    --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
    --color=marker:#F4DBD6,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
    --color=border:#6E738D"
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
  elif (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
  fi
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ── Visual ────────────────────────────────────
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"

# ── Plugins ───────────────────────────────────
PLUGIN_DIR="${HOMEBREW_PREFIX:-/opt/homebrew}/share"
if [[ -d "$PLUGIN_DIR" ]]; then
  [[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
# Autosuggestion style — subtle overlay
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6E738D"

# ── Aliases ───────────────────────────────────
# Navigation
alias ..="cd .." ...="cd ../.." ....="cd ../../.."
alias ~="cd ~"

# Safety
alias rm="rm -i" cp="cp -i" mv="mv -i"

# Git
alias gs="git status" gl="git log --oneline -20" gd="git diff"
alias gp="git push" gpl="git pull" gc="git commit"
alias gco="git checkout" gb="git branch" gm="git merge"

# Docker
alias dc="docker compose" dps="docker ps" dpsa="docker ps -a"
alias di="docker images" dl="docker logs -f"

# Kubernetes
alias k="kubectl" kgp="kubectl get pods" kgs="kubectl get svc"
alias kgd="kubectl get deployments" kgn="kubectl get nodes"
alias kl="kubectl logs -f" kd="kubectl describe"
alias kns="kubectl config set-context --current --namespace"

# Lazygit
alias lg='lazygit'

# ── Source Extra Files ────────────────────────
[[ -f ~/.zsh_aliases ]]        && source ~/.zsh_aliases
[[ -f ~/.cursor/aliases.zsh ]] && source ~/.cursor/aliases.zsh
[[ -f ~/.zshrc.local ]]        && source ~/.zshrc.local

# ── Key Bindings ──────────────────────────────
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search  # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey '^[[H' beginning-of-line            # Home
bindkey '^[[F' end-of-line                  # End
bindkey '^[^[[D' backward-word              # Opt+Left
bindkey '^[^[[C' forward-word               # Opt+Right

# ── Functions & NVM ───────────────────────────
if [[ -f ~/.zsh_functions ]]; then
  source ~/.zsh_functions
  unalias cleanup 2>/dev/null
fi

unset npm_config_prefix
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  zsh_nvm_lazy_load() {
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
  }
  for cmd in node nvm npm npx; do
    alias $cmd="unalias node nvm npm npx 2>/dev/null; zsh_nvm_lazy_load; $cmd"
  done
fi

# ── Greeting ──────────────────────────────────
if type fast_greeting >/dev/null 2>&1; then
  fast_greeting
elif type personal_greeting >/dev/null 2>&1; then
  personal_greeting
fi

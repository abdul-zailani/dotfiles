---
title: "My macOS Terminal Setup as a DevOps Engineer — One Command, Zero Config"
published: false
description: "A walkthrough of my dotfiles setup: Catppuccin Macchiato theme, modern CLI tools replacing defaults, and 50+ aliases for Git, Docker, and Kubernetes workflows."
tags: terminal, devops, macos, productivity
cover_image: https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png
canonical_url: https://github.com/abdul-zailani/dotfiles
---

I spend 8+ hours a day in the terminal. Over the years I've built a dotfiles setup that makes macOS feel fast, pretty, and productive — especially for backend and DevOps work.

I recently open-sourced it: **[github.com/abdul-zailani/dotfiles](https://github.com/abdul-zailani/dotfiles)**

Here's what's in it and why.

## The Problem

Every new Mac means hours of setup. Every tool has its own config format. And the default macOS terminal experience is... underwhelming.

I wanted:
- **One command** to go from fresh Mac to fully configured
- **Modern tools** that are actually faster, not just prettier
- **A consistent theme** across everything
- **Zero personal secrets** in the repo so anyone can use it

## The Stack

Every default tool gets replaced with something better:

| Default | Replaced By | Why |
|---------|-------------|-----|
| `cd` | zoxide | Learns your habits, jump anywhere with `z` |
| `ls` | eza | Icons, git status, tree view |
| `cat` | bat | Syntax highlighting, line numbers |
| `git diff` | delta | Side-by-side diffs with syntax highlighting |
| `find` | fzf | Fuzzy find files, history, branches |
| prompt | starship | Shows git/k8s/aws context, fast |

The key: **graceful fallback**. If a tool isn't installed, the config falls back to the default. No errors.

```bash
(( $+commands[eza] )) && alias ls="eza --group-directories-first --icons"
(( $+commands[bat] )) && alias cat="bat --theme=Catppuccin-macchiato"
```

## Theme: Catppuccin Macchiato Everywhere

One theme across Starship prompt, fzf, bat, and delta. The Catppuccin Macchiato palette is easy on the eyes for long sessions:

- Starship: custom bubble-style segments with Macchiato colors
- fzf: `--color` flags matching the palette
- bat: `--theme=Catppuccin-macchiato`
- delta: inherits terminal colors

## 50+ Aliases for Real Workflows

Not random aliases — these are the commands I actually type daily:

**Git** (the ones I use every hour):
```bash
alias gs="git status" gd="git diff" gp="git push"
alias gaa="git add --all" gundo="git reset --soft HEAD~1"
alias lg="lazygit"
```

**Kubernetes** (cluster operations):
```bash
alias k="kubectl" kgp="kubectl get pods" kl="kubectl logs -f"
alias kns="kubectl config set-context --current --namespace"
alias kswitch="kubectl config use-context"
```

**Docker** (container lifecycle):
```bash
alias dc="docker compose" dps="docker ps"
alias dstop="docker stop \$(docker ps -q)"
alias dclean="docker system prune -f"
```

## Functions That Save Time

```bash
# Extract anything — tar, gz, zip, 7z, rar
extract archive.tar.gz

# Scaffold a new project with git init
setup_project my-api go

# Clean ALL dev caches in one shot
cleanup  # go, npm, brew, electron, pnpm...

# Quick timestamped backup
quick_backup ./important-config
```

## The Setup Script

One command:

```bash
git clone https://github.com/abdul-zailani/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

It handles:
1. Homebrew installation
2. Package installation from Brewfile
3. Symlinks (with automatic backup of existing files)
4. Git identity prompt
5. `~/.zshrc.local` for machine-specific overrides

## Personal Config Without Polluting the Repo

Everything personal goes in `~/.zshrc.local` (gitignored):

```bash
# Work VPN
alias vpn="sudo openconnect vpn.company.com"

# Editor-specific
source ~/.cursor/aliases.zsh

# Environment
export WORK_API_KEY="..."
```

The repo stays clean and reusable.

## Try It

```bash
git clone https://github.com/abdul-zailani/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

Works on Apple Silicon and Intel Macs. Non-destructive — your existing configs get backed up automatically.

If it saves you time, a ⭐ on the repo would be appreciated: **[github.com/abdul-zailani/dotfiles](https://github.com/abdul-zailani/dotfiles)**

---

*What's in your dotfiles? Drop a link in the comments — always looking for new tricks.*

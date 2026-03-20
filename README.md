# 🏠 dotfiles

> macOS dev environment — one command setup, works on any Mac.

![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-Macchiato-b7bdf8?style=flat)

<img width="800" alt="terminal-preview" src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png">

## ⚡ Quick Start

```bash
git clone https://github.com/abdul-zailani/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

`setup.sh` will:
1. Install [Homebrew](https://brew.sh) (if missing)
2. Install all packages from `Brewfile`
3. Symlink configs to `$HOME`
4. Prompt for Git identity (first run only)
5. Create `~/.zshrc.local` for machine-specific overrides

## 📦 What's Inside

```
~/dotfiles/
├── .zshrc              # Main shell config
├── .zsh_aliases        # 50+ aliases (git, docker, k8s, macOS)
├── .zsh_functions      # 15+ utility functions
├── .gitconfig          # Git config (delta, aliases, rebase)
├── .gitignore_global   # Global gitignore
├── starship.toml       # Starship prompt — Catppuccin Macchiato
├── Brewfile            # Homebrew packages
├── extras/             # Optional modules
│   └── zsh_mfa         # MFA/TOTP via macOS Keychain
└── setup.sh            # One-command bootstrap
```

## 🛠️ Tools

Installed via `Brewfile`:

| Tool | Purpose |
|------|---------|
| [starship](https://starship.rs) | Cross-shell prompt |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [eza](https://github.com/eza-community/eza) | Modern `ls` |
| [bat](https://github.com/sharkdp/bat) | Better `cat` |
| [delta](https://github.com/dandavison/delta) | Better git diff |
| [k9s](https://k9scli.io) | Kubernetes TUI |

## ⌨️ Key Aliases

<details>
<summary><b>Git</b></summary>

| Alias | Command |
|-------|---------|
| `gs` | `git status` |
| `gl` | `git log --oneline -20` |
| `gd` | `git diff` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gc` | `git commit` |
| `gco` | `git checkout` |
| `gaa` | `git add --all` |
| `gcam` | `git commit -am` |
| `gundo` | `git reset --soft HEAD~1` |

</details>

<details>
<summary><b>Docker</b></summary>

| Alias | Command |
|-------|---------|
| `dc` | `docker compose` |
| `dps` | `docker ps` |
| `dstop` | Stop all containers |
| `dclean` | `docker system prune -f` |

</details>

<details>
<summary><b>Kubernetes</b></summary>

| Alias | Command |
|-------|---------|
| `k` | `kubectl` |
| `kgp` | `kubectl get pods` |
| `kgs` | `kubectl get svc` |
| `kgd` | `kubectl get deployments` |
| `kl` | `kubectl logs -f` |
| `kd` | `kubectl describe` |
| `kns` | Set current namespace |
| `kctx` | Current context |
| `kswitch` | Switch context |

</details>

<details>
<summary><b>macOS</b></summary>

| Alias | Command |
|-------|---------|
| `myip` | Public IP |
| `localip` | Local IP |
| `flushdns` | Flush DNS cache |
| `cpu` / `mem` / `disk` | Quick system stats |
| `bup` | `brew update && upgrade` |
| `cleanup_ds` | Remove `.DS_Store` recursively |

</details>

## 🔧 Functions

| Function | Description |
|----------|-------------|
| `macinfo` | System info overview |
| `cleanup` | Clean dev caches (go, npm, brew, etc) |
| `docker_cleanup` | Prune all Docker resources |
| `extract <file>` | Extract any archive format |
| `mkcd <dir>` | mkdir + cd |
| `setup_project` | Scaffold new project |
| `search_files` | Quick grep with rg fallback |
| `tree_view` | Tree with eza/tree fallback |
| `quick_backup` | Timestamped backup |

## 🧩 Optional Extras

Extras live in `extras/` and are opt-in. To enable:

```bash
cp ~/dotfiles/extras/zsh_mfa ~/.zsh_mfa
```

| Extra | Description |
|-------|-------------|
| `zsh_mfa` | TOTP codes from macOS Keychain (requires `oath-toolkit`) |

## 🎨 Customization

Machine-specific config goes in `~/.zshrc.local` (gitignored):

```bash
# ~/.zshrc.local — examples
export WORK_API_KEY="..."
alias vpn="sudo openconnect vpn.company.com"
alias m="mfa"  # personal shorthand
source ~/.cursor/aliases.zsh  # editor-specific aliases
```

## 🔒 Security

- ✅ **No secrets** in repo
- ✅ **Git identity not hardcoded** — prompted on first `setup.sh` run
- ✅ **Machine-specific config** goes in `~/.zshrc.local` (gitignored)
- ✅ `.gitignore` excludes: `.env`, `*.pem`, `*.key`, `*.secret`

## 💻 Compatibility

| Platform | Status |
|----------|--------|
| macOS Apple Silicon (M1/M2/M3/M4) | ✅ |
| macOS Intel | ✅ |

Homebrew paths auto-detected — works on both architectures.

## 🔄 Updating

Configs are symlinked, so edits take effect immediately:

```bash
cd ~/dotfiles
vim .zshrc              # edit directly
git add -A && git commit -m "update: description" && git push
```

On another machine:

```bash
cd ~/dotfiles && git pull
```

## 📄 License

MIT

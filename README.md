# 🏠 dotfiles

**macOS terminal setup for backend engineers & DevOps — one command, zero config.**

Opinionated zsh config with [Catppuccin Macchiato](https://github.com/catppuccin/catppuccin) theme, modern CLI replacements, and sane defaults for Git, Docker, and Kubernetes workflows.

![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Catppuccin](https://img.shields.io/badge/theme-Catppuccin%20Macchiato-b7bdf8?style=flat)
![CI](https://img.shields.io/github/actions/workflow/status/abdul-zailani/dotfiles/ci.yml?label=CI&logo=github)
![License](https://img.shields.io/github/license/abdul-zailani/dotfiles)

<p align="center">
  <img width="800" alt="Catppuccin Macchiato palette" src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png">
</p>

---

## Why This Exists

Most dotfile repos are either too minimal or too personal to reuse. This one is designed to be:

- **Instantly usable** — `./setup.sh` and you're done
- **Non-destructive** — existing configs are backed up automatically
- **CI-tested** — setup.sh is validated on every push via GitHub Actions
- **Extensible** — opt-in modules in `extras/`, personal overrides in `~/.zshrc.local`
- **macOS-native** — Apple Silicon + Intel, Homebrew auto-detected

## ⚡ Quick Start

```bash
git clone https://github.com/abdul-zailani/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

What `setup.sh` does:

1. Installs [Homebrew](https://brew.sh) if missing
2. Installs all packages from `Brewfile`
3. Symlinks configs to `$HOME` (backs up existing files)
4. Prompts for Git identity (first run only)
5. Creates `~/.zshrc.local` for machine-specific overrides

## 📦 What's Included

```
~/dotfiles/
├── .zshrc              # Main shell config
├── .zsh_aliases        # 50+ aliases (git, docker, k8s, macOS)
├── .zsh_functions      # 15+ utility functions
├── .gitconfig          # Git config (delta, aliases, rebase)
├── .gitignore_global   # Global gitignore
├── starship.toml       # Starship prompt — Catppuccin Macchiato
├── Brewfile            # Homebrew packages
├── extras/             # Optional modules (opt-in)
│   ├── zsh_mfa         # MFA/TOTP via macOS Keychain
│   ├── zsh_aws         # AWS profile & region switcher
│   └── zsh_docker      # Docker workflow helpers
├── .github/workflows/  # CI — tests setup.sh on macOS
└── setup.sh            # One-command bootstrap
```

## 🛠️ Modern CLI Stack

Every tool replaces a slow default with a faster, prettier alternative:

| Default | Replaced By | Why |
|---------|-------------|-----|
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | Learns your habits, jump anywhere with `z` |
| `ls` | [eza](https://github.com/eza-community/eza) | Icons, git status, tree view built-in |
| `cat` | [bat](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers |
| `git diff` | [delta](https://github.com/dandavison/delta) | Side-by-side diffs, syntax highlighting |
| `find` | [fzf](https://github.com/junegunn/fzf) | Fuzzy find anything — files, history, branches |
| prompt | [starship](https://starship.rs) | Fast, informative, shows git/k8s/aws context |
| `git` TUI | [lazygit](https://github.com/jesseduffield/lazygit) | Full git workflow without memorizing commands |
| k8s TUI | [k9s](https://k9scli.io) | Manage clusters without `kubectl` gymnastics |

All tools are optional — if not installed, the config falls back gracefully to defaults.

## ⌨️ Aliases Cheatsheet

<details>
<summary><b>Git</b> — everyday shortcuts</summary>

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
| `lg` | `lazygit` |

</details>

<details>
<summary><b>Docker</b> — container management</summary>

| Alias | Command |
|-------|---------|
| `dc` | `docker compose` |
| `dps` | `docker ps` |
| `dstop` | Stop all running containers |
| `dclean` | `docker system prune -f` |
| `drm` | Remove all stopped containers |
| `drmi` | Remove all images |

</details>

<details>
<summary><b>Kubernetes</b> — cluster operations</summary>

| Alias | Command |
|-------|---------|
| `k` | `kubectl` |
| `kgp` | `kubectl get pods` |
| `kgs` | `kubectl get svc` |
| `kgd` | `kubectl get deployments` |
| `kl` | `kubectl logs -f` |
| `kd` | `kubectl describe` |
| `kns` | Set current namespace |
| `kctx` | Show current context |
| `kswitch` | Switch context |
| `kport` | Port forward |

</details>

<details>
<summary><b>macOS</b> — system utilities</summary>

| Alias | Command |
|-------|---------|
| `myip` | Public IP |
| `localip` | Local IP |
| `flushdns` | Flush DNS cache |
| `cpu` / `mem` / `disk` | Quick system stats |
| `bup` | `brew update && upgrade` |
| `cleanup_ds` | Remove `.DS_Store` recursively |
| `ports` | Show listening ports |

</details>

## 🔧 Functions

| Function | Description |
|----------|-------------|
| `macinfo` | System info overview |
| `cleanup` | Clean dev caches (go, npm, brew, electron, etc) |
| `docker_cleanup` | Stop all containers + prune everything |
| `extract <file>` | Extract any archive (tar, gz, zip, 7z, rar) |
| `mkcd <dir>` | Create directory and cd into it |
| `setup_project <name> [type]` | Scaffold new project (go, python, node) |
| `search_files <query> [dir]` | Grep with ripgrep fallback |
| `tree_view [dir] [depth]` | Tree with eza/tree fallback |
| `quick_backup <path>` | Timestamped backup to ~/Backups |
| `netstatus` | WiFi, IP, DNS at a glance |
| `brewstatus` | Homebrew package stats |

## 🧩 Optional Extras

Extras are opt-in modules in `extras/`. Source them in `~/.zshrc.local`:

```bash
# ~/.zshrc.local
source ~/dotfiles/extras/zsh_aws
source ~/dotfiles/extras/zsh_docker
```

Or symlink to enable:

```bash
ln -sf ~/dotfiles/extras/zsh_mfa ~/.zsh_mfa
```

| Module | Description | Key Commands |
|--------|-------------|--------------|
| `zsh_mfa` | TOTP codes from macOS Keychain | `mfa`, `mfac` (interactive with fzf) |
| `zsh_aws` | AWS profile & region switcher | `awsp` (fuzzy profile switch), `awswho`, `awsregion` |
| `zsh_docker` | Docker workflow helpers | `dsh` (exec into container), `dlog`, `dip`, `dports` |

## 🎨 Customization

All personal config goes in `~/.zshrc.local` (gitignored, created by `setup.sh`):

```bash
# ~/.zshrc.local — your machine-specific overrides

# Work stuff
export WORK_API_KEY="..."
alias vpn="sudo openconnect vpn.company.com"

# Enable extras
source ~/dotfiles/extras/zsh_aws
source ~/dotfiles/extras/zsh_docker

# Personal shortcuts
alias proj="cd ~/work/my-project"
```

### Starship Prompt

The prompt shows context-aware info:

- 📁 Current directory
- 🌿 Git branch + status
- 🐳 Docker context (when active)
- ☸️ Kubernetes context + namespace
- ☁️ AWS profile + region
- 🏗️ Terraform workspace
- ⏱️ Command duration (>2s)
- 🔤 Language versions (Go, Python, Node, Rust, etc)

Edit `starship.toml` to customize. See [starship docs](https://starship.rs/config/).

## 🔒 Security

- ✅ No secrets in repo
- ✅ Git identity prompted at setup, not hardcoded
- ✅ Machine-specific config in `~/.zshrc.local` (gitignored)
- ✅ `.gitignore` blocks `.env`, `*.pem`, `*.key`, `*.secret`
- ✅ MFA secrets stored in macOS Keychain, never in files

## 💻 Compatibility

| Platform | Status |
|----------|--------|
| macOS Apple Silicon (M1/M2/M3/M4) | ✅ |
| macOS Intel | ✅ |

Homebrew paths are auto-detected — works on both architectures without changes.

## 🔄 Keeping Up to Date

Configs are symlinked, so edits in `~/dotfiles/` take effect immediately:

```bash
cd ~/dotfiles
vim .zshrc
git add -A && git commit -m "update: description" && git push
```

Pull on another machine:

```bash
cd ~/dotfiles && git pull
```

## 🤝 Contributing

Found a bug or have a useful alias/function to add? PRs welcome.

1. Fork the repo
2. Create a branch (`git checkout -b feature/cool-alias`)
3. Commit your changes
4. Open a PR

## 📄 License

[MIT](LICENSE)

---

<p align="center">
  <i>If this saved you time, a ⭐ would be appreciated!</i>
</p>

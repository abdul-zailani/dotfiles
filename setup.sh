#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { echo -e "${GREEN}✓ $1${NC}"; }
warn()  { echo -e "${YELLOW}⚠ $1${NC}"; }

# ── 1. Homebrew ───────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    info "Homebrew already installed"
fi

# ── 2. Brew packages ─────────────────────────
echo -e "${GREEN}📦 Installing packages...${NC}"
brew bundle --file="$DOTFILES/Brewfile" || true

# ── 3. Symlink dotfiles ──────────────────────
link_file() {
    local src="$1" dst="$2"
    if [ -f "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "${dst}.backup.$(date +%s)"
        warn "Backed up existing $dst"
    fi
    ln -sf "$src" "$dst"
    info "Linked $dst → $src"
}

link_file "$DOTFILES/.zshrc"            "$HOME/.zshrc"
link_file "$DOTFILES/.zsh_aliases"      "$HOME/.zsh_aliases"
link_file "$DOTFILES/.zsh_functions"    "$HOME/.zsh_functions"
link_file "$DOTFILES/.gitconfig"        "$HOME/.gitconfig"
link_file "$DOTFILES/.gitignore_global" "$HOME/.gitignore_global"

mkdir -p "$HOME/.config"
link_file "$DOTFILES/starship.toml"     "$HOME/.config/starship.toml"

# ── 4. Git identity (if not set) ─────────────
if [ -z "$(git config --global user.name)" ]; then
    echo ""
    read -p "Git name: " git_name
    read -p "Git email: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    info "Git identity configured"
fi

# ── 5. Create .zshrc.local for machine-specific config
if [ ! -f "$HOME/.zshrc.local" ]; then
    echo "# Machine-specific config (not tracked by git)" > "$HOME/.zshrc.local"
    info "Created ~/.zshrc.local for local overrides"
fi

# ── 6. Optional extras ───────────────────────
if [ -f "$DOTFILES/extras/zsh_mfa" ] && [ ! -f "$HOME/.zsh_mfa" ]; then
    read -p "Enable MFA/TOTP tools? (requires oath-toolkit) [y/N] " enable_mfa
    if [[ "$enable_mfa" =~ ^[Yy]$ ]]; then
        link_file "$DOTFILES/extras/zsh_mfa" "$HOME/.zsh_mfa"
    fi
fi

# ── 7. Set default shell ─────────────────────
if [ "$SHELL" != "/bin/zsh" ]; then
    chsh -s /bin/zsh
    info "Default shell set to zsh"
fi

echo ""
echo -e "${GREEN}✅ Setup complete! Restart terminal or run: source ~/.zshrc${NC}"

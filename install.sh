#!/usr/bin/env bash
# eltob fedora dotfiles — install.sh
# Uso: bash install.sh
# Replica o setup completo do GNOME no Fedora 44 Workstation

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info()    { echo -e "\e[1;34m==>\e[0m $*"; }
success() { echo -e "\e[1;32m OK\e[0m $*"; }
warn()    { echo -e "\e[1;33m !!\e[0m $*"; }

echo ""
echo "  eltob fedora dotfiles"
echo "  Fedora 44 / GNOME 50"
echo ""

# ── 1. Pacotes DNF ────────────────────────────────────────────────────────────
info "Instalando pacotes..."
sudo dnf install -y \
    zsh lsd micro zoxide lolcat kitty fzf neofetch fastfetch \
    gnome-extensions-app gnome-tweaks \
    jetbrains-mono-fonts \
    gamemode kvantum qt5ct mangohud
success "Pacotes instalados."

# ── 2. Oh My Zsh ──────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

info "Instalando plugins Zsh..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"    2>/dev/null || true
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
git clone --depth=1 https://github.com/Aloxaf/fzf-tab                    "$ZSH_CUSTOM/plugins/fzf-tab"                2>/dev/null || true
git clone --depth=1 https://github.com/romkatv/powerlevel10k              "$ZSH_CUSTOM/themes/powerlevel10k"           2>/dev/null || true
success "Oh My Zsh pronto."

# ── 3. atuin ──────────────────────────────────────────────────────────────────
if ! command -v atuin &>/dev/null; then
    info "Instalando atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi
success "atuin pronto."

# ── 4. Fontes Nerd Font ───────────────────────────────────────────────────────
info "Instalando fontes..."
FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONTS_DIR/ubuntu-nerd" "$FONTS_DIR/monaspace-nerd"

wget -q --show-progress -O /tmp/ubuntu-nf.tar.xz \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.tar.xz"
tar -xf /tmp/ubuntu-nf.tar.xz -C "$FONTS_DIR/ubuntu-nerd" --wildcards "*UbuntuNerdFont*" 2>/dev/null || true

wget -q --show-progress -O /tmp/monaspace-nf.tar.xz \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Monaspace.tar.xz"
tar -xf /tmp/monaspace-nf.tar.xz -C "$FONTS_DIR/monaspace-nerd" 2>/dev/null || true

fc-cache -f
success "Fontes instaladas."

# ── 5. Ícones e Cursor ────────────────────────────────────────────────────────
info "Instalando ícones kora e cursor Sunity..."
ICONS_DIR="$HOME/.local/share/icons"
mkdir -p "$ICONS_DIR"

wget -q -O /tmp/kora.tar.gz "https://github.com/bikass/kora/archive/refs/heads/master.tar.gz"
tar -xf /tmp/kora.tar.gz -C /tmp/
cp -r /tmp/kora-master/kora /tmp/kora-master/kora-pgrey "$ICONS_DIR/"

wget -q -O /tmp/sunity.tar.gz \
    "https://github.com/alvatip/Sunity-cursors/releases/latest/download/Sunity-cursors.tar.gz"
tar -xf /tmp/sunity.tar.gz -C "$ICONS_DIR/"
success "Ícones e cursor instalados."

# ── 6. Tema Catppuccin Macchiato para Kitty ───────────────────────────────────
info "Instalando tema Kitty..."
mkdir -p "$HOME/.config/kitty"
wget -q -O "$HOME/.config/kitty/current-theme.conf" \
    "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/macchiato.conf"
success "Tema Kitty instalado."

# ── 7. Wallpapers ─────────────────────────────────────────────────────────────
info "Copiando wallpapers..."
mkdir -p "$HOME/.local/share/backgrounds"
cp "$DOTFILES_DIR/backgrounds/"* "$HOME/.local/share/backgrounds/" 2>/dev/null || \
    warn "Pasta backgrounds/ vazia — adicione os wallpapers manualmente em ~/.local/share/backgrounds/"

# ── 8. Dotfiles (symlinks) ────────────────────────────────────────────────────
info "Criando symlinks..."

[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
ln -sf "$DOTFILES_DIR/shell/.zshrc"                    "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/terminal/kitty/kitty.conf"       "$HOME/.config/kitty/kitty.conf"
mkdir -p "$HOME/.config/fastfetch"
ln -sf "$DOTFILES_DIR/apps/fastfetch/config.jsonc"     "$HOME/.config/fastfetch/config.jsonc"
mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"
ln -sf "$DOTFILES_DIR/gtk/gtk-3.0/gtk.css"             "$HOME/.config/gtk-3.0/gtk.css"
ln -sf "$DOTFILES_DIR/gtk/gtk-4.0/gtk.css"             "$HOME/.config/gtk-4.0/gtk.css"
success "Symlinks criados."

# ── 9. Zsh como shell padrão ──────────────────────────────────────────────────
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Definindo zsh como shell padrão..."
    chsh -s "$(which zsh)"
fi

# ── 10. GameMode ──────────────────────────────────────────────────────────────
info "Ativando GameMode..."
systemctl --user enable --now gamemoded 2>/dev/null || true
success "GameMode ativo."

# ── 11. Kvantum — tema Catppuccin Macchiato Blue ──────────────────────────────
info "Instalando tema Kvantum..."
mkdir -p "$HOME/.config/Kvantum"
git clone --depth=1 https://github.com/catppuccin/Kvantum.git /tmp/catppuccin-kvantum 2>/dev/null || true
cp -r /tmp/catppuccin-kvantum/themes/catppuccin-macchiato-blue "$HOME/.config/Kvantum/"
kvantummanager --set catppuccin-macchiato-blue 2>/dev/null || true
success "Kvantum configurado."

# ── 12. MangoHud ──────────────────────────────────────────────────────────────
info "Configurando MangoHud..."
mkdir -p "$HOME/.config/MangoHud"
ln -sf "$DOTFILES_DIR/apps/MangoHud/MangoHud.conf" "$HOME/.config/MangoHud/MangoHud.conf"
success "MangoHud configurado."

# ── 13. ProtonUp-Qt ───────────────────────────────────────────────────────────
info "Instalando ProtonUp-Qt..."
flatpak install -y flathub net.davidotek.pupgui2 2>/dev/null || true
success "ProtonUp-Qt instalado."

# ── 14. Claude Usage Indicator ────────────────────────────────────────────────
info "Instalando Claude Usage Indicator..."
EXT_DIR="$HOME/.local/share/gnome-shell/extensions/claude-usage@eltobsjr.gmail.com"
if [[ ! -d "$EXT_DIR" ]]; then
    git clone --depth=1 https://github.com/eltobsjr/claudeUsageIndicator.git /tmp/claude-usage
    mkdir -p "$EXT_DIR"
    cp -r /tmp/claude-usage/* "$EXT_DIR/"
fi
success "Claude Usage Indicator instalado."

# ── 15. GNOME configs (após extensões instaladas) ─────────────────────────────
echo ""
warn "PRÓXIMO PASSO MANUAL:"
echo ""
echo "  Instale as extensões abaixo em extensions.gnome.org:"
echo ""
echo "  Open Bar          → https://extensions.gnome.org/extension/6580/"
echo "  Blur My Shell     → https://extensions.gnome.org/extension/3193/"
echo "  Dash to Dock      → https://extensions.gnome.org/extension/307/"
echo "  Forge             → https://extensions.gnome.org/extension/4481/"
echo "  Just Perfection   → https://extensions.gnome.org/extension/3843/"
echo "  User Themes       → https://extensions.gnome.org/extension/19/"
echo "  AppIndicator      → https://extensions.gnome.org/extension/615/"
echo "  Caffeine          → https://extensions.gnome.org/extension/517/"
echo "  Vitals            → https://extensions.gnome.org/extension/1460/"
echo "  Clipboard Ind.    → https://extensions.gnome.org/extension/779/"
echo ""
echo "  Após instalar todas, rode:"
echo "  bash $DOTFILES_DIR/gnome/apply-dconf.sh"
echo ""
echo "  Depois faça logout e login."
echo ""
echo "  Para gaming — nas propriedades de cada jogo no Steam adicione:"
echo "  mangohud gamemoderun %command%"
echo ""
echo "  Para instalar GE-Proton: abra o ProtonUp-Qt → Adicionar versão → GE-Proton."
echo ""
success "Setup concluído! Siga os passos acima para finalizar o visual."

#!/usr/bin/env bash
# eltob-fedora-dotfiles — install.sh
# Replica o setup GNOME no Fedora 44 Workstation
# Executar após instalar o Fedora e fazer login

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

info()    { echo -e "\e[1;34m[INFO]\e[0m $*"; }
success() { echo -e "\e[1;32m[OK]\e[0m $*"; }
warn()    { echo -e "\e[1;33m[AVISO]\e[0m $*"; }
ask()     { read -rp "$(echo -e "\e[1;35m[?]\e[0m $* [s/N] ")" ans && [[ "$ans" =~ ^[Ss]$ ]]; }

# ─── 1. Pacotes DNF ───────────────────────────────────────────────────────────

install_packages() {
    info "Instalando pacotes via DNF..."
    sudo dnf install -y \
        zsh \
        lsd \
        micro \
        zoxide \
        lolcat \
        kitty \
        fzf \
        neofetch \
        fastfetch \
        gnome-extensions-app \
        gnome-tweaks \
        jetbrains-mono-fonts

    success "Pacotes DNF instalados."
}

# ─── 2. Oh My Zsh + Plugins ───────────────────────────────────────────────────

install_omz() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        warn "Oh My Zsh já instalado, pulando."
        return
    fi
    info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    info "Instalando plugins Zsh..."
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    git clone https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
    git clone https://github.com/Aloxaf/fzf-tab                     "$ZSH_CUSTOM/plugins/fzf-tab" 2>/dev/null || true
    git clone --depth=1 https://github.com/romkatv/powerlevel10k    "$ZSH_CUSTOM/themes/powerlevel10k" 2>/dev/null || true

    success "Oh My Zsh e plugins instalados."
}

# ─── 3. atuin ─────────────────────────────────────────────────────────────────

install_atuin() {
    if command -v atuin &>/dev/null; then
        warn "atuin já instalado, pulando."
        return
    fi
    info "Instalando atuin (histórico de shell)..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    success "atuin instalado."
}

# ─── 4. Fontes ────────────────────────────────────────────────────────────────

install_fonts() {
    info "Instalando fontes Nerd Font..."
    local FONTS_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONTS_DIR"

    # Ubuntu Nerd Font
    local UBUNTU_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.tar.xz"
    wget -q -O /tmp/ubuntu-nf.tar.xz "$UBUNTU_URL"
    mkdir -p "$FONTS_DIR/ubuntu-nerd"
    tar -xf /tmp/ubuntu-nf.tar.xz -C "$FONTS_DIR/ubuntu-nerd" --wildcards "*UbuntuNerdFont*" 2>/dev/null || true

    # Monaspace Nerd Font
    local MONO_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Monaspace.tar.xz"
    wget -q -O /tmp/monaspace-nf.tar.xz "$MONO_URL"
    mkdir -p "$FONTS_DIR/monaspace-nerd"
    tar -xf /tmp/monaspace-nf.tar.xz -C "$FONTS_DIR/monaspace-nerd" 2>/dev/null || true

    fc-cache -f
    success "Fontes instaladas."
}

# ─── 5. Ícones e Cursores ────────────────────────────────────────────────────

install_icons() {
    info "Instalando ícones kora e cursor Sunity..."
    local ICONS_DIR="$HOME/.local/share/icons"
    mkdir -p "$ICONS_DIR"

    # kora
    local KORA_URL="https://github.com/bikass/kora/archive/refs/heads/master.tar.gz"
    wget -q -O /tmp/kora.tar.gz "$KORA_URL"
    tar -xf /tmp/kora.tar.gz -C /tmp/
    cp -r /tmp/kora-master/kora "$ICONS_DIR/"
    cp -r /tmp/kora-master/kora-pgrey "$ICONS_DIR/"

    # Sunity cursors
    local SUNITY_URL="https://github.com/alvatip/Sunity-cursors/releases/latest/download/Sunity-cursors.tar.gz"
    wget -q -O /tmp/sunity.tar.gz "$SUNITY_URL"
    tar -xf /tmp/sunity.tar.gz -C "$ICONS_DIR/"

    success "Ícones e cursores instalados."
}

# ─── 6. Kitty Catppuccin theme ───────────────────────────────────────────────

install_kitty_theme() {
    info "Instalando tema Catppuccin Macchiato para Kitty..."
    local KITTY_CONF="$HOME/.config/kitty"
    mkdir -p "$KITTY_CONF"
    local THEME_URL="https://raw.githubusercontent.com/catppuccin/kitty/main/themes/macchiato.conf"
    wget -q -O "$KITTY_CONF/current-theme.conf" "$THEME_URL"
    success "Tema Kitty instalado."
}

# ─── 7. Dotfiles (symlinks) ───────────────────────────────────────────────────

link_dotfiles() {
    info "Criando symlinks dos dotfiles..."

    # .zshrc
    [[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"

    # kitty
    mkdir -p "$HOME/.config/kitty"
    ln -sf "$DOTFILES_DIR/terminal/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

    # fastfetch
    mkdir -p "$HOME/.config/fastfetch"
    ln -sf "$DOTFILES_DIR/apps/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

    # GTK
    mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"
    ln -sf "$DOTFILES_DIR/gtk/gtk-3.0/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
    ln -sf "$DOTFILES_DIR/gtk/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"

    success "Symlinks criados."
}

# ─── 8. GNOME Extensions ─────────────────────────────────────────────────────

install_extensions() {
    info "Extensões GNOME precisam ser instaladas manualmente."
    info "Acesse: https://extensions.gnome.org"
    cat <<'EOF'

  Extensões obrigatórias:
    - Open Bar:           https://extensions.gnome.org/extension/6580/
    - Blur My Shell:      https://extensions.gnome.org/extension/3193/
    - Dash to Dock:       https://extensions.gnome.org/extension/307/
    - Forge:              https://extensions.gnome.org/extension/4481/
    - Just Perfection:    https://extensions.gnome.org/extension/3843/
    - User Themes:        https://extensions.gnome.org/extension/19/
    - AppIndicator:       https://extensions.gnome.org/extension/615/
    - Caffeine:           https://extensions.gnome.org/extension/517/
    - Vitals:             https://extensions.gnome.org/extension/1460/
    - Clipboard Indicator: https://extensions.gnome.org/extension/779/

  Após instalar todas, execute:
    bash "$DOTFILES_DIR/gnome/apply-dconf.sh"

EOF
}

# ─── 9. GNOME dconf ──────────────────────────────────────────────────────────

apply_dconf() {
    info "Aplicando configurações GNOME via dconf..."

    # gsettings básicos
    bash "$DOTFILES_DIR/gnome/gsettings.sh"

    # Extensões
    dconf load /org/gnome/shell/extensions/ < "$DOTFILES_DIR/gnome/dconf-extensions.ini"

    # WM
    dconf load /org/gnome/desktop/wm/ < "$DOTFILES_DIR/gnome/dconf-wm.ini"

    # Forçar reload do Open Bar
    dconf write /org/gnome/shell/extensions/openbar/trigger-reload true
    sleep 0.5
    dconf write /org/gnome/shell/extensions/openbar/trigger-reload false

    success "dconf aplicado. Faça logout/login para garantir que tudo carregue."
}

# ─── 10. Zsh como shell padrão ───────────────────────────────────────────────

set_zsh_default() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        warn "zsh já é o shell padrão."
        return
    fi
    info "Definindo zsh como shell padrão..."
    chsh -s "$(which zsh)"
    success "zsh definido. Faça logout/login para efeito."
}

# ─── Menu principal ───────────────────────────────────────────────────────────

main() {
    echo ""
    echo "  eltob-fedora-dotfiles"
    echo "  Fedora 44 / GNOME 50"
    echo ""

    ask "Instalar pacotes DNF?"            && install_packages
    ask "Instalar Oh My Zsh + plugins?"   && install_omz
    ask "Instalar atuin?"                  && install_atuin
    ask "Instalar fontes Nerd Font?"       && install_fonts
    ask "Instalar ícones + cursores?"      && install_icons
    ask "Instalar tema Kitty Catppuccin?"  && install_kitty_theme
    ask "Criar symlinks dos dotfiles?"     && link_dotfiles
    ask "Definir zsh como shell padrão?"   && set_zsh_default

    echo ""
    install_extensions
    echo ""
    ask "Aplicar configs GNOME via dconf (após instalar extensões)?" && apply_dconf

    echo ""
    success "Setup completo! Faça logout e login para tudo carregar."
}

main "$@"

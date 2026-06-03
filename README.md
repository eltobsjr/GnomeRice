# eltob-fedora-dotfiles

Setup pessoal do GNOME no Fedora 44 Workstation.

**Hardware:** ASUS ROG Strix G513RC · RTX 3050 · LG UltraWide 2560×1080 + tela 1080p

---

## Visual

| | |
|---|---|
| Shell | GNOME 50 / Wayland |
| Painel | Open Bar (modo Islands, azul navy `#163570`) |
| Dock | Dash to Dock + Blur My Shell |
| Tiling | Forge |
| GTK | Adwaita dark |
| Ícones | kora |
| Cursor | Sunity-cursors |
| Fonte UI | Ubuntu Nerd Font 11 |
| Fonte terminal | Monaspace Neon NF 12 |
| Terminal | Kitty + Catppuccin Macchiato |
| Shell | Zsh + Oh My Zsh + Powerlevel10k |
| FZF | Catppuccin Macchiato |
| Spotify | Spicetify + Catppuccin Macchiato |

---

## Estrutura

```
dotfiles/
├── install.sh                  # Script de instalação interativo
├── README.md
├── docs/
│   └── GLOSSARIO.md            # Documentação completa de cada componente
├── gnome/
│   ├── apply-dconf.sh          # Aplica todas as configs GNOME de uma vez
│   ├── gsettings.sh            # gsettings básicos (tema, fonte, cursor...)
│   ├── dconf-extensions.ini    # Config de todas as extensões (dconf dump)
│   ├── dconf-desktop.ini       # Config do desktop GNOME
│   ├── dconf-wm.ini            # Botões de janela + keybindings WM
│   └── extensions.list         # Lista de extensões com links
├── shell/
│   └── .zshrc                  # Zsh config (OMZ, plugins, aliases, tools)
├── terminal/
│   └── kitty/
│       └── kitty.conf          # Config do Kitty (fonte, tema, padding...)
├── apps/
│   └── fastfetch/
│       └── config.jsonc        # Fastfetch customizado
└── gtk/
    ├── gtk-3.0/gtk.css         # Cor de acento GTK3 (#1a3a6e)
    └── gtk-4.0/gtk.css         # Cor de acento GTK4 (#1a3a6e)
```

---

## Instalação rápida

```bash
git clone https://github.com/<seu-usuario>/fedora-dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

O script é interativo — pergunta antes de cada passo.

### Passos manuais obrigatórios

**1. Instalar extensões GNOME** (o script não automatiza isso):

| Extensão | Link |
|---|---|
| Open Bar | https://extensions.gnome.org/extension/6580/ |
| Blur My Shell | https://extensions.gnome.org/extension/3193/ |
| Dash to Dock | https://extensions.gnome.org/extension/307/ |
| Forge | https://extensions.gnome.org/extension/4481/ |
| Just Perfection | https://extensions.gnome.org/extension/3843/ |
| User Themes | https://extensions.gnome.org/extension/19/ |
| AppIndicator | https://extensions.gnome.org/extension/615/ |
| Caffeine | https://extensions.gnome.org/extension/517/ |
| Vitals | https://extensions.gnome.org/extension/1460/ |
| Clipboard Indicator | https://extensions.gnome.org/extension/779/ |
| Claude Usage Indicator | https://github.com/eltobsjr/claudeUsageIndicator |

**2. Após instalar as extensões**, aplicar as configs:

```bash
bash ~/dotfiles/gnome/apply-dconf.sh
```

**3. Logout/login** para carregar as extensões no Wayland.

**4. Wallpaper**: copiar os arquivos de `backgrounds/` para `~/.local/share/backgrounds/` e selecionar no Open Bar.

---

## Componentes que precisam de instalação manual separada

- **NVM** — `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash`
- **Spicetify** — `curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh` (após instalar Spotify Flatpak)
- **p10k** — configurar com `p10k configure` após instalar o OMZ

---

## Notas

- O wallpaper ativo no Open Bar é `train_and_lake.png` — ajustar o path nas configs do dconf se o usuário for diferente de `eltobsjr`
- O alias `du` no `.zshrc` sobrescreve o comando do sistema `du` (disk usage) — ciente disso, renomear para `dnu` se preferir
- `fastfetch` está configurado mas o `.zshrc` chama `neofetch` — trocar se preferir o fastfetch

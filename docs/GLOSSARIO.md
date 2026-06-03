# Glossário do Setup GNOME — eltob

> Fedora 44 Workstation · GNOME 50 · Wayland
> Hardware: ASUS ROG Strix G513RC · GPU: RTX 3050 · Monitor: LG UltraWide 2560×1080 + tela interna 1080p

---

## Sistema base

| Componente | Valor |
|---|---|
| OS | Fedora 44 Workstation |
| Desktop | GNOME 50 (Wayland) |
| Shell | Zsh + Oh My Zsh + Powerlevel10k |
| Terminal | Kitty |
| Editor | micro |
| Gestor de pacotes | dnf (sistema) + flatpak (apps) |

---

## Tema visual

| Componente | Valor | Observação |
|---|---|---|
| GTK theme | Adwaita (dark) | Via `color-scheme=prefer-dark` |
| GNOME Shell theme | `''` (padrão) | Open Bar assume o theming do shell |
| Icon theme | kora | `~/.local/share/icons/kora` |
| Cursor | Sunity-cursors | `~/.local/share/icons/Sunity-cursors` |
| Cor de acento | `#163570` (azul navy) | Definido no Open Bar (`iscolor`, `mscolor`, `accent-color`) |
| Color scheme | `prefer-dark` | |

### Paleta de cor (Open Bar)

| Papel | Cor hex | dconf key |
|---|---|---|
| Fundo da barra | transparente | `bgalpha=0.0` |
| Islands (pills) | `#163570` a 65% | `iscolor`, `isalpha=0.65` |
| Cards ativos (painel rápido) | `#163570` | `mscolor` |
| Acento (shell accent) | `#1e3a8a` | `accent-color` |
| Fundo do dock | `rgba(22,53,112,0.78)` | Blur My Shell `dash-to-dock/color` |

---

## Extensões GNOME

### Ativas

| Extensão | UUID | Função |
|---|---|---|
| **Open Bar** | `openbar@neuromorph` | Estiliza o painel top (modo Islands), menus e shell. Controla todas as cores. |
| **Blur My Shell** | `blur-my-shell@aunetx` | Aplica blur no dock (Dash to Dock) e no overview. Painel=false (Open Bar já faz). |
| **Dash to Dock** | `dash-to-dock@micxgx.gmail.com` | Dock inferior fixo. Cor controlada pelo Blur My Shell. |
| **Forge** | `forge@jmmaranan.com` | Tiling de janelas (BSP). Ativo. |
| **Just Perfection** | `just-perfection-desktop@just-perfection` | Tweaks do shell (clock position, etc.) |
| **User Themes** | `user-theme@gnome-shell-extensions.gcampax.github.com` | Necessário para Open Bar funcionar. Shell theme = `''`. |
| **AppIndicator** | `appindicatorsupport@rgcjonas.gmail.com` | Suporte a ícones de app na bandeja (systray). |
| **Caffeine** | `caffeine@patapon.info` | Impede bloqueio/sleep enquanto ativo. |
| **Vitals** | `Vitals@CoreCoding.com` | Monitoramento de CPU/RAM/temp no painel. |
| **Clipboard Indicator** | `clipboard-indicator@Dieg0Js.github.io` | Histórico de clipboard com Super+V. |
| **Claude Usage** | `claude-usage@eltobsjr.gmail.com` | Mostra tokens/custo Claude Code no painel. Instalar via [github.com/eltobsjr/claudeUsageIndicator](https://github.com/eltobsjr/claudeUsageIndicator) |
| **Background Logo** | `background-logo@fedorahosted.org` | Logo Fedora no fundo. Default do Fedora, mantido. |

### Instaladas mas NÃO usadas (residuais — podem ser removidas)

| Extensão | UUID | Por que está aqui |
|---|---|---|
| ArcMenu | `arcmenu@arcmenu.com` | Testado e rejeitado. Apenas config de versão salva. |
| Tiling Shell | `tilingshell@ferrarodomenico.com` | Substituído pelo Forge. Tem configs salvas mas está desabilitado. |
| Rounded Window Corners (old) | `rounded-window-corners@yilozt` | Versão antiga (GNOME 40-44), desatualizada. |
| Rounded Window Corners Reborn | `rounded-window-corners@fxgn` | Instalado mas não usado. |
| Pop Shell | `pop-shell@system76.com` | Extensão do sistema, substituída pelo Forge. |

---

## Fonte

| Uso | Fonte |
|---|---|
| Interface GNOME | Ubuntu Nerd Font 11 |
| Terminal (Kitty) | Monaspace Neon NF 12 |
| Monospace (sistema) | Adwaita Mono 11 |
| Documento | Adwaita Sans 12 |

Instaladas em `~/.local/share/fonts/`:
- `monaspace-nerd/` — família Monaspace Nerd Font (Argon, Krypton, Neon, Radon, Xenon)
- `ubuntu-nerd/` — Ubuntu Nerd Font

---

## Shell (Zsh)

### Plugins Oh My Zsh
| Plugin | Função |
|---|---|
| `git` | Aliases e completions git |
| `zsh-autosuggestions` | Sugestões de comando baseadas no histórico |
| `fzf` | Fuzzy finder integrado ao Ctrl+R |
| `fzf-tab` | Tab completion fuzzy |
| `zsh-syntax-highlighting` | Syntax highlighting no terminal |

### Tema
- **Powerlevel10k** (`powerlevel10k/powerlevel10k`)

### Ferramentas CLI
| Ferramenta | Função | Alias/Comando |
|---|---|---|
| `lsd` | `ls` moderno com ícones Nerd Font | `ls`, `ll`, `la`, `lt` |
| `zoxide` | `cd` inteligente com histórico | `cd` (substituído) |
| `atuin` | Histórico de shell sincronizado | `Ctrl+R` |
| `micro` | Editor de texto no terminal | `$EDITOR`, `$VISUAL` |
| `fzf` | Fuzzy finder | `Ctrl+R`, tab completion |
| `neofetch` | System info no login | chamado no topo do `.zshrc` |
| `fastfetch` | System info alternativo (configurado mas não chamado) | `fastfetch` |
| `lolcat` | Colorir texto com gradiente | usado no banner de login |
| `nvm` | Node Version Manager | `nvm` |

### Aliases principais
```zsh
# Sistema
cls    → clear
upd    → sudo dnf upgrade --refresh
nano   → nano -/

# Arquivos
ls/ll/la/lt → lsd ...

# Flatpak
fpi → flatpak install flathub
fpu → flatpak update
fpr → flatpak uninstall --delete-data
fps → flatpak search
fpl → flatpak list

# DNF
di → sudo dnf install
du → sudo dnf upgrade        # ⚠️ CONFLITO com comando do sistema 'du' (disk usage)
dr → sudo dnf remove
ds → dnf search
dl → dnf history list
```

### FZF — tema Catppuccin Macchiato
Definido via `$FZF_DEFAULT_OPTS` no `.zshrc`.

---

## Terminal (Kitty)

| Config | Valor |
|---|---|
| Fonte | Monaspace Neon NF 12 |
| Tema | Catppuccin Macchiato |
| Padding | 6px top/bottom, 8px left/right |
| Decorações | Ocultas (`hide_window_decorations yes`) |
| Tamanho inicial | 850×550 |
| Blink do cursor | Desabilitado |
| Cursor trail | Ativado |

---

## Spicetify (Spotify)

| Config | Valor |
|---|---|
| Tema | Catppuccin Macchiato |
| Spotify | Flatpak (`com.spotify.Client`) |
| Extensions | marketplace |

---

## Wallpapers disponíveis

Localizados em `~/.local/share/backgrounds/`:
| Arquivo | Uso atual |
|---|---|
| `train_and_lake.png` | Ativo no Open Bar |
| `2026-01-11-07-23-02-cloud.jpg` | Ativo no desktop GNOME nativo |
| `bloom-dark-linux.jpg` | Alternativa |
| `bloom-linux.jpg` | Alternativa |

---

## Atalhos de teclado customizados

| Atalho | Ação | Origem |
|---|---|---|
| `Super+Y` | Próximo layout de tiling (Forge) | Tiling Shell config (residual — verificar se funciona no Forge) |
| `Super+Shift+Y` | Layout anterior de tiling | Tiling Shell config (residual) |
| `Super+Left/Right` | Move janela entre tiles | Tiling Shell config (residual) |
| `Super+Up` | Maximizar janela | WM nativo |
| `Super+Down` | Restaurar janela | WM nativo |
| `Super+C` | Mover janela para centro | Tiling Shell config (residual) |

---

## Problemas identificados / Resíduos

### 1. `alias du` conflita com o comando do sistema
`alias du='sudo dnf upgrade'` sobrescreve `du` (disk usage). Renomear para `dnu`.

### 2. Tiling duplo: Forge ativo + TilingShell configs salvas
Forge está ativo. Tiling Shell está desabilitado mas tem layouts e atalhos configurados no dconf.
Os atalhos do Tiling Shell (`Super+Y`, `Super+Left` etc.) podem não funcionar no Forge.
Ação: verificar quais atalhos do Forge estão ativos e documentar corretamente.

### 3. Extensões residuais instaladas
ArcMenu, TilingShell, Rounded Window Corners (x2), Pop Shell — todas desabilitadas.
Podem ser removidas com `rm -rf ~/.local/share/gnome-shell/extensions/<uuid>`.

### 4. Catppuccin GTK theme em `~/.local/share/themes/`
3 variantes instaladas (`macchiato-blue-standard+default`, `-hdpi`, `-xhdpi`) + `eltob-dock`.
O GTK usa Adwaita. Esses arquivos são resíduos. Podem ser removidos.

### 5. `neofetch` chamado no `.zshrc` mas `fastfetch` também configurado
Dois system info tools configurados. Considerar migrar para fastfetch (mais rápido e bem configurado).

### 6. Config residual do `fish` em `~/.config/fish/`
Só tem `conf.d/`, shell não usa fish.

### 7. Config residual do `pop-shell` em `~/.config/pop-shell/`
Extensão desabilitada, config fica. Pode remover `~/.config/pop-shell/`.

### 8. `monitors.xml~` (backup) ao lado de `monitors.xml`
Arquivo de backup residual em `~/.config/monitors.xml~`.

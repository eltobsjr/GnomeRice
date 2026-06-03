neofetch

# show a gradient text on launch
echo -e "\e[1mFedora Workstation\e[0m" | lolcat -b -g 3c6eb4:00ffff
echo ""

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions fzf fzf-tab zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

alias cls='clear'

alias zshconfig="micro ~/.zshrc"
alias kittyconf="micro ~/.config/kitty/kitty.conf"

alias upd="sudo dnf upgrade --refresh"

# lsd
alias ls='lsd --group-directories-first'
alias ll='lsd -la --group-directories-first'
alias la='lsd -A --group-directories-first'
alias lt='lsd --tree'

# flatpak
alias fpi='flatpak install flathub'
alias fpu='flatpak update'
alias fpr='flatpak uninstall --delete-data'
alias fps='flatpak search'
alias fpl='flatpak list'

# dnf
alias di='sudo dnf install'
alias dnu='sudo dnf upgrade'
alias dr='sudo dnf remove'
alias ds='dnf search'
alias dl='dnf history list'

# nano
alias nano='nano -/'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Catppuccin Macchiato theme for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

export EDITOR='micro'
export VISUAL='micro'
export MICRO_TRUECOLOR=1

# PATH
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH=$PATH:/home/eltobsjr/.spicetify

# Qt Kvantum theme
export QT_STYLE_OVERRIDE=kvantum

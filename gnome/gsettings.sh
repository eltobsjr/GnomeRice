#!/usr/bin/env bash
# Aplicar configurações do GNOME Interface
# Executa APÓS instalar as extensões e reiniciar o GNOME

set -e

echo "Aplicando gsettings..."

gsettings set org.gnome.desktop.interface gtk-theme          'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme       'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme         'kora'
gsettings set org.gnome.desktop.interface cursor-theme       'Sunity-cursors'
gsettings set org.gnome.desktop.interface font-name          'Ubuntu Nerd Font 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono 11'
gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 12'
gsettings set org.gnome.desktop.interface accent-color       'blue'
gsettings set org.gnome.desktop.interface enable-animations  true

gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"

echo "gsettings aplicados."

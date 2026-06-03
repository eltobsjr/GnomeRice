#!/usr/bin/env bash
# Aplica todas as configs GNOME via dconf
# Executar APÓS instalar as extensões e reiniciar o GNOME Shell

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[1/4] gsettings interface..."
bash "$SCRIPT_DIR/gsettings.sh"

echo "[2/4] dconf extensões..."
dconf load /org/gnome/shell/extensions/ < "$SCRIPT_DIR/dconf-extensions.ini"

echo "[3/4] dconf WM + keybindings..."
dconf load /org/gnome/desktop/wm/ < "$SCRIPT_DIR/dconf-wm.ini"

echo "[4/4] Reload Open Bar..."
dconf write /org/gnome/shell/extensions/openbar/trigger-reload true
sleep 0.5
dconf write /org/gnome/shell/extensions/openbar/trigger-reload false

echo ""
echo "Feito. Faça logout/login para carregar as extensões corretamente."

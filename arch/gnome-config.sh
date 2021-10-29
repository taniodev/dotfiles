#!/usr/bin/env bash
set -e

if [ `id -u` -eq 0 ]; then
    echo "Não execute como super usuário"
    exit 1
fi


# Configura o layout de teclado na interface
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br')]"

# Fazer o Alt+Tab alternar aplicativos apenas no espaço de trabalho atual
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Trocar para os espaços de trabalho da direita e da esquerda
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"

# Mover a janela para os espaços de trabalho da direita e da esquerda
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift><Super>Left']"

# Abrir o painel de configurações
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>i']"

# Abrir a pasta pessoal no explorador de arquivos
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

# Tempo em segundos que o computador conectado na tomada precisa estar inativo até ir dormir (0 = nunca).
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 7200


echo "Concluído!"

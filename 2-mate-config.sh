#!/usr/bin/env bash
set -e

if [ `id -u` -eq 0 ]; then
    echo "Não execute como super usuário"
    exit 1
fi


# Configura o layout de teclado na interface
gsettings set org.mate.peripherals-keyboard-xkb.kbd layouts "['br']"

# Configurações de acessibilidade do Mate
gsettings set org.gnome.desktop.a11y.applications screen-reader-enabled true
gsettings set org.mate.interface accessibility true

# Habilita os sons do sistema
gsettings set org.mate.sound theme-name 'freedesktop'
gsettings set org.mate.sound event-sounds true
gsettings set org.mate.sound input-feedback-sounds true

# Desativa a exibição de alguns ícones na área de trabalho
gsettings set org.mate.caja.desktop computer-icon-visible false
gsettings set org.mate.caja.desktop volumes-visible false
gsettings set org.mate.caja.desktop home-icon-visible false

# Desabilita o bloqueio da tela quando entrar a proteção de tela
gsettings set org.mate.screensaver lock-enabled false

# Desativa a suspensão automática ao fechar a tampa do notebook
gsettings set org.mate.power-manager button-lid-ac 'nothing'
gsettings set org.mate.power-manager button-lid-battery 'nothing'

# Ajusta o brilho da tela
gsettings set org.mate.power-manager brightness-ac 5.0


# Configura algumas teclas de atalho
# Abrir o gerenciador de arquivos
gsettings set org.mate.Marco.global-keybindings run-command-1 '<Mod4>e'
gsettings set org.mate.Marco.keybinding-commands command-1 'caja'

# Iniciar ou parar o leitor de telas
gsettings set org.mate.SettingsDaemon.plugins.media-keys screenreader '<Mod4><Alt>s'

# Abrir o terminal
gsettings set org.mate.Marco.global-keybindings run-command-terminal '<Control><Alt>t'

# Mostrar a área de trabalho
gsettings set org.mate.Marco.global-keybindings show-desktop '<Mod4>m'

# Atalhos para manipulação de janelas e workspaces
gsettings set org.mate.Marco.window-keybindings maximize '<Mod4>Up'
gsettings set org.mate.Marco.window-keybindings minimize '<Mod4>Down'
gsettings set org.mate.Marco.global-keybindings switch-to-workspace-left '<Mod4><Control>Left'
gsettings set org.mate.Marco.global-keybindings switch-to-workspace-right '<Mod4><Control>Right'
gsettings set org.mate.Marco.global-keybindings switch-to-workspace-up '<Mod4><Control>Up'
gsettings set org.mate.Marco.global-keybindings switch-to-workspace-down '<Mod4><Control>Down'
gsettings set org.mate.Marco.window-keybindings move-to-workspace-left '<Mod4><Control><Shift>Left'
gsettings set org.mate.Marco.window-keybindings move-to-workspace-right '<Mod4><Control><Shift>Right'
gsettings set org.mate.Marco.window-keybindings move-to-workspace-up '<Mod4><Control><Shift>Up'
gsettings set org.mate.Marco.window-keybindings move-to-workspace-down '<Mod4><Control><Shift>Down'

#!/usr/bin/env bash
set -e

if [ `id -u` -ne 0 ]; then
    echo "Execute utilizando sudo"
    exit 1
elif [ -e $SUDO_USER ] || [ $SUDO_USER == "root" ]; then
    echo "Altere para um usuário não root e execute utilizando o sudo"
    exit 1
fi


user=$SUDO_USER

# Pacotes a instalar
pacotes=(
    xorg-server mate mate-extra lightdm lightdm-gtk-greeter
    git emacs espeak-ng openssh orca vlc wget xdg-user-dirs
    chromium firefox firefox-i18n-pt-br thunderbird thunderbird-i18n-pt-br w3m
)

pacman -S --needed --noconfirm ${pacotes[@]}

# Pacotes do AUR a instalar
sudo -i -u $user << 'EOF'
    pacotes=(
        emacspeak hunspell-pt-br visual-studio-code-bin yaru-sound-theme
    )

    mkdir -p ~/.builds && cd ~/.builds
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -sirc --needed --noconfirm
    yay -S --needed --noconfirm ${pacotes[@]}
EOF

# Desativar serviços
systemctl disable sshd


# Ativa o leitor de telas no gerenciador de login
sed -i "s/#reader=/reader=orca/" /etc/lightdm/lightdm-gtk-greeter.conf
sed -i "/reader=orca/a a11y-states=+reader" /etc/lightdm/lightdm-gtk-greeter.conf

# Carrega o lightdm na inicialização
systemctl enable lightdm


# Configura o layout de teclado
sudo -u $user localectl set-x11-keymap br


# Configurações do Git
sudo -i -u $user << 'EOF'
    git config --global user.name "Tânio Scherer"
    git config --global user.email "tanioms3@gmail.com"
    touch ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.editor nano
    git config --global pull.rebase true   # rebase
EOF


echo "Concluído!"

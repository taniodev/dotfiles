#!/usr/bin/env bash
set -e

# Pacotes a instalar
pacotes=(
    xorg-server mate mate-extra lightdm lightdm-gtk-greeter
)

pacman -S --needed --noconfirm ${pacotes[@]}


# Ativa o leitor de telas no gerenciador de login
sed -i "s/#reader=/reader=orca/" /etc/lightdm/lightdm-gtk-greeter.conf
sed -i "/reader=orca/a a11y-states=+reader" /etc/lightdm/lightdm-gtk-greeter.conf

# Carrega o lightdm na inicialização
systemctl enable lightdm

echo "Concluído!"

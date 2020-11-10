#!/usr/bin/env bash
set -e

if [ `id -u` -eq 0 ]; then
    echo "Não execute como super usuário"
    exit 1
fi


# Pacotes do AUR a instalar
pacotes=(
    brisk-menu emacspeak hunspell-pt-br visual-studio-code-bin yaru-sound-theme
)

# Instala o yay para gerenciar os pacotes
mkdir -p ~/.builds && cd ~/.builds
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -sirc --needed --noconfirm

yay -S --needed --noconfirm ${pacotes[@]}


echo "Concluído!"

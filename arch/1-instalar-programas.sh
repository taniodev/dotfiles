#!/usr/bin/env bash
set -e

# Pacotes a instalar
pacotes=(
    git docker docker-compose emacs espeak-ng openssh orca vlc wget xdg-user-dirs
    chromium firefox firefox-i18n-pt-br thunderbird thunderbird-i18n-pt-br w3m
    pacman-contrib translate-shell
)

pacman -S --needed --noconfirm ${pacotes[@]}

# Desativar serviços
systemctl disable sshd

echo "Concluído!"

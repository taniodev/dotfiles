#!/usr/bin/env bash
set -e

echo "Configurando o layout do teclado..."
localectl set-x11-keymap br abnt2
sleep 1

echo "Configurando o ASDF..."
if [ -d $HOME/.asdf ]; then
    echo "Pulando configuração: diretório ASDF encontrado em $HOME/.asdf"
else
    echo "Clonando repositório..."
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1
fi
sleep 1

echo "Fim do script!"
sleep 1
exit
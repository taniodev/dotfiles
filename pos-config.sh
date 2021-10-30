#!/usr/bin/env bash
set -e

if [ `id -u` -eq 0 ]; then
    echo "Não execute como super usuário"
    exit 1
fi

# O Git precisa estar presente para realizar algumas configurações
if ! which git &> /dev/null; then
    echo "Parando configuração: O executável Git não foi localizado."
    exit 127
fi


# Configura o layout de teclado no xorg
localectl set-x11-keymap br abnt2


# Configurações do Git
echo "Configurando o Git..."
git config --global user.name "Tânio Scherer"
git config --global user.email "tanioms3@gmail.com"
git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor nano
git config --global pull.rebase true   # rebase
git config --global init.defaultBranch main

# Configura o ASDF
if [ -d $HOME/.asdf ]; then
    echo "Pulando configuração: Diretório ASDF encontrado em $HOME/.asdf"
else
    echo "Configurando o ASDF..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
fi

echo "Concluído!"

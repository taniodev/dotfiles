#!/usr/bin/env bash
set -e

if [ `id -u` -eq 0 ]; then
    echo "Não execute como super usuário"
    exit 1
fi


# Configura o layout de teclado no xorg
localectl set-x11-keymap br abnt2


# Configurações do Git
if which git &> /dev/null; then
    echo "Configurando o Git..."
    git config --global user.name "Tânio Scherer"
    git config --global user.email "tanioms3@gmail.com"
    touch ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.editor nano
    git config --global pull.rebase true   # rebase
else
    echo "Pulando configuração: O executável Git não foi localizado."
fi


echo "Concluído!"

#!/usr/bin/env bash
set -e

echo "Configurando o layout do teclado..."
localectl set-x11-keymap br abnt2
sleep 1

# Lista de diretórios que serão criados automaticamente.
diretorios=(
    $HOME/.builds
    $HOME/.local/bin
)

echo "Criando diretórios..."
for diretorio in ${diretorios[@]}; do
    if [ -d $diretorio ]; then
        echo "Pulando: Diretório encontrado em $diretorio"
    else
        echo "Criando diretório $diretorio"
        mkdir -p $diretorio
    fi
    sleep 1
done
sleep 1

echo "Configurando o yay..."
if [ -d $HOME/.builds/yay ]; then
    echo "Pulando configuração: diretório yay encontrado em $HOME/.builds/yay"
else
    echo "Baixando o yay..."
    git clone https://aur.archlinux.org/yay.git ~/.builds/yay
fi
sleep 1

echo "Configurando o ASDF..."
if [ -d $HOME/.asdf ]; then
    echo "Pulando configuração: diretório ASDF encontrado em $HOME/.asdf"
else
    echo "Clonando repositório..."
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1
fi
sleep 1

echo "Configurando o Poetry..."
if type poetry &> /dev/null; then
    echo "Pulando configuração: poetry encontrado no PATH"
else
    echo "Obtendo o script de instalação..."
    curl -sSL https://install.python-poetry.org | python3 -
fi
sleep 1

echo "Configurando o GRUB..."
sudo sed -i 's/#GRUB_INIT_TUNE/GRUB_INIT_TUNE/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sleep 1

echo "Systemd: desativando a suspensão ao fechar a tampa do notebook..."
sudo sed -i "s/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/" /etc/systemd/logind.conf
sleep 1

echo "Habilitando serviços..."
sudo systemctl enable fstrim.timer
sleep 1

echo "Configurando o uso de memória..."
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-sysctl.conf
echo "vm.vfs_cache_pressure=50" | sudo tee --append /etc/sysctl.d/99-sysctl.conf
sleep 1

if [ -f /etc/lightdm/lightdm-gtk-greeter.conf ]; then
    echo "Ativando o Orca no Lightdm..."
    sudo sed -i "s/#reader=/reader=orca/" /etc/lightdm/lightdm-gtk-greeter.conf
    sudo sed -i "/reader=orca/a a11y-states=+reader" /etc/lightdm/lightdm-gtk-greeter.conf
    sleep 1
fi

echo "Fim do script!"
sleep 1
exit

#!/usr/bin/env bash
set -e

hostname="arch"
linguagem="pt_BR.UTF-8"

# Pacotes que serão instalados no sistema base
pacotes=(
    base base-devel linux-zen linux-firmware
    grub networkmanager ntfs-3g os-prober
    alsa-utils pulseaudio pulseaudio-alsa espeakup espeak-ng nano
)


# Começa a instalação da base do sistema e dos pacotes
pacstrap /mnt ${pacotes[@]}

# Configura um arquivo swap
dd if=/dev/zero of=/mnt/swapfile bs=1M count=2048
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

# Configura o fstab
genfstab -L /mnt >> /mnt/etc/fstab


# Configurações no sistema que foi instalado
arch-chroot /mnt << EOF
    # Idioma
    sed -i "s/#$linguagem/$linguagem/" /etc/locale.gen
    locale-gen
    echo "LANG=$linguagem" > /etc/locale.conf

    # Fuso horário
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

    # Configura o teclado
    echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

    # Define o hostname
    echo $hostname > /etc/hostname

    # Configura o arquivo hosts
    echo "127.0.0.1 localhost" >> /etc/hosts
    echo "::1 localhost" >> /etc/hosts
    echo "127.0.1.1 $hostname" >> /etc/hosts

    # Configura o Grub
    sed -i 's/#GRUB_INIT_TUNE/GRUB_INIT_TUNE/' /etc/default/grub
    grub-install --target=i386-pc --recheck /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg

    # Configura o sudo
    groupadd sudo
    sed -i "s/# %sudo/%sudo/" /etc/sudoers

    # Configura as variáveis de ambiente para ativar a acessibilidade dos programas
    echo "ACCESSIBILITY_ENABLED=1" >> /etc/environment
    echo "QT_ACCESSIBILITY=1" >> /etc/environment
    echo "QT_LINUX_ACCESSIBILITY_ALWAIS_ON=1" >> /etc/environment

    # Habilita serviços
    systemctl enable espeakup
    systemctl enable NetworkManager

    # Configura o uso de memória
    echo "vm.swappiness=10" >> /etc/sysctl.d/99-sysctl.conf
    echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.d/99-sysctl.conf

EOF

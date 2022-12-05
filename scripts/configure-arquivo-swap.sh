#!/usr/bin/env bash
set -e

SWAPFILE="/swapfile"

if [ -f "$SWAPFILE" ]; then
    echo "Pulando etapa: arquivo swap encontrado em $SWAPFILE"
else
    echo "Criando arquivo swap em $SWAPFILE"
    sudo dd if=/dev/zero of=$SWAPFILE bs=1G count=4
    sudo chmod 600 $SWAPFILE
    sudo mkswap $SWAPFILE
    sudo swapon $SWAPFILE
fi
sleep 1

if grep "^$SWAPFILE " /etc/fstab &> /dev/null; then
    echo "Pulando etapa: a entrada para o arquivo swap foi detectada em /etc/fstab"
else
    echo "Adicionando entrada em /etc/fstab"
    echo "$SWAPFILE none swap defaults 0 0" | sudo tee -a /etc/fstab
fi
sleep 1

echo "Fim do script."
sleep 1
exit

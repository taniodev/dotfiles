#!/usr/bin/env bash

echo "Verificando variáveis de acessibilidade no ambiente..."

# test -z testa se a variável não está definida
if [ -z $QT_LINUX_ACCESSIBILITY_ALWAYS_ON ]; then
    echo "Ativando QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1"
    echo "export QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1" | sudo tee --append /etc/profile.d/a11y.sh
else
    echo "QT_LINUX_ACCESSIBILITY_ALWAYS_ON já está ativada!"
fi
sleep 1

if [ -z $QT_ACCESSIBILITY ]; then
    echo "Ativando QT_ACCESSIBILITY=1"
    echo "export QT_ACCESSIBILITY=1" | sudo tee --append /etc/profile.d/a11y.sh
else
    echo "QT_ACCESSIBILITY já está ativada!"
fi
sleep 1

if [ -z $ACCESSIBILITY_ENABLED ]; then
    echo "Ativando ACCESSIBILITY_ENABLED=1"
    echo "export ACCESSIBILITY_ENABLED=1" | sudo tee --append /etc/profile.d/a11y.sh
else
    echo "ACCESSIBILITY_ENABLED já está ativada!"
fi
sleep 1

echo "Finalizando programa. Lembre-se de sair e logar novamente!"
sleep 1
exit

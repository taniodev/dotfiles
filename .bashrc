#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Configuração do asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Variáveis de ambiente do pipenv
export PIPENV_VENV_IN_PROJECT=1

# Alias para usar o manage.py do Django
alias mng='python $VIRTUAL_ENV/../manage.py'

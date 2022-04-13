#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

alias ls='ls --color=auto'

# String personalizada para o prompt PS1
PS1='[\u@\h \W]\$ '

if [ -f /usr/share/git/git-prompt.sh ]; then
  . /usr/share/git/git-prompt.sh
  PS1='[\u@\h \W $(__git_ps1 "(%s)")]\$ '
fi

# Configuração do asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Variáveis de ambiente do pipenv
export PIPENV_VENV_IN_PROJECT=1

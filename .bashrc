#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Only set SWAYSOCK if empty
if [ -z "$SWAYSOCK" ] && [ -e /run/user/1000/sway-ipc.0 ]; then
    export SWAYSOCK=/run/user/1000/sway-ipc.0
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(pyenv virtualenv-init -)"

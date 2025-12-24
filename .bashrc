#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Only set SWAYSOCK if empty
if [ -z "$SWAYSOCK" ] && [ -e /run/user/1000/sway-ipc.0 ]; then
    export SWAYSOCK=/run/user/1000/sway-ipc.0
fi

eval "$(starship init bash)"
# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(pyenv virtualenv-init -)"

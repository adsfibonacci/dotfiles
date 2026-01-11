# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

umvpn() {
    /home/alex/.umvpn/run.sh "$@"
}
_umvpn_completion() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "all split disconnect" -- "$cur") )
}
complete -F _umvpn_completion umvpn

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Show latest Arch Linux news before upgrading
arch_news_check() {
    echo "🔔 Latest Arch Linux news:"
    curl -s https://archlinux.org/news/ \
      | grep -Eo 'href="/news/[^"]+"' \
      | cut -d'"' -f2 \
      | head -n 5 \
      | sed 's|^|https://archlinux.org|'

    echo
    read -p "Do you want to continue with the system upgrade? [y/N] " answer
    if [[ "$answer" =~ ^[yY]$ ]]; then
        sudo pacman -Syu
    else
        echo "⏹️ Upgrade cancelled."
    fi
}

alias pacnews="arch_news_check"

export GUROBI_HOME="/opt/gurobi1203/linux64"
export GRB_LICENSE_FILE="/home/alex/.gurobi/gurobi.lic"
export LD_LIBRARY_PATH="${GUROBI_HOME}/lib:${LD_LIBRARY_PATH}"
export PATH="/opt/cuda/bin:${GUROBI_HOME}/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk

unset PROMPT_COMMAND
eval "$(starship init bash)"


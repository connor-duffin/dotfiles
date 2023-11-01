set -o vi
alias ls='ls --color=auto'
alias my_scrot='scrot ~/Pictures/%Y-%m-%d-%H%M%s.png'
alias R='R --quiet --no-save'
alias wttr='curl wttr.in'
export VISUAL='vim'

PS1=" \[\033[01;34m\]\w\[\033[00m\] >> "

HISTSIZE=-1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/connor/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/connor/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/connor/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/connor/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# set the config alias for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

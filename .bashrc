set -o vi
alias ls='ls --color=auto'
alias R='R --quiet --no-save'
export VISUAL='vim'

PS1=" [\h] \[\033[01;34m\]\w\[\033[00m\] >> "

HISTSIZE=-1

# set the config alias for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

. "$HOME/.local/bin/env"

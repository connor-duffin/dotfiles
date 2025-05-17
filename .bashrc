set -o vi
alias ls='ls --color=auto'
alias R='R --quiet --no-save'
export VISUAL='vim'

export "PATH=$HOME/bin:$PATH"
PS1=" [\h] \[\033[01;34m\]\w\[\033[00m\] >> "

HISTSIZE=-1

# mac-specific settings
system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
  . "$HOME/.local/bin/env"
fi

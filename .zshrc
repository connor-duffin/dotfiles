# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="theunraveler"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colorize colored-man-pages git pass ubuntu)

source $ZSH/oh-my-zsh.sh

# connor added stuff
alias R="R --quiet --no-save"
alias tmux="tmux -2"
alias gppl="g++ -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -Werrors -std=c++20"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
export PATH=$PATH:/snap/bin

HISTSIZE=100000000
SAVEHIST=$HISTSIZE

export VISUAL=vi
export EDITOR=vi

export WORKON_HOME="/home/connor/.miniconda3/envs"
export BORG_PASSPHRASE=""

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^?" backward-delete-char

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/connor/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# misc settings
export PATH="/home/connor/.scripts/:$PATH"
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export WINIT_X11_SCALE_FACTOR=1


# r libraries
alias R=/opt/R/4.2.1/bin/R
alias Rscript=/opt/R/4.2.1/bin/Rscript

# set the config alias for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
export PATH="/home/connor/.scripts:$PATH"

# for accessing NCBI API
export ENTREZ_KEY=fd33508667f5fe584678103dbffcdafbe008

# fnm
FNM_PATH="/home/connor/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

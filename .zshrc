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

HISTSIZE=100000000
SAVEHIST=$HISTSIZE

export VISUAL=vi
export EDITOR=vi
export BORG_PASSPHRASE=""

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^?" backward-delete-char

# misc settings
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export WINIT_X11_SCALE_FACTOR=1

# for accessing NCBI API
export ENTREZ_KEY=fd33508667f5fe584678103dbffcdafbe008

# for R
. "$HOME/.local/bin/env"

# set up the $PATH for homebrew
export PATH=$HOME/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"

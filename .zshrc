alias R='R --quiet --no-save'
alias tmux='tmux -2'

export VISUAL=vi
export EDITOR=vi

# update the path
path+=('/Users/connor/.scripts')
export PATH

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^?" backward-delete-char

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/connor/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/connor/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/connor/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/connor/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

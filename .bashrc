set -o vi
alias ls='ls --color=auto'
alias my_scrot='scrot ~/Pictures/%Y-%m-%d-%H%M%s.png'
alias R='R --quiet --no-save'
alias wttr='curl wttr.in'
export VISUAL='vim'

PS1=" \[\033[01;34m\]\w\[\033[00m\] >> "

HISTSIZE=-1

# conda configurations across multiple machines
if [ $HOSTNAME == "csic40" ]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.miniconda3/lib"

    # make sure single threads are used ONLY
    export OPENBLAS_NUM_THREADS=1
    export OMP_NUM_THREADS=1

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/cpd32@ad.eng.cam.ac.uk/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/cpd32@ad.eng.cam.ac.uk/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/cpd32@ad.eng.cam.ac.uk/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/cpd32@ad.eng.cam.ac.uk/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    # cuda setup
    export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda-11.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
else
    if [ $HOSTNAME == "Connors-MacBook-Air.local"]; then
        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/Users/connor/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/Users/connor/miniconda3/etc/profile.d/conda.sh" ]; then
                . "/Users/connor/miniconda3/etc/profile.d/conda.sh"
            else
                export PATH="/Users/connor/miniconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<
    fi
fi

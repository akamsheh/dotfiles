# .bashrc

###############################################################################
# Boiler plate '.bashrc' from fresh Fedora35 install ##########################
###############################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

unset rc

################################################################################
# END ##########################################################################
################################################################################


################################################################################
# Start of custom ##############################################################
################################################################################

# Alias to manage dotfiles and track easily using git
# Read more here: https://news.ycombinator.com/item?id=11071754

alias dotf='/usr/bin/git --git-dir=/home/adam/.dotfiles/ --work-tree=/home/adam'

if [[ -d "$HOME/.pyenv" && ! -L "$HOME/.pyenv"  ]]; then
    eval "$(pyenv init -)"
fi

# Set nvm defaults if present
if [[ -d "$HOME/.nvm" && ! -L "$HOME/.nvm"  ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Aliases
alias la="ls -lah"
alias ll="ls -lh"
alias cl="clear"

# Read in credentials which are just a file with
# environment vars set. Don't version control this!
if [ -f ~/.credentialsrc ]; then
    . ~/.credentialsrc
fi
. "$HOME/.cargo/env"

# .bash_profile

###########################################################################
# Defaults from Fedora35 installation #####################################
###########################################################################

# Set path for pyenv if it exists
if [[ -d "$HOME/.pyenv" && ! -L "$HOME/.pyenv"  ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

###########################################################################
# END #####################################################################
###########################################################################


###########################################################################
# User specific environment and startup programs
###########################################################################

# Make nvim default
export EDITOR=/usr/bin/nvim

export AWS_DEFAULT_REGION=us-east-1

# Init pyenv if it exists
if [[ -d "$HOME/.pyenv" && ! -L "$HOME/.pyenv"  ]]; then
    eval "$(pyenv init --path)"
fi

# For Rust package manager cargo
. "$HOME/.cargo/env"

# Load .bashrc last
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi



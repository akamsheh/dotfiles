# Set path for pyenv if it exists
if [[ -d "$HOME/.pyenv" && ! -L "$HOME/.pyenv"  ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

# Make nvim default
export EDITOR=/usr/bin/nvim

# AWS
export AWS_DEFAULT_REGION=us-east-1

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Add snap store to path
if [[ -d /snap/bin/ ]]
then
    PATH="/snap/bin:$PATH"
fi

# Set neovim path
PATH="$HOME/bin/nvim/bin:$PATH"
export PATH

# Set nvm defaults if present
if [[ -d "$HOME/.nvm" && ! -L "$HOME/.nvm"  ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Disable keyring. Not installed on Arch OS
export MYSQL_WORKBENCH_DISABLE_KEYRING=1


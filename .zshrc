# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/adam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Init pyenv if it exists
if [[ -d "$HOME/.pyenv" && ! -L "$HOME/.pyenv"  ]]; then
    eval "$(pyenv init --path)"
fi

# Aliases
alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias la="ls -lah"
alias ll="ls -lh"
alias cl="clear"

# Keybinds
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/$USER/.zshrc'

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

alias gitst="git status"
alias gitaa="git add --all"
alias gitl="lazygit"

alias vi=nvim
alias c=clear
alias tf=terraform

# Add custom prompt
source ~/.zsh_prompt

# Keybinds
bindkey "^[[3~" delete-char


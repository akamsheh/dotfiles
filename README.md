# dotfiles

Using setup method discribed here: https://news.ycombinator.com/item?id=11070797

## Clone to fresh $HOME directory

```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
git clone --separate-git-dir=$MY_CONFIG_GIT_DIR /path/to/repo ~
```

## Clone to existing $HOME directory

```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
git clone --separate-git-dir=$MY_CONFIG_GIT_DIR /path/to/repo $HOME/myconf-tmp # Clone contents to tmp directory, initially
cp -rn $HOME/myconf-tmp ~ # Copy recursively but do not overwrite existing files
rm -r ~/myconf-tmp/
```

Alias for git dotfiles
```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
alias config='/usr/bin/git --git-dir=$MY_CONFIG_GIT_DIR --work-tree=$HOME'
```

Hide untracked files
```sh
config config status.showUntrackedFiles no
```

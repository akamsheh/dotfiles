# dotfiles

Using setup method discribed here: https://news.ycombinator.com/item?id=11070797

```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
git init --bare $MY_CONFIG_GIT_DIR
alias config='/usr/bin/git --git-dir=$MY_CONFIG_GIT_DIR --work-tree=$HOME'
config config status.showUntrackedFiles no
```

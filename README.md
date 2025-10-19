# dotfiles

Using setup method discribed here: https://news.ycombinator.com/item?id=11070797

## Required Tools and Dependencies

Before using these dotfiles, install the following tools:

### Core Requirements
- **Git** - Version control system (required for dotfile management)
- **Zsh** - Z shell (primary shell)

### Applications Configured
- **Alacritty** - Terminal emulator
- **i3** - Tiling window manager
- **i3status** - Status bar for i3
- **Lazygit** - Terminal UI for Git
- **Neovim** - Text editor/IDE

## Clone to fresh $HOME directory

```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
git clone --separate-git-dir=$MY_CONFIG_GIT_DIR /path/to/repo ~
```

## Clone to existing $HOME directory

```sh
export MY_CONFIG_GIT_DIR=$HOME/.myconf
git clone --separate-git-dir=$MY_CONFIG_GIT_DIR /path/to/repo $HOME/myconf-tmp # Clone contents to tmp directory, initially
cp -rn $HOME/myconf-tmp/ ~ # Copy recursively but do not overwrite existing files
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

## Fedora 42 KDE Plasma

### Force X11 Session
SDDM ignores `DisplayServer=x11` configuration and defaults to Wayland. To force X11:

```sh
sudo mv /usr/share/wayland-sessions/plasma.desktop /usr/share/wayland-sessions/plasma.desktop.bak
sudo systemctl restart sddm
```

Verify X11 is active:
```sh
echo $XDG_SESSION_TYPE  # Should output: x11
```

To restore Wayland later:
```sh
sudo mv /usr/share/wayland-sessions/plasma.desktop.bak /usr/share/wayland-sessions/plasma.desktop
```

### NVIDIA Driver Setup
After switching to X11, install proprietary NVIDIA drivers for RTX 3070:

```sh
# Enable RPM Fusion repositories
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install NVIDIA drivers
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda

# Reboot required
sudo reboot
```

Verify installation:
```sh
nvidia-smi  # Should show GPU status and driver version
glxinfo | grep -i nvidia  # Should show proprietary driver instead of Mesa NVK
```

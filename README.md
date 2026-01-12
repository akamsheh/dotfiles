# dotfiles

Using setup method discribed here: https://news.ycombinator.com/item?id=11070797

## Required Tools and Dependencies

Before using these dotfiles, install the following tools:

### Pre Reqs
- **Git** - Version control system (required for dotfile management)
- **Zsh** - Z shell (primary shell)
- **ripgrep** - For Neovim plugin (telescope)

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

## Zsh/Terminal Keyboard Navigation

Common keyboard shortcuts for efficient terminal navigation.

### Line Navigation
- `Ctrl-a` - Move to beginning of line
- `Ctrl-e` - Move to end of line
- `Alt-f` (or `Esc-f`) - Move forward one word
- `Alt-b` (or `Esc-b`) - Move backward one word

### Editing
- `Ctrl-k` - Delete from cursor to end of line
- `Ctrl-u` - Delete from cursor to beginning of line
- `Ctrl-w` - Delete word before cursor
- `Alt-d` (or `Esc-d`) - Delete word after cursor
- `Ctrl-y` - Paste (yank) last deleted text
- `Ctrl-_` - Undo last edit

### History Navigation
- `Ctrl-r` - Reverse search through history (type to search, Enter to execute)
- `Ctrl-p` - Previous command in history (same as Up arrow)
- `Ctrl-n` - Next command in history (same as Down arrow)
- `!!` - Repeat last command
- `!$` - Last argument of previous command
- `!*` - All arguments of previous command

### Process Control
- `Ctrl-c` - Kill current process
- `Ctrl-z` - Suspend current process (use `fg` to resume)
- `Ctrl-d` - Exit shell or send EOF
- `Ctrl-l` - Clear screen (same as `clear` command)

### iTerm2-Specific (macOS)
- `Cmd-t` - New tab
- `Cmd-d` - Split pane vertically
- `Cmd-Shift-d` - Split pane horizontally
- `Cmd-[` / `Cmd-]` - Navigate between panes
- `Cmd-Shift-[` / `Cmd-Shift-]` - Navigate between tabs
- `Cmd-Option-Arrow` - Navigate between split panes
- `Cmd-k` - Clear buffer

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

## Neovim Configuration

Modern Lua-based configuration located in `~/.config/nvim/`

### Features

- **Plugin Manager**: Packer.nvim (auto-installs on first run)
- **LSP Support**: Mason for language server management with auto-installation
- **Autocompletion**: nvim-cmp with LSP, buffer, path, and snippet sources
- **Syntax Highlighting**: Treesitter with auto-install parsers
- **Fuzzy Finding**: Telescope with fzf-native for fast searching
- **File Explorer**: nvim-tree
- **Auto-formatting**: conform.nvim with format-on-save
- **Color Scheme**: Gruvbox dark

### Language Support

**LSP Servers** (auto-installed via Mason):
- Lua (lua_ls)
- Python (pyright)
- TypeScript/JavaScript (ts_ls)
- Rust (rust_analyzer)
- Go (gopls)
- Java (jdtls)
- C/C++ (clangd)
- HTML, CSS, Tailwind (html, cssls, tailwindcss)
- YAML, JSON, XML, TOML (yamlls, jsonls, lemminx, taplo)

**Formatters** (format-on-save enabled):
- Lua: stylua
- Python: black
- JavaScript/TypeScript: prettier
- Rust: rustfmt
- Go: goimports + gofmt
- Java: google-java-format
- C/C++: clang-format
- HTML/CSS: prettier
- XML: xmlformat
- TOML: taplo

### Key Bindings

Leader key: `,`

**File Navigation:**
- `,e` - Toggle file tree
- `,ff` - Find files
- `,fg` - Live grep (search in files)
- `,fb` - Find buffers
- `,fh` - Help tags

**Code Navigation (Telescope LSP):**
- `,fs` - Document symbols (outline current file)
- `,fS` - Workspace symbols (search across project)
- `,fr` - Find references
- `,fd` - Find definitions
- `,fi` - Find implementations

**LSP Actions:**
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Find references (plain list)
- `K` - Hover documentation
- `Ctrl-k` - Signature help
- `<space>rn` - Rename symbol
- `<space>ca` - Code actions
- `<space>D` - Type definition

**Autocompletion:**
- `Ctrl-Space` - Trigger completion
- `Enter` - Confirm selection
- `Ctrl-e` - Close completion menu
- `Ctrl-b` / `Ctrl-f` - Scroll docs

### First-Time Setup

1. Install Neovim (v0.9+)
2. Install ripgrep: `sudo dnf install ripgrep`
3. Open Neovim: `nvim`
4. Packer will auto-install and sync plugins
5. Restart Neovim after initial plugin installation
6. LSP servers and formatters will auto-install on first use

### Python Project Setup

For best autocompletion with Python frameworks:

```sh
# Install packages in your project
pip install boto3 django flask

# Install type stubs for better completions
pip install boto3-stubs django-stubs types-requests
```

For virtual environments, activate before launching Neovim or create `pyrightconfig.json`:
```json
{
  "venvPath": ".",
  "venv": ".venv"
}
```

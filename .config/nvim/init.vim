" Notes
" Installing Plugins:
"   To install a plugin, simply do a git clone
"   to the ~/.local/share/nvim/site/plugin/<your plugin>

lua require('plugins')

" Sensible defualts
set number     " Show line number
set ignorecase " Ignore case when all lower case
set smartcase  " Case sensitive with any upper case

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab

" Set FZF path (https://github.com/junegunn/fzf)
set rtp+=/usr/bin/fzf

" Mappings
xnoremap <leader>t= :'<,'> Tabularize /=<CR>

" Cursor
set cursorline


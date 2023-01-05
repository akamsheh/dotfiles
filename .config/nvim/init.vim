" -------------------------------------------------------------------------------------
" Sensible Defaults -------------------------------------------------------------------
" -------------------------------------------------------------------------------------
set number     " Show line number
set ignorecase " Ignore case when all lower case
set smartcase  " Case sensitive with any upper case

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab

" Cursor
set cursorline
" -------------------------------------------------------------------------------------

" -------------------------------------------------------------------------------------
" Vim Plug ----------------------------------------------------------------------------
" -------------------------------------------------------------------------------------
call plug#begin()
  " Telescope Dependencies
  Plug 'nvim-lua/plenary.nvim' 
  Plug 'sharkdp/fd'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'} 

  " LSP Manaager
  Plug 'williamboman/mason.nvim'

  " LSP Config
  Plug 'neovim/nvim-lspconfig'

  " Colorscheme
  Plug 'EdenEast/nightfox.nvim', { 'branch': 'main' }
  
  " NerdTree
  Plug 'preservim/nerdtree'
call plug#end()
" -------------------------------------------------------------------------------------

lua << EOF

  require("mason").setup()
  require('telescope').load_extension('fzf') -- Load fzf into telescope
  -- LSP Config
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.yamlls.setup{}
  
  -- Colorscheme
  -- vim.cmd[[colorscheme tokyonight]]
  vim.cmd[[colorscheme nightfox]]
  
  -- -------------------------------------------------------------------------------------
  -- Keymapping ---------------------------------------------------------------------
  -- -------------------------------------------------------------------------------------
  local builtin = require('telescope.builtin')
  -- Leader
  vim.g.mapleader = ","

  -- NERDTree
  vim.keymap.set('n', '<C-P>', ':NERDTreeToggle<CR>', {})

  -- Telescope
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  -- LSP
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.hoverProvider then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
      end
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
     
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    end,
  })
  -----------------------------------------------------------------------------------

EOF


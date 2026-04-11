local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")

-- Autosave when leaving buffer or losing focus
opt.autowriteall = true
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	command = "silent! wall",
})

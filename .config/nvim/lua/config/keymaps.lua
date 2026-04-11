-- ~/.config/nvim/lua/keymaps.lua
local keymap = vim.keymap

vim.g.mapleader = ","

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Telescope keymaps
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Telescope LSP keymaps for code navigation
keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementations" })

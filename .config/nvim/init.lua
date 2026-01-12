-- ~/.config/nvim/init.lua
require("plugins") -- Plugin management
require("settings") -- Editor settings
require("keymaps") -- Key mappings
require("lsp") -- LSP configuration
require("telescope-config") -- Telescope fuzzy finder

-- Load treesitter config only if plugin is installed
local has_treesitter, _ = pcall(require, "nvim-treesitter")
if has_treesitter then
	require("treesitter-config")
end

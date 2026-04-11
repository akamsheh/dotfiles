return {
	{ "neovim/nvim-lspconfig" },

	{
		"williamboman/mason.nvim",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"basedpyright",
					"ruff",
					"ts_ls",
					"rust_analyzer",
					"gopls",
					"jdtls",
					"clangd",
					"html",
					"cssls",
					"tailwindcss",
					"yamlls",
					"jsonls",
					"lemminx",
					"taplo",
				},
				automatic_installation = true,
			})

			-- Set capabilities from blink.cmp for all LSP servers
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- LSP keymaps and ruff config on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- Disable ruff hover (basedpyright handles it) and formatting (conform handles it)
					if client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
						client.server_capabilities.documentFormattingProvider = false
					end

					local opts = { noremap = true, silent = true, buffer = args.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

				end,
			})

			-- Diagnostic keymaps (global, not LSP-dependent)
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

			-- Enable LSP servers
			local servers = {
				"lua_ls",
				"basedpyright",
				"ruff",
				"ts_ls",
				"rust_analyzer",
				"gopls",
				"jdtls",
				"clangd",
				"html",
				"cssls",
				"tailwindcss",
				"yamlls",
				"jsonls",
				"lemminx",
				"taplo",
			}
			for _, lsp in ipairs(servers) do
				vim.lsp.enable(lsp)
			end
		end,
	},
}

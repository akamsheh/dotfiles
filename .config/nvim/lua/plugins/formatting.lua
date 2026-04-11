return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					rust = { "rustfmt" },
					go = { "goimports", "gofmt" },
					java = { "google-java-format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					html = { "prettier" },
					css = { "prettier" },
					xml = { "xmlformat" },
					toml = { "taplo" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}

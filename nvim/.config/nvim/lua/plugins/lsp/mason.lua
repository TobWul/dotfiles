return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"prettierd", -- prettier formatter
					"stylua", -- lua formatter
					"eslint_d", -- js linter
					"markdownlint", -- markdown linter
					"typos-lsp", -- spell checker
					"darker", -- python formatter
				},
			})
		end,
	},
}

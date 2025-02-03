return {
	{
		"nvim-treesitter/nvim-tree-docs",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "javascript", "typescript", "markdown", "markdown_inline", "css", "scss" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				tree_docs = {
					enabled = true,
					jsdoc = {
						slots = {
							class = { author = true },
						},
					},
				},
			})

			local wk = require("which-key")
			wk.add({
				{ "<leader>cd", "<cmd>TreeDocsGenerate<CR>", desc = "Generate docs" },
			})
		end,
	},
}

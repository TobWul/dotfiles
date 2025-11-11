return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- lazy-load on real filetypes (ts/tsx + js/jsx)
		ft = { "typescript", "typescriptreact" },
		opts = {},
	},
}

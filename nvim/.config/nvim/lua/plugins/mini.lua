return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.diff").setup()
		end,
	},
}

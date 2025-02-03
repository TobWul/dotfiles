return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	{
		-- "slugbyte/lackluster.nvim",
		-- 	"catppuccin/nvim",
		"aliqyan-21/darkvoid.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("darkvoid")
		end,
		config = function()
			require("darkvoid").setup({
				transparent = true,
				glow = true,
			})
		end,
	},
}

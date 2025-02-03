return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- {
	-- 	"aliqyan-21/darkvoid.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("darkvoid")
	-- 	end,
	-- 	config = function()
	-- 		require("darkvoid").setup({
	-- 			transparent = true,
	-- 			glow = true,
	-- 			colors = {
	-- 				visual = "#1D4031",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}

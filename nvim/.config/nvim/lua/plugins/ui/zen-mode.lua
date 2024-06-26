return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 75,
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		vim.keymap.set("n", "<leader>z", "<Cmd>ZenMode<CR>")
	end,
}

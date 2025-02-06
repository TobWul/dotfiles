return {
	{
		"VVoruganti/today.nvim",
		config = function()
			require("today").setup({
				local_root = "~/Git/daily-notes", -- Default: ~/.today
			})
			vim.keymap.set(
				"n",
				"<leader>t",
				":Today<CR>",
				{ noremap = true, silent = true, desc = "Open today's note" }
			)
		end,
	},
}

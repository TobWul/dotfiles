return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("lazygit")
		local wk = require("which-key")
		wk.register({
			["<leader>g"] = { name = "+git" },
		})
		vim.keymap.set("n", "<leader>gg", "<cmd>:LazyGit<CR>", { desc = "Open LazyGit" })
	end,
}

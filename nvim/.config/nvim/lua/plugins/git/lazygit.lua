return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("lazygit")
		local wk = require("which-key")
		wk.add({
			{ "<leader>g", group = "git" },
			{ "<leader>gg", "<cmd>:LazyGit<CR>", desc = "Open LazyGit" },
		})
	end,
}

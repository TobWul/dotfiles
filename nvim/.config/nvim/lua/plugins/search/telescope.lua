return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "find" },
				{ "<leader>fg", builtin.live_grep, desc = "Grep search" },
				{ "<leader>ff", builtin.find_files, desc = "Open telescope" },
				{ "<leader><leader>", builtin.buffers, desc = "Search buffer", hidden = true },
				{ "<leader>fn", "<cmd>:noh<cr>", desc = "Clear search" },
				{
					"<leader>fc",
					"y/\\V<C-R>=escape(@\",'/\\')<CR><CR>",
					desc = "Search for visually selected text",
					mode = "v",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				defaults = {
					path_display = { "smart" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
		-- To get ui-select loaded and working with telescope, you need to call
	},
}

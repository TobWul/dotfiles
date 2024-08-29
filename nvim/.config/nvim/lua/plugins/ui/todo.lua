return {
	-- lazy.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			local todo = require("todo-comments")
			local wk = require("which-key")

			todo.setup()

			wk.add({
				{ "<leader>t", group = "todo", icon = "󰙮" },
				{
					"<leader>ts",
					"<cmd>TodoTelescope<cr>",
					desc = "Search for todos",
				},
				{ "<leader>tl", "<cmd>TodoQuickFix<cr>", desc = "List all todos" },
				{
					"<leader>tn",
					function()
						todo.jump_next()
					end,
					desc = "Jump to next todo",
				},
				{
					"<leader>tp",
					function()
						todo.jump_prev()
					end,
					desc = "Jump to prev todo",
				},
			})
		end,
	},
}

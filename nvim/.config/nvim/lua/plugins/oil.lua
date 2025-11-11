return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = {
			{ "nvim-mini/mini.icons", opts = {} },
		},
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == ".git"
					end,
				},
				float = {
					border = "rounded",
					preview_split = "auto",
					padding = 8,
				},
				keymaps = {
					["<CR>"] = "actions.select", -- open/confirm selection (default)
					["<BS>"] = "actions.parent", -- go to parent with Backspace
					["<C-p>"] = "actions.preview", -- manual toggle if you ever want it
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = { "actions.select", opts = { horizontal = true } },
					["q"] = "actions.close",
				},
			})

			vim.keymap.set("n", "<leader>E", function()
				require("oil").toggle_float()
			end, { desc = "Oil: toggle file explorer" })
		end,
	},
}

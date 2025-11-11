return {
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
		config = function()
			local wk = require("which-key")
			local quicker = require("quicker")
			wk.add({
				{
					"<leader>q",
					function()
						quicker.toggle()
					end,
					desc = "Open [Q]uickfix",
				},
				{
					"<leader>l",
					function()
						quicker.toggle({ loclist = true })
					end,
					desc = "Open [L]oclist",
				},
			})
			quicker.setup({
				keys = {
					{
						">",
						function()
							require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
						end,
						desc = "Expand quickfix context",
					},
					{
						"<",
						function()
							require("quicker").collapse()
						end,
						desc = "Collapse quickfix context",
					},
				},
			})
		end,
	},
}

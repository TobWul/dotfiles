return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>f"] = { name = "+file" },
		})
		wk.register({
			["<leader>d"] = {
				name = "+spell-check",
				a = { "zg", "Add word under the cursor as a good word" },
				b = { "zw", "Mark word as bad word" },
				s = { "z=", "Suggestions" },
			},
		})
	end,
}

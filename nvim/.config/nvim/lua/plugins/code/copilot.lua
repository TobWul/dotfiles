return {

	{
		"github/copilot.vim",
		config = function()
			local wk = require("which-key")
			wk.register({
				["<leader>cc"] = {
					name = "+copilot",
					e = { "<cmd>Copilot enable<cr>", "Enable GitHub Copilot" },
					d = { "<cmd>Copilot disable<cr>", "Disable GitHub Copilot" },
					p = { "<cmd>Copilot panel<cr>", "Open GitHub Copilot panel" },
				},
			})
		end,
	},
}

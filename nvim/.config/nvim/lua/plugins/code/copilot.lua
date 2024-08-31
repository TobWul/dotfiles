return {
	{
		"github/copilot.vim",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>cc", group = "copilot" },
				{ "<leader>cce", "<cmd>Copilot enable<cr>", desc = "Enable GitHub Copilot" },
				{ "<leader>ccd", "<cmd>Copilot disable<cr>", desc = "Disable GitHub Copilot" },
				{ "<leader>ccp", "<cmd>Copilot panel<cr>", desc = "Open GitHub Copilot panel" },
			})
      vim.cmd(':Copilot disable')
		end,
	},
}

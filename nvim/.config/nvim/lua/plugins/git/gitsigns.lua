return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
		})
		local wk = require("which-key")
		wk.add({
			{ "<leader>gu", group = "git ui" },
			{ "<leader>gub", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle current line blame" },
			{ "<leader>gup", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },
		})
	end,
}

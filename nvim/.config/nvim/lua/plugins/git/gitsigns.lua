return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
		})
		local wk = require("which-key")
		wk.register({
			["<leader>gu"] = {
				name = "+git ui",
				b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle current line blame" },
				p = { "<cmd>Gitsigns preview_hunk_inline<cr>", "Preview hunk inline" },
			},
		})
	end,
}

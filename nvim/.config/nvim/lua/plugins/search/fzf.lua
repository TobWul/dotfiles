return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			local fzf = require("fzf-lua")
			local wk = require("which-key")
			fzf.setup({ "telescope" })

			wk.add({
				{ "<leader>f", group = "find" },
				{ "<leader>fg", fzf.live_grep, desc = "Grep search" },
				{
					"<leader>ff",
					function()
						fzf.files()
					end,
					desc = "Open telescope",
				},
				{ "<leader><leader>", fzf.buffers, desc = "Search buffer", hidden = true },
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
}

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
				{ "<leader>fg", fzf.live_grep_visual, desc = "Grep search", mode = "x" },
				{ "<leader>fu", "<cmd>FzfLua lsp_incoming_calls<cr>", desc = "Search used" },
				{
					"<leader>ff",
					function()
						fzf.files({
							delimiter = " ",
						})
					end,
					desc = "Search files",
				},
				{ "<leader><leader>", fzf.buffers, desc = "Search buffer", hidden = true },
				{ "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Search quickfix lists" },
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

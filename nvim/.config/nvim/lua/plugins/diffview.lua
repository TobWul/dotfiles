return {
	{ -- Diffview
		"sindrets/diffview.nvim",
		opts = {
			enhanced_diff_hl = true,
			use_icons = true,
			view = {
				default = {
					winbar_info = false,
				},
			},
			hooks = {
				diff_buf_win_enter = function(bufnr, winid, ctx)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
					if ctx.layout_name:match("^diff2") then
						if ctx.symbol == "a" then
							vim.wo[winid].winbar = "  HEAD: " .. filename
						elseif ctx.symbol == "b" then
							vim.wo[winid].winbar = "  Working Tree: " .. filename
						end
					end
				end,
			},
		},
		config = function(_, opts)
			require("diffview").setup(opts)
			vim.keymap.set(
				"n",
				"<leader>gdf",
				"<cmd>DiffviewFileHistory --follow %<cr>",
				{ desc = "[G]it [D]iff [F]ile history" }
			)
			vim.keymap.set(
				"v",
				"<leader>gdf",
				"<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
				{ desc = "[G]it [D]iff [F]ile history" }
			)
			vim.keymap.set("n", "<leader>dd", function()
				vim.cmd("DiffviewOpen")
			end, { desc = "[D]iff current changes" })

			vim.keymap.set("n", "<leader>dm", function()
				vim.cmd("DiffviewOpen HEAD origin/main")
			end, { desc = "[D]iff origin/main" })

			vim.keymap.set("n", "<leader>db", function()
				local fzf = require("fzf-lua")
				fzf.git_branches({
					prompt = "Select branch to diff: ",
					actions = {
						["default"] = function(selected)
							vim.cmd("DiffviewOpen " .. selected[1] .. "...HEAD")
						end,
					},
				})
			end, { desc = "[D]iff [B]ranches" })
		end,
	},
}

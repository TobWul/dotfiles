return {
	{ -- Git signs
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		},
		config = function()
			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "[G]it [P]review hunk" })
			vim.keymap.set(
				"n",
				"<leader>gb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				{ desc = "[G]it toggle [B]lame" }
			)
		end,
	},
	{ -- Diffview
		"sindrets/diffview.nvim",
		opts = { enhanced_diff_hl = true, use_icons = true },
		config = function()
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
	{ -- LazyGit integration
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazy[G]it" } },
	},
}

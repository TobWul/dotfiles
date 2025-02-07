return {
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				view = {
					-- Disable the default normal mode mapping for `<tab>`:
					["<leader>e"] = false,
					["<leader>s"] = false,
				},
			})
			local wk = require("which-key")

			local function get_default_branch_name()
				local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
				return res.code == 0 and "main" or "master"
			end

			wk.add({
				{ "<leader>cd", group = "diff" },
				{ "<leader>cdd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
				{ "<leader>cdc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
				{ "<leader>cdh", "<cmd>DiffviewFileHistory<cr>", desc = "Open local file history" },
				{
					"<leader>cdm",
					function()
						vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
					end,
					desc = "Diffview Main",
				},
			})
		end,
	},
}

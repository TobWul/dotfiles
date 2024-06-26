return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			-- Starcraft base hotkeys
			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end)

			-- Menu style

			local wk = require("which-key")

			wk.register({
				["<leader>h"] = {
					name = "+harpoon",
					a = {
						function()
							harpoon:list():add()
						end,
						"Add current file to harppon list",
					},
					l = {
						function()
							harpoon.ui:toggle_quick_menu(harpoon:list())
						end,
						"Open harpoon list",
					},
				},
			})
		end,
	},
}

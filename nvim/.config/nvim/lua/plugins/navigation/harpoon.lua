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

			local wk = require("which-key")

			-- Starcraft base hotkeys
			wk.add({
				{
					"<leader>1",
					function()
						harpoon:list():select(1)
					end,
					hidden = true,
				},
				{
					"<leader>2",
					function()
						harpoon:list():select(2)
					end,
					hidden = true,
				},
				{
					"<leader>3",
					function()
						harpoon:list():select(3)
					end,
					hidden = true,
				},
				{
					"<leader>4",
					function()
						harpoon:list():select(4)
					end,
					hidden = true,
				},
				{ "<leader>h", group = "harpoon", icon = { icon = "" } },
				{
					"<leader>ha",
					function()
						harpoon:list():add()
					end,
					desc = "Add current file to harppon list",
				},
				{
					"<leader>hl",
					function()
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Open harpoon list",
				},
			})
		end,
	},
}

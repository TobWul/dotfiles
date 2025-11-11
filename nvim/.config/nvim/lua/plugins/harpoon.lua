return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- Defer load until after UI settles
		event = "VeryLazy",
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
			local wk = require("which-key")
			local keymaps = {
				{ "<leader>h", group = "[H]arpoon", icon = { icon = "" } },
				{ "<leader>ha", function() harpoon:list():add() end, desc = "[H]arpoon [A]dd current file" },
				{ "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "[H]arpoon [L]ist" },
			}
			for i = 1, 9 do
				table.insert(keymaps, { "<leader>" .. i, function() harpoon:list():select(i) end, desc = "Harpoon " .. i, hidden = true })
			end
			wk.add(keymaps)
		end,
	},
}

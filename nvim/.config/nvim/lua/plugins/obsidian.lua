return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/Git/lego-notes/**",
		"BufNewFile " .. vim.fn.expand("~") .. "/Git/lego-notes/**",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local date_format = "%A, %B %d, %Y"
		local short_date_format = "%d-%m-%y"

		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = "~/Git/lego-notes",
				},
			},
			templates = {
				folder = "templates",
				date_format = date_format,
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "02 Areas/daily-notes",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = short_date_format,
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = date_format,
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = "templates/daily.md",
			},
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			}, -- see below for full list of options 👇
		})
		-- Keybindings
		local wk = require("which-key")
		wk.register({
			["<leader>b"] = { name = "+obsidian" },
		})
		vim.keymap.set("n", "<leader>bd", "<cmd>:ObsidianToday 0<CR>", { desc = "Open today's daily note" })
		vim.keymap.set("n", "<leader>bt", "<cmd>:ObsidianTemplate<CR>", { desc = "Open template picker" })
		vim.keymap.set(
			"n",
			"<leader>bl",
			"<cmd>:ObsidianDailies -21 0<CR>",
			{ desc = "Open a list of last weeks daily notes" }
		)
		vim.keymap.set("n", "<leader>bp", "<cmd>:ObsidianPasteImg<CR>", { desc = "Paste image from clipboard" })
	end,
	-- see below for full list of optional dependencies 👇
}

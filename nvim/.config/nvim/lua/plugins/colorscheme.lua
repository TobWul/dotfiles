return {
	-- {
	-- 	"vague2k/vague.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other plugins
	-- 	config = function()
	-- 		-- NOTE: you do not need to call setup if you don't want to.
	-- 		require("vague").setup({
	-- 			-- optional configuration here
	-- 		})
	-- 		vim.cmd("colorscheme vague")
	-- 	end,
	-- },
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function(_, opts)
			require("everforest").setup({
				-- Your config here
				background = "hard",
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	lazy = false,
	-- 	opts = {
	-- 		integrations = {
	-- 			aerial = true,
	-- 			alpha = true,
	-- 			cmp = true,
	-- 			dashboard = true,
	-- 			flash = true,
	-- 			fzf = true,
	-- 			grug_far = true,
	-- 			gitsigns = true,
	-- 			headlines = true,
	-- 			illuminate = true,
	-- 			indent_blankline = { enabled = true },
	-- 			leap = true,
	-- 			lsp_trouble = true,
	-- 			mason = true,
	-- 			markdown = true,
	-- 			mini = true,
	-- 			native_lsp = {
	-- 				enabled = true,
	-- 				underlines = {
	-- 					errors = { "undercurl" },
	-- 					hints = { "undercurl" },
	-- 					warnings = { "undercurl" },
	-- 					information = { "undercurl" },
	-- 				},
	-- 			},
	-- 			navic = { enabled = true, custom_bg = "lualine" },
	-- 			neotest = true,
	-- 			neotree = true,
	-- 			noice = true,
	-- 			notify = true,
	-- 			semantic_tokens = true,
	-- 			snacks = true,
	-- 			telescope = true,
	-- 			treesitter = true,
	-- 			treesitter_context = true,
	-- 			which_key = true,
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			transparent_background = false,
	-- 		})
	-- 		-- Start med mocha (mørk)
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	--
	-- 		-- Global variabel for å holde styr på tema
	-- 		vim.g.catppuccin_flavor = "latte"
	--
	-- 		-- Toggle-funksjon
	-- 		function ToggleTheme()
	-- 			if vim.g.catppuccin_flavor == "latte" then
	-- 				vim.cmd.colorscheme("catppuccin-mocha")
	-- 				vim.g.catppuccin_flavor = "mocha"
	-- 			else
	-- 				vim.cmd.colorscheme("catppuccin-latte")
	-- 				vim.g.catppuccin_flavor = "latte"
	-- 			end
	-- 		end
	--
	-- 		-- Sett opp tastatursnarvei, f.eks. <leader>tt
	-- 		vim.keymap.set("n", "<leader>tt", ToggleTheme, { desc = "[T]oggle between light/dark theme" })
	-- 	end,
	-- },
}

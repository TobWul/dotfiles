return {
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = { "../snippets" } })
				end,
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		opts = {
			keymap = {
				preset = "super-tab",
				["<c-k>"] = { "select_prev", "fallback" },
				["<c-j>"] = { "select_next", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true, auto_show_delay_ms = 0 } },
			sources = {
				default = { "lsp", "path", "snippets", "lazydev", "copilot" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					copilot = { name = "copilot", module = "blink-cmp-copilot", score_offset = 100, async = true },
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		},
	},
}

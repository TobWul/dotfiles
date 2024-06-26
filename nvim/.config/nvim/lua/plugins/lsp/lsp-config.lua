return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "tailwindcss" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tailwindcss = {},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local wk = require("which-key")
			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.typos_lsp.setup({
				-- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
				cmd_env = { RUST_LOG = "error" },
				init_options = {
					-- Custom config. Used together with any workspace config files, taking precedence for
					-- settings declared in both. Equivalent to the typos `--config` cli argument.
					config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
					-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
					-- Defaults to error.
					diagnosticSeverity = "Error",
				},
			})

			wk.register({
				["<leader>c"] = { name = "+code" },
			})

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" })
		end,
	},
}

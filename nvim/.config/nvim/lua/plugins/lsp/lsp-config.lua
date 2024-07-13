return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "emmet_ls" },
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
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.emmet_ls.setup({
				-- on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"pug",
					"typescriptreact",
					"vue",
				},
			})

			wk.add({
				{ "<leader>c", group = "code" },
				{ "<leader>gd", vim.lsp.buf.definition, desc = "Go to definition" },
				{ "<leader>ch", vim.lsp.buf.hover, desc = "Hover" },
				{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
			})
		end,
	},
}

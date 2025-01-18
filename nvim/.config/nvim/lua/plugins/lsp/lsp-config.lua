return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "emmet_ls", "pyright", "css-lsp" },
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
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			lspconfig.lua_ls.setup({})
			lspconfig.css_lsp.setup({})
			lspconfig.ts_ls.setup({
				root_dir = require("lspconfig.util").root_pattern(".git"),
			})
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

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			-- Emmet configuration
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
				{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
				{ "<leader>ch", vim.lsp.buf.hover, desc = "Hover" },
				{
					"<leader>ca",
					function()
						require("fzf-lua").lsp_code_actions({
							winopts = {
								relative = "cursor",
								width = 0.4,
								height = 0.2,
								row = 1,
								preview = { hidden = "hidden" },
							},
							timeout = 1000,
						})
					end,
					desc = "Code action",
					mode = { "n", "v" },
				},
			})
		end,
	},
}

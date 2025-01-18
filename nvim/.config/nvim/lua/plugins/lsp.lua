return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"prettierd", -- prettier formatter
					"stylua", -- lua formatter
					"eslint_d", -- js linter
					"markdownlint", -- markdown linter
					"typos-lsp", -- spell checker
					"darker", -- python formatter
					"stylelint",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "emmet_ls", "pyright", "cssls" },
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
			lspconfig.cssls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.typos_lsp.setup({
				cmd_env = { RUST_LOG = "error" },
				init_options = {
					config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
					diagnosticSeverity = "Error",
				},
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.emmet_ls.setup({
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

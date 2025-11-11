return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
		},
		config = function()
			local noice = require("noice")
			noice.setup({
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
				},
				views = {
					cmdline_popup = {
						position = { row = 5, col = "50%" },
						size = { width = 60, height = "auto" },
						border = { style = "none", padding = { 1, 1 } },
						filter_options = {},
						win_options = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{ "rcarriga/nvim-notify", opts = {

				render = "minimal",
				stages = "static",
			} },
		},
	},
}

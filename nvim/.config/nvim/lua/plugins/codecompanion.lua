return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "deepseek",
					},
					inline = {
						adapter = "deepseek",
					},
				},
				adapters = {
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "cmd:op read op://personal/LLM/credential --no-newline",
							},
						})
					end,
					deepseek = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "deepseek-r1",
							schema = {
								model = {
									default = "deepseek-r1:7b",
								},
								num_ctx = {
									default = 16384,
								},
								num_predict = {
									default = -1,
								},
							},
						})
					end,
				},
				prompt_library = {
					["Code Expert"] = {
						strategy = "chat",
						description = "Get some special advice from an LLM",
						opts = {
							mapping = "<LocalLeader>ce",
							modes = { "v" },
							short_name = "expert",
							auto_submit = true,
							stop_context_insertion = true,
							user_prompt = true,
						},
						prompts = {
							{
								role = "system",
								content = function(context)
									return "I want you to act as a senior "
										.. context.filetype
										.. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
								end,
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)

									return "I have the following code:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```\n\n"
								end,
								opts = {
									contains_code = true,
								},
							},
						},
					},
				},
			})
			local wk = require("which-key")
			wk.add({
				{ "<leader>a", group = "AI" },
				{ "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Open AI Chat" },
				{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "Open AI Chat" },
				{
					"<leader>ac",
					"<cmd>CodeCompanionChat Add<CR>",
					desc = "Open AI Chat with visally selected text",
					mode = "v",
				},
			})
		end,
	},
}

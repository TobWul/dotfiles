return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				display = {
					show_header_separator = false,
				},
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
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
					["JSDocs"] = {
						strategy = "chat",
						description = "Generate comprehensive JSDoc documentation for React components written in Typescript",
						opts = {
							short_name = "jsdoc",
							auto_submit = true,
						},
						prompts = {
							{
								role = "system",
								content = [[You are a technical writer specializing in React design systems with knowledge about code and UX. 
Your task is to generate comprehensive JSDoc documentation that follows these rules:
- Write a very brief sentence about what this component is.
- Write about recommendations for usage with a focus on helping developers think about UX.
- Include @example with common usage patterns
- Add @link to Storybook documentation
- Add @link to Figma documentation
- Document every prop in the Typescript type. Often in the format of "type ComponentProps = {}"
- Write everything in norwegian, but keep parameters in the original language.

Here is an example:

/**
 * En Table-komponent som viser data i tabellformat.
 * 
 * @description
 * Bruk denne komponenten når du har en liste med data som du ønsker å vise til brukeren. Tabeller egner seg godt til å sammenligne elementer på tvers av rader og kolonner.
 * 
 * @remarks
 * Anbefalinger for bruk:
 * - Bruk de forskjellige kolonnetypene for å vise dataene på mest hensiktsmessig måte.
 * - Velg kun de viktigste dataene som skal vises i tabellen. For ytterligere data,
 *   vurder å åpne opp en detaljvisning.
 * - Velg et begrenset antall felter å filtrere på. Fokuser på de viktigste
 *   feltene som brukerne sannsynligvis vil ønske å filtrere på.
 * 
 * @component
 * @param {TableProps} props - Komponentens props
 * @param {string} props.title - Tittelteksten som vises i tabellhodet
 * @param {string} [props.className] - Ekstra CSS-klasser som skal anvendes på tabellen. Gjelder for den omkringliggende <table>-taggen.
 * @param {string} [as] - Override av taggen som brukes til å rendre den omkringliggende <Box>-taggen. Standard er "table"
 * @param [...rest] - Alle andre props videresendes til <table>-taggen
 * @param {React.ReactNode} props.children - Innholdet som skal vises når accordion er utvidet
 * 
 * @see [Storybook](https://komponenter.ren.no/Table)
 * @see [Figma](https://www.figma.com/design/B5ErWqVWt0dK3q1r6zaGVh/%F0%9F%93%90-REN-Designsystem?node-id=18-476&t=H8GqUUikc9BSLD6Y-11)
 */
]],
							},
							{
								role = "user",
								content = function(context)
									local text = require("codecompanion.helpers.actions").get_code(
										context.start_line,
										context.end_line
									)

									return "Generate JSDoc documentation for this React component:\n\n```"
										.. context.filetype
										.. "\n"
										.. text
										.. "\n```"
								end,
								opts = {
									contains_code = true,
								},
							},
						},
					},
					["Code Expert"] = {
						strategy = "chat",
						description = "Get some special advice from an LLM",
						opts = {
							mapping = "<LocalLeader>ape",
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
				{ "<leader>apd", "<cmd>CodeCompanion /jsdoc<CR>", desc = "JSDoc React component", mode = "v" },
			})
		end,
	},
}

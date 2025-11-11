return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		opts = {
			grep = {
				rg_glob = true,
				-- first returned string is the new search query
				-- second returned string are (optional) additional rg flags
				-- @return string, string?
				rg_glob_fn = function(query)
					local regex, flags = query:match("^(.-)%s%-%-(.*)$")
					-- If no separator is detected will return the original query
					return (regex or query), flags
				end,
			},
		},
		keys = {
			{
				"<leader>fh",
				function()
					require("fzf-lua").helptags()
				end,
				desc = "[F]ind [H]elp",
			},
			{
				"<leader>fk",
				function()
					require("fzf-lua").keymaps()
				end,
				desc = "[F]ind [K]eymaps",
			},
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({ delimiter = " " })
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "[F]ind [G]rep",
			},
			{
				"<leader>fd",
				function()
					require("fzf-lua").diagnostics_workspace()
				end,
				desc = "[F]ind [D]iagnostics",
			},
			{
				"<leader>fr",
				function()
					require("fzf-lua").resume()
				end,
				desc = "[F]ind [R]esume",
			},
			{
				"<leader>f.",
				function()
					require("fzf-lua").oldfiles()
				end,
				desc = "[F]ind Recent Files",
			},
			{
				"<leader><leader>",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "Find Buffers",
			},
			{ "<leader>fc", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", mode = "v", desc = "[F]ind [C]urrent word" },
			{ "<leader>fn", "<cmd>noh<CR>", desc = "[F]ind [N]one" },
		},
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup({ "telescope" })
			fzf.register_ui_select()
		end,
	},
}

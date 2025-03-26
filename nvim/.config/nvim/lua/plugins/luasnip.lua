return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			-- Load VSCode-style snippets from JSON files
			require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/" })
		end,
	},
}

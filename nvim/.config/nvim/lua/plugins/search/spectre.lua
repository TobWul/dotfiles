-- Search and replace
return {
	"nvim-pack/nvim-spectre",
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>r", group = "replace" },
			{
				"<leader>S",
				'<cmd>lua require("spectre").toggle()<CR>',
				desc = "Open spectre",
				icon = { icon = "󰛔" },
			},
			-- {
			--   "<leader>rw",
			--   '<esc><cmd>lua require("spectre").open_visual()<CR>',
			--   desc = "Search and replace word",
			--   mode = "v",
			-- },
			{
				"<leader>rw",
				[[:<C-u>%sV<C-r><C-w>//gc<Left><Left><Left>]],
				desc = "Replace selected word",
				mode = "x",
			},
		})
	end,
}

-- Seamless <C-h/j/k/l> navigation between Neovim splits and the outer
-- multiplexer. Move between Neovim splits; at a split edge, hand off so focus
-- crosses into the neighbouring pane. Inside herdr this uses `herdr pane focus`
-- (the herdr side is the vim-herdr-navigation plugin, wired up in
-- herdr/.config/herdr/config.toml). Outside herdr it falls back to tmux, so a
-- tmux setup keeps working.
--
-- Mirrors vim-herdr-navigation's editor/nvim.lua, inlined here so it lives in
-- this repo and wins over vim-tmux-navigator's own mappings.

local function nav(wincmd, dir)
	local prev = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. wincmd)
	if vim.api.nvim_get_current_win() ~= prev then
		return -- moved within Neovim
	end
	-- At a split edge: cross into the surrounding multiplexer.
	if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
		local herdr = vim.env.HERDR_BIN_PATH
		if herdr == nil or herdr == "" then
			herdr = "herdr"
		end
		vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
	elseif vim.env.TMUX and vim.env.TMUX ~= "" then
		local tmux = { left = "Left", down = "Down", up = "Up", right = "Right" }
		pcall(vim.cmd, "TmuxNavigate" .. tmux[dir])
	end
end

return {
	"christoomey/vim-tmux-navigator",
	-- Keep the plugin for its TmuxNavigate* commands (tmux fallback above), but
	-- disable its default <C-h/j/k/l> mappings so ours win.
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<C-h>", function() nav("h", "left") end, mode = "n", desc = "Navigate left (vim/herdr)" },
		{ "<C-j>", function() nav("j", "down") end, mode = "n", desc = "Navigate down (vim/herdr)" },
		{ "<C-k>", function() nav("k", "up") end, mode = "n", desc = "Navigate up (vim/herdr)" },
		{ "<C-l>", function() nav("l", "right") end, mode = "n", desc = "Navigate right (vim/herdr)" },
	},
}

-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Seamless <C-h/j/k/l> navigation between Neovim splits and herdr panes.
-- Move between splits; at a split edge, hand focus to the neighbouring herdr
-- pane. The herdr side is the vim-herdr-navigation plugin, wired up in
-- herdr/.config/herdr/config.toml.
local function navigate(wincmd, dir)
	local prev = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. wincmd)
	if vim.api.nvim_get_current_win() ~= prev or (vim.env.HERDR_PANE_ID or "") == "" then
		return
	end
	local herdr = vim.env.HERDR_BIN_PATH
	if herdr == nil or herdr == "" then
		herdr = "herdr"
	end
	vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--current" })
end
vim.keymap.set("n", "<C-h>", function() navigate("h", "left") end, { desc = "Navigate left (vim/herdr)" })
vim.keymap.set("n", "<C-j>", function() navigate("j", "down") end, { desc = "Navigate down (vim/herdr)" })
vim.keymap.set("n", "<C-k>", function() navigate("k", "up") end, { desc = "Navigate up (vim/herdr)" })
vim.keymap.set("n", "<C-l>", function() navigate("l", "right") end, { desc = "Navigate right (vim/herdr)" })

-- Half page up/down navigation
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set({ "n", "x" }, "J", "5gj")
vim.keymap.set({ "n", "x" }, "K", "5gk")

-- New search keymap
vim.keymap.set("n", "+", "/")
vim.keymap.set("n", "B", "^")
vim.keymap.set("n", "E", "$")

-- recenters the screen after jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without copying the text
vim.keymap.set("x", "p", '"_dP')

--paste from clipboard
vim.keymap.set({ "n", "v" }, "p", '"+p')

-- copy to clipboard
vim.keymap.set({ "n", "v" }, "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set({ "n", "v" }, "d", '"+d')
vim.keymap.set("n", "D", '"+D')

-- Disable Q, only messes with stuff
vim.keymap.set("n", "Q", ":tabc<CR>", { desc = "Close tab" })

-- Select all
vim.keymap.set("n", "va", "ggVG")

-- Save
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "[S]ave" })

vim.keymap.set("n", "<leader>cr", ":%s:::g<Left><Left><Left>", { desc = "Search and Replace with" })
vim.keymap.set("v", "<leader>cr", function()
	-- Get the selected text
	vim.cmd('normal! "vy')
	local selected_text = vim.fn.getreg("v")
	-- Build and execute the command
	local cmd = ":%s:" .. selected_text .. "::g"
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd .. "<Left><Left>", true, false, true), "n", false)
end, { desc = "Search and Replace selected text" })

-- Console log selected text
vim.keymap.set("v", "<leader>cl", function()
	-- Yank the visually selected text into the v register
	vim.cmd('normal! "vy')
	-- Get the yanked text from the v register
	local selected_text = vim.fn.getreg("v")

	-- Get the line number of the end of visual selection
	local line_number = vim.fn.line("'>")

	-- Create console.log statement
	local log_statement = string.format('console.log("%s:", %s);', selected_text, selected_text)

	vim.api.nvim_buf_set_lines(0, line_number, line_number, false, { log_statement })
end, { desc = "Console log selected text" })

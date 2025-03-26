-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Keymaps for shift + j to move 5j and shift + k to move 5k
vim.keymap.set("n", "J", "5gj")
vim.keymap.set("v", "J", "5gj")
vim.keymap.set("n", "K", "5gk")
vim.keymap.set("v", "K", "5gk")

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
vim.keymap.set("n", "Q", "<nop>")

-- Save
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Replace visually selected text in substitute command
vim.keymap.set("x", "<leader>cr", function()
	-- Yank the visually selected text into the v register
	vim.cmd('normal! "vy')
	-- Get the yanked text from the v register
	local selected_text = vim.fn.getreg("v")
	-- Escape special characters to prevent syntax issues
	selected_text = vim.fn.escape(selected_text, "\\/.*$^~[]")

	-- Build the substitution command with /g at the end
	local cmd = ":%s/" .. selected_text .. "//g"

	-- Feed the command to the command line
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n", false)

	-- Move the cursor left twice to position it between the slashes
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), "n", false)
end, { desc = "Substitute Visually Selected Text with Global Flag" })

-- Console log selected text
vim.keymap.set("v", "<leader>cl", function()
	-- Yank the visually selected text into the v register
	vim.cmd('normal! "vy')
	-- Get the yanked text from the v register
	local selected_text = vim.fn.getreg("v")
	-- Escape special characters to prevent syntax issues
	selected_text = vim.fn.escape(selected_text, "\\/.*$^~[]")

	-- Get the line number of the end of visual selection
	local line_number = vim.fn.line("'>")

	-- Create console.log statement
	local log_statement = string.format("console.log(%s);", selected_text)

	vim.api.nvim_buf_set_lines(0, line_number, line_number, false, { log_statement })
end, { desc = "Console log selected text" })

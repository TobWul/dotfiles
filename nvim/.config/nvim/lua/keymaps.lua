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

-- Move lines up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

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

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- File handling
vim.keymap.set("n", "<leader>qq", "<cmd>wqa<CR>", { desc = "Save and quit all" })
vim.keymap.set("n", "<leader>qw", "<cmd>wq<CR>", { desc = "Save and quit current file" })
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "Save" })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Replace

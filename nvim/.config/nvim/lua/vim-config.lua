vim.o.conceallevel = 1
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.wo.relativenumber = true
vim.wo.number = true

vim.api.nvim_command("setlocal spell spelllang=en_gb")

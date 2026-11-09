-- TypeScript 7 (the native Go port) ships no tsserver.js, so typescript-tools
-- can't start there. Those projects get the native LSP (`tsc --lsp`) instead.
local function project_root(path)
	local root = vim.fs.root(path, "tsconfig.json") or vim.fs.root(path, { "package.json", "jsconfig.json", ".git" })
	-- don't pick up a root inside node_modules
	return root and root:gsub("/node_modules/.*$", "") or nil
end

local function native_tsc(root)
	local pkg = vim.fs.joinpath(root, "node_modules", "typescript", "package.json")
	local ok, data = pcall(function()
		return vim.json.decode(table.concat(vim.fn.readfile(pkg), "\n"))
	end)
	if ok and data.version and tonumber(data.version:match("^(%d+)")) >= 7 then
		return vim.fs.joinpath(root, "node_modules", ".bin", "tsc")
	end
end

vim.lsp.config("tsgo", {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	cmd = function(dispatchers, config)
		return vim.lsp.rpc.start({ native_tsc(config.root_dir), "--lsp", "--stdio" }, dispatchers, { cwd = config.root_dir })
	end,
	root_dir = function(bufnr, on_dir)
		local root = project_root(vim.api.nvim_buf_get_name(bufnr))
		if root and native_tsc(root) then
			on_dir(root)
		end
	end,
})
vim.lsp.enable("tsgo")

return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- lazy-load on real filetypes (ts/tsx + js/jsx)
		ft = { "typescript", "typescriptreact" },
		opts = {
			-- no root means no attach; single-file mode would bypass that
			single_file_support = false,
			root_dir = function(fname)
				local root = project_root(fname)
				if root and not native_tsc(root) then
					return root
				end
			end,
		},
	},
}

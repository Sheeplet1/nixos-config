-- Load simple plugins that don't require configuration or only need basic setup

-- Load utility/library plugins
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })

-- Load icon support
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

-- Load simple utility plugins
vim.pack.add({ "https://github.com/tpope/vim-sleuth" })

-- Load LSP config (configuration is in lua/lsp.lua)
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

-- Keep package-management operations discoverable from inside Neovim
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update plugins managed by vim.pack" })

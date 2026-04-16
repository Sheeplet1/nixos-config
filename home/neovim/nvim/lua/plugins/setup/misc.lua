local map = vim.keymap.set

map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>md", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview Toggle" })
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left tmux pane" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down tmux pane" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up tmux pane" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right tmux pane" })

-- Keep package-management operations discoverable from inside Neovim.
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update plugins managed by vim.pack" })

-- Load the plugin for its tmux-aware navigation commands, but define the normal
-- mode maps ourselves so their descriptions stay visible in keymap tooling.
vim.g.tmux_navigator_no_mappings = 1

-- vim-tmux-navigator is a Vimscript plugin. Loading it with vim.pack.add()
-- sources plugin/tmux_navigator.vim, which defines the commands; there is no
-- Lua module or setup() function to require.
vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

local map = vim.keymap.set

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left tmux pane", silent = true })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down tmux pane", silent = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up tmux pane", silent = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right tmux pane", silent = true })

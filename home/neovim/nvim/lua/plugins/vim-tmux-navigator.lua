return {
  "christoomey/vim-tmux-navigator",
  event = "VimEnter",
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left tmux pane" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down tmux pane" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up tmux pane" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right tmux pane" },
  },
}

return {
  -- "zbirenbaum/copilot.lua",
  -- enabled = true,
  -- cmd = "Copilot",
  -- event = "InsertEnter",
  -- opts = {
  --   panel = {
  --     auto_refresh = false,
  --     keymap = {
  --       accept = "<M-l>",
  --       jump_prev = "[[",
  --       jump_next = "]]",
  --       refresh = "gr",
  --       open = "<M-CR>",
  --     },
  --   },
  --
  --   suggestion = {
  --     accept = false,
  --     auto_trigger = true,
  --     keymap = {
  --       accept = "<C-l>",
  --       prev = "<M-[>",
  --       next = "<M-]>",
  --       dismiss = "<C-e>",
  --     },
  --   },
  --
  --   filetypes = {
  --     yaml = false,
  --     markdown = false,
  --   },
  -- },

  "github/copilot.vim",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      yaml = false,
      markdown = false,
    }
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<M-[>", "copilot#Previous()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<M-]>", "copilot#Next()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-e>", "copilot#Dismiss()", { expr = true, silent = true })
  end,
}

return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<M-l>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },

    suggestion = {
      accept = false,
      auto_trigger = true,
      keymap = {
        accept = "<C-l>",
        prev = "<M-[>",
        next = "<M-]>",
        dismiss = "<C-e>",
      },
    },

    filetypes = {
      yaml = false,
      markdown = false,
    },
  },
}

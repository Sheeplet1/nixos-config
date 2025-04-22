local options = {
  enabled = false,

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
}

require("copilot").setup(options)

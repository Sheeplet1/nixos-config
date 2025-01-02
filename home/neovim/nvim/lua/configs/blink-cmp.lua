return {
  -- Newer release mappings
  keymap = {
    ["<CR>"] = { "accept", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
  },

  completion = {
    accept = { auto_brackets = { enabled = true } },

    menu = {
      border = "rounded",
    },

    documentation = {
      window = {
        min_width = 15,
        max_width = 50,
        max_height = 15,
        border = "rounded",
      },
      auto_show = true,
      auto_show_delay_ms = 250,
    },
  },

  sources = {
    providers = {
      lsp = {
        min_keyword_length = 1,
        score_offset = -1,
      },
    },
  },
}

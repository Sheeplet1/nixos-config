return {
  -- Newer release mappings
  -- keymap = {
  --   ["<CR>"] = { "select_and_accept" },
  -- },

  keymap = {
    accept = "<CR>",
    hide = "<C-e>",
    select_prev = "<S-Tab>",
    select_next = "<Tab>",
  },

  highlight = {
    -- sets the fallback highlight groups to nvim-cmp's highlight groups
    use_nvim_cmp_as_default = true,
  },

  -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  -- adjusts spacing to ensure icons are aligned
  nerd_font_variant = "mono",

  -- experimental auto-brackets support
  accept = { auto_brackets = { enabled = true } },

  -- experimental signature help support
  trigger = {
    signature_help = {
      enabled = true,
    },
  },

  windows = {
    autocomplete = {
      border = "rounded",
    },

    documentation = {
      min_width = 15,
      max_width = 50,
      max_height = 15,
      border = "rounded",
      auto_show = true,
      auto_show_delay_ms = 250,
    },

    -- ghost_text = {
    --   enabled = true,
    -- },
  },

  providers = {
    lsp = {
      min_keyword_length = 1,
      score_offset = -1,
    },
  },
}

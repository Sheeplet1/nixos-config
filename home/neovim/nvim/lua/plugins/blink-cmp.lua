return {
  "saghen/blink.cmp",
  enabled = true,
  lazy = false, -- lazy loading handled internally
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
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
        -- don't show completion menu automatically in cmdline mode
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      },

      documentation = {
        window = {
          min_width = 15,
          max_width = 50,
          max_height = 15,
          border = "rounded",
        },
        auto_show = false,
        auto_show_delay_ms = 250,
      },
    },

    signature = {
      enabled = false,
      window = {
        show_documentation = false,
      },
    },

    fuzzy = {
      implementation = "lua",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- default = { "lsp", "path", "buffer" },
      providers = {
        lsp = {
          min_keyword_length = 1,
          score_offset = -1,
        },
      },
      -- per_filetype = {
      --   codecompanion = { "codecompanion" },
      -- },
    },
  },
}

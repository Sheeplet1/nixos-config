return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  -- alternative completion plugin to nvim-cmp
  {
    "saghen/blink.cmp",
    enabled = true,
    lazy = false, -- lazy loading handled internally
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    config = function()
      require("blink-cmp").setup(require "configs.blink-cmp")
    end,
  },

  -- autopairing of {}, (), [] when typing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- sets the `commentstring` option based on the cursor location of the
  -- file instead of by filetype. Helpful for embedded languages in certain
  -- file types like Svelte/Vue.
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      require "configs.context-commentstring",
    },
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require "configs.copilot"
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}

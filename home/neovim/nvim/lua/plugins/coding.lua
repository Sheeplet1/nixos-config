return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- alternative completion plugin to nvim-cmp
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = { "rafamadriz/friendly-snippets" },

    -- NOTE: Using this commit since the latest commit introduced breaking
    -- changes into how keymaps work and frankly, they don't work as expected.
    -- So we are rolling back.
    commit = "e20d7731a1f97660896b24d00772d30649cec7c5",

    -- use a release tag to download pre-built binaries
    -- version = "v0.*",
    -- If you use nix, you can build from source using latest nightly rust with:
    build = "nix run .#build-plugin",
    config = function()
      require("blink-cmp").setup(require "configs.blink-cmp")
    end,
  },

  -- autopairing of {}, (), [] when typing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
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
}
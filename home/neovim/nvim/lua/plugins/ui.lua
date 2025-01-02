return {
  "nvim-lua/plenary.nvim",
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "Sheeplet1/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  -- {
  --   "nvchad/base46",
  --   build = function()
  --     require("base46").load_all_highlights()
  --   end,
  -- },

  "nvchad/volt",
  "nvchad/menu",
  { "nvchad/minty", cmd = { "Huefy", "Shades" } },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  -- expand on comment functionality
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "fg",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- edit file system in a buffer
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    cmd = "Oil",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- noice ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "neovim/nvim-lspconfig", "rcarriga/nvim-notify" },
    config = function()
      require "configs.noice"
    end,
    init = function()
      vim.g.lsp_handlers_enabled = false
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },
}

return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- ui for git commands
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- open markdown in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- quick file switching w/ marks
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- sync vim keybinds with tmux panels
  {
    "christoomey/vim-tmux-navigator",
    event = "VimEnter",
  },

  -- dynamically set tabstop and shiftwidth
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "configs.zen-mode"
    end,
  },
}
return {
  -- {
  --   "windwp/nvim-ts-autotag",
  --   event = "InsertEnter",
  --   ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  --   config = function()
  --     require("nvim-ts-autotag").setup()
  --   end,
  -- },

  -- ui for git commands
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

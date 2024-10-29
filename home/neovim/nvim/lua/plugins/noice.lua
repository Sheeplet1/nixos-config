return {
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
}

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  enabled = false,
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup {
      preset = "ghost",
      virt_texts = {
        priority = 10000,
      },
      throttle = 0,
      enable_on_insert = true,
      enable_on_select = true,
      multilines = {
        enabled = true,
        always_show = true,
        trim_whitespaces = true,
      },
      show_all_diags_on_cursorline = false,
    }
    vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end,
}

return {
  -- edit file system in a buffer
  "stevearc/oil.nvim",
  event = "VeryLazy",
  cmd = "Oil",
  opts = {
    columns = {
      "icon",
    },
    float = {
      border = "rounded",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<C-n>",
      function() require("oil").open_float() end,
      desc = "Open Oil in float",
    },
  },
}

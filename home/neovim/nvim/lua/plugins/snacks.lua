return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },
    image = {},
    zen = {},
    styles = {
      zen = { keys = { q = "close" } },
    },
  },
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
  },
}

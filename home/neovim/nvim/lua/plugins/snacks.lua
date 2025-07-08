return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {},
    picker = {},
    scroll = { enabled = false },
    zen = {},
    styles = {
      zen = { keys = { q = "close" } },
    },
  },
  keys = {
    --
    -- ZenMode
    --
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },

    --
    -- Picker
    --
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    {
      "<leader>fw",
      function() Snacks.picker.grep_word() end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
  },
}

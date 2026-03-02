return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    highlight = {
      keyword = "fg",
    },
  },
  keys = {
    { "<leader>ft", function() require("snacks").picker.todo_comments() end, desc = "Todo" },
    {
      "<leader>fT",
      function() require("snacks").picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } } end,
      desc = "Todo/Fix/Fixme",
    },
  },
}

return {
  "folke/todo-comments.nvim",
  lazy = false,
  optional = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    highlight = {
      keyword = "fg",
    },
  },
  keys = {
    { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    {
      "<leader>fT",
      function() Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } } end,
      desc = "Todo/Fix/Fixme",
    },
  },
}

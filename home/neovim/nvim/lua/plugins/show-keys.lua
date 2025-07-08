return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    timeout = 60,
    maxkeys = 5,
    -- more opts
  },
  keys = {
    {
      "<leader>sk",
      "<cmd>ShowkeysToggle<CR>",
      desc = "Toggle Showkeys",
    },
  },
}

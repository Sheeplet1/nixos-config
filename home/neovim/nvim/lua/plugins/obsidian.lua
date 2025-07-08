return {
  "obsidian.nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Documents/personal/vaults/my-second-brain/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/personal/vaults/my-second-brain",
      },
    },
    notes_subdir = "notes",
    new_notes_location = "notes_subdir",
    templates = { folder = "templates" },
    attachments = { img_folder = "attachments" },
    completion = { nvim_cmp = false, blink = true },
    picker = { name = "telescope.nvim" },
  },
}

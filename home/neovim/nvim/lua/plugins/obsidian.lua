return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Documents/personal/vaults/my-second-brain/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/personal/vaults/the-archives",
      },
    },
    notes_subdir = "notes",
    new_notes_location = "notes_subdir",
    templates = { folder = "templates" },
    attachments = { img_folder = "attachments" },
    completion = { nvim_cmp = false, blink = true, min_chars = 2 },
    picker = { name = "snacks.pick" },
    daily_notes = {
      folder = "periodic-notes/001-daily",
      date_format = "%Y-%m-%d-%a",
      default_tags = { "daily" },
      template = "template-daily.md",
    },
  },
}

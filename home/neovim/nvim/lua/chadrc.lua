-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  base46 = {
<<<<<<< HEAD
    theme = "gruvbox",
=======
    theme = "tokyonight",
>>>>>>> 8e1730a (update deps)
    integrations = {
      "cmp",
      "todo",
      "telescope",
      "rainbowdelimiters",
      "mason",
    },
  },

  ui = {
    statusline = {
      theme = "minimal",
      separator_style = "block",
    },

    telescope = {
      style = "bordered",
    },

    lsp = {
      signature = false,
    },
  },
}

return M

-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "onedark",
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

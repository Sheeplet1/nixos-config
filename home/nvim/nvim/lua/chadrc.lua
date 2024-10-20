-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "chadracula-evondev",
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
      separator_style = "round",
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

-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

local stbufnr = function() return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0) end

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "everforest",
    integrations = {
      "cmp",
      "todo",
      "telescope",
      "rainbowdelimiters",
      "mason",
    },
    -- Snacks support
    hl_add = {
      SnacksPicker = { bg = "darker_black" },
      SnacksPickerPrompt = { fg = "blue", bg = "black2" },
      SnacksPickerInput = { fg = "blue", bg = "black2" },
      SnacksPickerPreview = { bg = "darker_black" },
      SnacksPickerTitle = { fg = "black2", bg = "yellow", bold = true },
      SnacksPickerInputTitle = { fg = "black", bg = "red", bold = true },
      SnacksPickerPreviewTitle = { fg = "black", bg = "green", bold = true },
      SnacksPickerListTitle = { fg = "black", bg = "black", bold = true },
      -- SnacksInputNormal = { fg = "blue", bg = "darker_black" },

      -- Borderless
      -- SnacksPickerBorder = { fg = "darker_black", bg = "darker_black" },
      -- SnacksPickerInputBorder = { fg = "black2", bg = "black2" },
      -- SnacksPickerListBorder = { fg = "darker_black", bg = "darker_black" },
      -- SnacksPickerBoxBorder = { fg = "darker_black", bg = "darker_black" },
      -- SnacksPickerPreviewBorder = { fg = "darker_black", bg = "darker_black" },

      -- Enable border
      SnacksInputBorder = { fg = "darker_black", bg = "darker_black" },
    },
  },

  ui = {
    statusline = {
      theme = "default",
      separator_style = "arrow",
      order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
      modules = {
        relativepath = function()
          local path = vim.api.nvim_buf_get_name(stbufnr())
          if path == "" then return "" end
          return "%#St_relativepath#  " .. vim.fn.expand "%:.:h" .. " /"
        end,
      },
    },

    telescope = {
      style = "bordered",
    },

    tabufline = {
      order = { "buffers" },
    },
  },

  lsp = {
    signature = true,
  },
}

return M

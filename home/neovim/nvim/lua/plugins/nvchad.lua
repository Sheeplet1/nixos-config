-- Packages from NVChad distribution
return {
  {
    "nvchad/ui",
    lazy = false,
    config = function() require "nvchad" end,
  },
  {
    "nvchad/base46",
    branch = "v3.0",
    build = function() require("base46").load_all_highlights() end,
  },
  "nvchad/volt",
  "nvchad/menu",
  { "nvchad/minty", cmd = { "Huefy", "Shades" } },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
}

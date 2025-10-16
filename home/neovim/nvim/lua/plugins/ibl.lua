return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = false,
  event = "User FilePost",
  opts = {
    indent = { char = "│", highlight = "IblChar" },
    scope = { char = "│", highlight = "IblScopeChar" },
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "blankline")
    require("ibl").setup(opts)
    dofile(vim.g.base46_cache .. "blankline")
  end,
}

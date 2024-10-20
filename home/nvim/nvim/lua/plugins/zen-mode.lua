return {
  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require "configs.zen-mode"
    end,
  },
}

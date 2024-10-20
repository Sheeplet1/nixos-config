local options = {
  window = {
    width = 180,
    height = 1,
    backdrop = 0.93,
  },

  plugins = {
    options = {
      -- disable command in the last line of the screen
      showcmd = true,
    },

    tmux = {
      enabled = true,
    },

    gitsigns = {
      enabled = true,
    },
  },
}

require("zen-mode").setup(options)

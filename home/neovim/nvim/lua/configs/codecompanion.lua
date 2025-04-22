local options = {
  enabled = true,
  adapters = {
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        env = {
          api_key = "AIzaSyCy3ur3KgpXTdzhsIo12RxYeeB5KqNHlHE",
        },
        schema = {
          model = {
            default = "gemini-2.5-pro-exp-03-25",
          },
        },
      })
    end,
  },
  display = {
    chat = {
      show_header_separator = true,
      -- show_settings = true,
      show_references = true,
      show_token_count = true,
      window = {
        opts = {
          number = false,
          signcolumn = "no",
        },
      },
    },
  },
  strategies = {
    chat = {
      adapter = "gemini",
      keymaps = {
        completion = {
          modes = { i = "<C-/>" },
          callback = "keymaps.completion",
          description = "Completion Menu",
        },
      },
    },
    inline = {
      adapter = "gemini",
    },
  },
}

return options

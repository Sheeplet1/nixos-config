return {
  "olimorris/codecompanion.nvim",
  enabled = false,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "",
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
  },
  keys = {
    {
      "<leader>cc",
      "<cmd>CodeCompanionChat Toggle<CR>",
      desc = "Toggle CodeCompanion",
    },
    {
      "v<C-a>",
      "<cmd>CodeCompanionChat Add<CR>",
      desc = "Add to visual selection to CodeCompanion",
    },
    {
      "v<C-c>",
      "<cmd>CodeCompanionActions<CR>",
      desc = "CodeCompanion Actions",
    },
  },
}

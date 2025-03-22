local web_formatters = { "biome", "prettierd", stop_after_first = true }

local options = {
  formatters = {
    -- Looks through the current working directory for a a configuration file
    -- and uses this formatter if found.
    biome = {
      require_cwd = true,
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    markdown = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },

    css = web_formatters,
    html = web_formatters,
    javascript = web_formatters,
    javascriptreact = web_formatters,
    typescript = web_formatters,
    typescriptreact = web_formatters,

    python = { "isort", "black", "ruff" },
    go = { "gofumpt", "goimports", "golines" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

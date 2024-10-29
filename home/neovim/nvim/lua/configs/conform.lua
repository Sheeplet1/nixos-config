local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    markdown = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },

    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },

    -- python = { "isort", "black" },
    go = { "gofumpt", "goimports", "golines" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    border = "rounded",
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,

  ensure_installed = {
    -- Python
    "pyright",
    "ruff",
    "isort",

    -- Formatters
    "prettierd",

    -- Lua
    "lua-language-server",
    "stylua",

    -- Frontend
    "typescript-language-server",
    "tailwindcss-language-server",
    "css-lsp",
    "html-lsp",
    "eslint-lsp",

    -- Go
    "gopls",
    "gofumpt",
    "goimports",
    "golines",
    "gomodifytags",
    "gotests",

    -- Bash
    "shfmt",
    "bash-language-server",

    -- C++
    "clangd",
    "clang-format",
  },
}

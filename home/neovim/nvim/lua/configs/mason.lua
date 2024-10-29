return {
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

  ui = {
    border = "rounded",
  },
}

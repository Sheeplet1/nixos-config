return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "regex",

        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",

        "json",
        "markdown",
        "markdown_inline",

        "go",
        "rust",
        -- "cpp",
      },
    },
  },
}

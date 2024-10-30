pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "nix",
    "regex",
    "rust",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    -- "cpp",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options

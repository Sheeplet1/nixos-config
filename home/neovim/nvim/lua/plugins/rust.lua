return {
  {
    "saecki/crates.nvim",
    enabled = false,
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },

  {
    "rust-lang/rust.vim",
    enabled = false,
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}

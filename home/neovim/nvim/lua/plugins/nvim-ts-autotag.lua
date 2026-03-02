return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}

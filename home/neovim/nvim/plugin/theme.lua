-- Load colorscheme
-- vim.pack.add({ "https://github.com/sainnhe/everforest" })
-- pcall(vim.cmd.colorscheme, "everforest")

vim.pack.add({
	"https://github.com/ellisonleao/gruvbox.nvim",
})

require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")

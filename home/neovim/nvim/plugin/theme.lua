-- Load colorscheme
vim.pack.add({ "https://github.com/sainnhe/everforest" })
vim.pack.add({ "https://github.com/navarasu/onedark.nvim" })

-- pcall(vim.cmd.colorscheme, "onedark")

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

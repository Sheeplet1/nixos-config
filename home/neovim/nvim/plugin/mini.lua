-- Load all mini.nvim modules
vim.pack.add({ "https://github.com/echasnovski/mini.move" })
vim.pack.add({ "https://github.com/echasnovski/mini.pairs" })
vim.pack.add({ "https://github.com/echasnovski/mini.indentscope" })
vim.pack.add({ "https://github.com/echasnovski/mini.statusline" })
vim.pack.add({ "https://github.com/echasnovski/mini.tabline" })

-- Configure mini.move for moving lines/blocks of text
require("mini.move").setup({
	mappings = {
		left = "<M-h>",
		right = "<M-l>",
		down = "J",
		up = "K",
		line_left = "<M-h>",
		line_right = "<M-l>",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},
	options = {
		reindent_linewise = true,
	},
})

-- Configure mini.pairs for auto-pairing brackets
require("mini.pairs").setup({})

-- Configure mini.indentscope for indent guides
require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

-- Configure mini.statusline
require("mini.statusline").setup()

-- Configure mini.tabline
require("mini.tabline").setup()

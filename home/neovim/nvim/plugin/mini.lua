-- mini.move
vim.pack.add({ "https://github.com/echasnovski/mini.move" })
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

-- mini.pairs
vim.pack.add({ "https://github.com/echasnovski/mini.pairs" })
require("mini.pairs").setup({})

-- mini.indentscope
vim.pack.add({ "https://github.com/echasnovski/mini.indentscope" })
require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

-- mini.statusline
vim.pack.add({ "https://github.com/echasnovski/mini.statusline" })
require("mini.statusline").setup()

-- mini.tabline
vim.pack.add({ "https://github.com/echasnovski/mini.tabline" })
require("mini.tabline").setup()

-- mini.cmdline
vim.pack.add({ "https://github.com/nvim-mini/mini.cmdline" })
require("mini.cmdline").setup()

-- mini.cursorword: highlight word under cursor
vim.pack.add({ "https://github.com/nvim-mini/mini.cursorword" })
require("mini.cursorword").setup()

-- mini.animate
-- vim.pack.add({ "https://github.com/nvim-mini/mini.animate" })
-- require("mini.animate").setup()

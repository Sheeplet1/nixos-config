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

require("mini.pairs").setup({})

require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

require("mini.statusline").setup()

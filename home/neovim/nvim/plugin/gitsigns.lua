-- Load gitsigns plugin for git integration
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gitsigns = require("gitsigns")

gitsigns.setup({
	signs = {
		delete = { text = "󰍵" },
		changedelete = { text = "󱕖" },
	},
})

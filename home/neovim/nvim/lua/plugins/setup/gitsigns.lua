local gitsigns = require("gitsigns")

gitsigns.setup({
	signs = {
		delete = { text = "󰍵" },
		changedelete = { text = "󱕖" },
	},
})

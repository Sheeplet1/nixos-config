-- Load GitHub Copilot plugin
vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

local copilot = require("copilot")

copilot.setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = false,
			prev = "<M-[>",
			next = "<M-]>",
			dismiss = "<C-e>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
	},
})

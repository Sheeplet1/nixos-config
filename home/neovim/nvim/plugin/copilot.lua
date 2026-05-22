-- Load GitHub Copilot plugin
vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

local copilot = require("copilot")

copilot.setup({
	suggestion = {
		accept = false,
		auto_trigger = true,
		keymap = {
			accept = "<Tab>",
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

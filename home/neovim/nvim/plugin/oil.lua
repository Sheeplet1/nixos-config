-- Load oil.nvim file explorer
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

local oil = require("oil")

oil.setup({
	columns = { "icon" },
	float = { border = "rounded", preview_split = "right" },
})

vim.keymap.set("n", "<C-n>", function()
	oil.open_float(nil, {
		preview = {
			update = true,
		},
	})
end, { desc = "Open Oil in float" })

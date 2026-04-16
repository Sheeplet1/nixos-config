local oil = require("oil")

oil.setup({
	columns = { "icon" },
	float = { border = "rounded" },
})

vim.keymap.set("n", "<C-n>", function()
	oil.open_float()
end, { desc = "Open Oil in float" })

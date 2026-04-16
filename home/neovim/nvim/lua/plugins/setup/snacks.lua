local snacks = require("snacks")

snacks.setup({
	image = {},
	picker = {
		-- Keep the picker in list-only mode by default so search density stays high.
		-- Preview is still available on demand via a keybind below.
		layout = {
			preset = "default",
			preview = false,
		},
		win = {
			input = {
				keys = {
					-- Rebind <Tab> from multi-select behavior to preview toggle.
					-- This matches a "peek only when asked" workflow.
					["<Tab>"] = { "toggle_preview", mode = { "i", "n" } },
				},
			},
		},
	},
	scroll = { enabled = false },
	zen = {},
	styles = { zen = { keys = { q = "close" } } },
})

local map = vim.keymap.set
map("n", "<leader>z", function()
	snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader><space>", function()
	snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>:", function()
	snacks.picker.command_history()
end, { desc = "Command History" })
map("n", "<leader>n", function()
	snacks.picker.notifications()
end, { desc = "Notification History" })
map("n", "<leader>ff", function()
	snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	snacks.picker.grep()
end, { desc = "Grep" })
map({ "n", "x" }, "<leader>fw", function()
	snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
map("n", "<leader>fb", function()
	snacks.picker.buffers()
end, { desc = "Find Buffers" })
map("n", "<leader>fr", function()
	snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>fd", function()
	snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>fk", function()
	snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>fh", function()
	snacks.picker.help()
end, { desc = "Help Tags" })

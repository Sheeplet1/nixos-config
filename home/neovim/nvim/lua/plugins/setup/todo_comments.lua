local todo_comments = require("todo-comments")

todo_comments.setup({
	highlight = {
		keyword = "fg",
	},
})

vim.keymap.set("n", "<leader>ft", function()
	Snacks.picker.todo_comments()
end, { desc = "Todo" })
vim.keymap.set("n", "<leader>fT", function()
	Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todo/Fix/Fixme" })

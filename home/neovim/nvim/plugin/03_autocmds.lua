local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking text
autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = augroup("UserHighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set the commentstring for C++ files to use "//"
autocmd("FileType", {
	pattern = "cpp",
	group = augroup("UserCppCommentString", { clear = true }),
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

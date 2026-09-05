local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking text
autocmd({ "TextYankPost", "TextPutPost" }, {
	callback = function()
		vim.hl.hl_op({
			higroup = "Visual",
			timeout = 300,
		})
	end,
	desc = "Highlight yanked and pasted text",
})

-- Set the commentstring for C++ files to use "//"
autocmd("FileType", {
	pattern = "cpp",
	group = augroup("UserCppCommentString", { clear = true }),
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

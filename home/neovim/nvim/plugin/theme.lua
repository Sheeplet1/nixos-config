-- Keep the standalone theme as a fallback until every profile imports Stylix.
if vim.env.STYLIX_ENABLED ~= "1" then
	vim.pack.add({
		"https://github.com/ellisonleao/gruvbox.nvim",
	})

	require("gruvbox").setup()
	vim.cmd.colorscheme("gruvbox")
end

-- Make comments more prominent because they carry important context.
local booleans = vim.api.nvim_get_hl(0, { name = "Boolean" })
vim.api.nvim_set_hl(0, "Comment", booleans)

-- Keep the standalone theme as a fallback until every profile imports Stylix.
if vim.env.STYLIX_ENABLED ~= "1" then
	vim.pack.add({
		"https://github.com/ellisonleao/gruvbox.nvim",
	})

	require("gruvbox").setup()
	vim.cmd.colorscheme("gruvbox")
end

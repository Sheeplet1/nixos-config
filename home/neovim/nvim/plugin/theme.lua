-- Keep the standalone theme as a fallback until every profile imports Stylix.
if vim.env.STYLIX_ENABLED ~= "1" then
	vim.pack.add({
		"https://github.com/ellisonleao/gruvbox.nvim",
	})

	require("gruvbox").setup()
	vim.cmd.colorscheme("gruvbox")
end

-- Less visible window separator
vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })

-- Make comments more prominent -- they are important.
local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
vim.api.nvim_set_hl(0, "Comment", bools)

-- Make it clearly visible which argument we're at.
local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
vim.api.nvim_set_hl(
	0,
	"LspSignatureActiveParameter",
	{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
)

-- Load treesitter and related plugins
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })
vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })

local ts = require("nvim-treesitter")

local parsers = {
	"bash",
	"c_sharp",
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nix",
	"python",
	"regex",
	"rust",
	"swift",
	"svelte",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"zig",
}

-- Parser installation requires tree-sitter CLI. Skip auto-install when it is
-- not present so startup/checkhealth doesn't spam errors on clean machines.
if vim.fn.executable("tree-sitter") == 1 then
	for _, parser in ipairs(parsers) do
		pcall(ts.install, parser)
	end
else
	vim.schedule(function()
		vim.notify("treesitter: skipping parser auto-install (tree-sitter CLI not found)", vim.log.levels.INFO)
	end)
end

-- Enable treesitter for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Configure treesitter-context to show current context
require("treesitter-context").setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
	separator = nil,
	zindex = 20,
})

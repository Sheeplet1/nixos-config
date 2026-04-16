local modules = {
	"plugins.setup.blink_cmp",
	"plugins.setup.treesitter",
	"plugins.setup.ts_context_commentstring",
	"plugins.setup.snacks",
	"plugins.setup.gitsigns",
	"plugins.setup.oil",
	"plugins.setup.mini",
	"plugins.setup.nvim_surround",
	"plugins.setup.which_key",
	"plugins.setup.conform",
	"plugins.setup.lint",
	"plugins.setup.copilot",
	"plugins.setup.harpoon",
	"plugins.setup.go",
	"plugins.setup.markdown_preview",
	"plugins.setup.todo_comments",
	"plugins.setup.ibl",
	"plugins.setup.misc",
	"plugins.setup.mason",
}

for _, module in ipairs(modules) do
	require(module)
end

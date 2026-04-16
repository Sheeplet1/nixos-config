local conform = require("conform")

local has = function(bin)
	return vim.fn.executable(bin) == 1
end
local first_available = function(...)
	local selected = {}
	for _, bin in ipairs({ ... }) do
		if has(bin) then
			table.insert(selected, bin)
		end
	end
	if #selected > 0 then
		selected.stop_after_first = true
	end
	return selected
end

local web_formatters = first_available("biome", "prettierd")
local python_formatters = first_available("isort", "black", "ruff")
local go_formatters = first_available("gofumpt", "goimports", "golines")
local swift_formatters = first_available("swiftformat")

conform.setup({
	formatters = {
		biome = {
			require_cwd = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		markdown = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		css = web_formatters,
		html = web_formatters,
		javascript = web_formatters,
		javascriptreact = web_formatters,
		typescript = web_formatters,
		typescriptreact = web_formatters,
		python = python_formatters,
		go = go_formatters,
		swift = swift_formatters,
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

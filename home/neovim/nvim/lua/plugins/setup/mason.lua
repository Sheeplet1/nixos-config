if not vim.g.use_mason then
	return
end

local mason = require("mason")

local ensure_installed = {
	"pyright",
	"ruff",
	"isort",
	"prettierd",
	"lua-language-server",
	"stylua",
	"typescript-language-server",
	"tailwindcss-language-server",
	"css-lsp",
	"html-lsp",
	"eslint-lsp",
	"gopls",
	"gofumpt",
	"goimports",
	"golines",
	"gomodifytags",
	"gotests",
	"shfmt",
	"bash-language-server",
	"clangd",
	"clang-format",
}

mason.setup({
	PATH = "skip",
	ui = {
		border = "rounded",
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
	max_concurrent_installers = 10,
	ensure_installed = ensure_installed,
})

vim.api.nvim_create_user_command("MasonInstallAll", function()
	local mr = require("mason-registry")
	mr.refresh(function()
		for _, tool in ipairs(ensure_installed) do
			local package = mr.get_package(tool)
			if not package:is_installed() then
				package:install()
			end
		end
	end)
end, {})

local map = vim.keymap.set

-- Define the on_attach function which sets up key mappings for LSPs when they attach to a buffer.
local function on_attach(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))
	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
	map("n", "<leader>ra", vim.lsp.buf.rename, opts("Rename symbol"))
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

-- Define the on_init function which disables semantic tokens if the client supports it.
local function on_init(client)
	if client:supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- Set up LSP capabilities, and if the "blink.cmp" module is available, enhance the capabilities with it.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink and blink.get_lsp_capabilities then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Mapping of server names to their CLI commands.
local server_cmd = {
	bashls = "bash-language-server",
	lua_ls = "lua-language-server",
	pyright = "pyright-langserver",
	ruff = "ruff",
	html = "vscode-html-language-server",
	cssls = "vscode-css-language-server",
	tailwindcss = "tailwindcss-language-server",
	ts_ls = "typescript-language-server",
	svelte = "svelteserver",
	rust_analyzer = "rust-analyzer",
	gopls = "gopls",
	clangd = "clangd",
	nixd = "nixd",
	sourcekit = "sourcekit-lsp",
	zls = "zls",
}

-- Define the servers to be setup.
local servers = {
	bashls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
						vim.fn.stdpath("config") .. "/lua",
						"${3rd}/luv/library",
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	},
	pyright = {},
	ruff = {},
	html = {},
	cssls = {},
	tailwindcss = {},
	ts_ls = {
		settings = {
			separate_diagnostic_server = true,
			public_diagnostic_on = "insert_leave",
			tsserver_plugins = {},
		},
	},
	-- svelte = {},
	-- rust_analyzer = {},
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = { unusedparams = true },
			},
		},
	},
	-- clangd = {
	-- 	cmd = {
	-- 		"clangd",
	-- 		"--fallback-style=webkit",
	-- 	},
	-- },
	nixd = {
		cmd = { "nixd" },
		settings = {
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
		},
	},
	-- zls = {
	-- 	settings = {
	-- 		zls = {
	-- 			inlay_hints_show_variable_type_hints = false,
	-- 			inlay_hints_show_struct_literal_field_type = false,
	-- 			inlay_hints_show_parameter_name = false,
	-- 			inlay_hints_show_builtin = false,
	-- 			inlay_hints_hide_redundant_param_names = true,
	-- 			inlay_hints_hide_redundant_param_names_last_token = true,
	-- 		},
	-- 	},
	-- },
}

-- Svelte LSP doesn't watch for changes in .ts or .js files. This autocmd notifies the LSP when those
-- files are updated.
local custom_on_attach = {
	svelte = function(client)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			group = vim.api.nvim_create_augroup("UserSvelteTsJsNotify", { clear = true }),
			callback = function(ctx)
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})
	end,
}

-- Set up each server.
for name, opts in pairs(servers) do
	-- Check that the server is installed.
	local cmd = server_cmd[name]
	if cmd and vim.fn.executable(cmd) ~= 1 then
		goto continue
	end

	-- Set up the server
	opts.on_init = on_init
	opts.capabilities = opts.capabilities or capabilities
	opts.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		if custom_on_attach[name] then
			custom_on_attach[name](client, bufnr)
		end
	end

	-- Enable the server
	local ok = pcall(vim.lsp.config, name, opts)
	if ok then
		pcall(vim.lsp.enable, name)
	end

	::continue::
end

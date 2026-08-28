local map = vim.keymap.set

-- Define the on_attach function which sets up key mappings for LSPs when they attach to a buffer.
local function on_attach(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", function()
		Snacks.picker.lsp_declarations()
	end, opts("Go to declaration"))
	map("n", "gd", function()
		Snacks.picker.lsp_definitions()
	end, opts("Go to definition"))
	map("n", "gi", function()
		Snacks.picker.lsp_implementations()
	end, opts("Go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))
	map("n", "<leader>D", function()
		Snacks.picker.lsp_type_definitions()
	end, opts("Go to type definition"))
	map("n", "<leader>ra", vim.lsp.buf.rename, opts("Rename symbol"))
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "gr", function()
		Snacks.picker.lsp_references()
	end, opts("Show references"))

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
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
	html = {},
	cssls = {},
	tailwindcss = {},
	nixd = {
		cmd = { "nixd" },
		settings = {
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
		},
	},
}

if vim.g.enable_zig_development ~= false then
	servers.zls = {
		settings = {
			zls = {
				inlay_hints_show_variable_type_hints = false,
				inlay_hints_show_struct_literal_field_type = false,
				inlay_hints_show_parameter_name = false,
				inlay_hints_show_builtin = false,
				inlay_hints_hide_redundant_param_names = true,
				inlay_hints_hide_redundant_param_names_last_token = true,
			},
		},
	}
end

if vim.g.enable_cpp_development ~= false then
	servers.clangd = {
		cmd = {
			"clangd",
			"--fallback-style=webkit",
		},
	}
end

if vim.g.enable_rust_development ~= false then
	servers.rust_analyzer = {}
end

if vim.g.enable_go_development ~= false then
	servers.gopls = {
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
	}
end

if vim.g.enable_python_development ~= false then
	servers.pyright = {}
	servers.ruff = {}
end

if vim.g.enable_typescript_development ~= false then
	servers.ts_ls = {
		settings = {
			separate_diagnostic_server = true,
			public_diagnostic_on = "insert_leave",
			tsserver_plugins = {},
		},
	}
end

if vim.g.enable_swift_development ~= false then
	servers.sourcekit = {
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift", "objective-c", "objective-cpp" },
		root_dir = vim.fs.root(0, { ".git", ".xcodeproj", ".xcworkspace" }),
	}
end

if vim.g.enable_chsarp_development ~= false then
	servers.roslyn_ls = {}
end

-- Svelte LSP doesn't watch for changes in .ts or .js files.
-- This autocmd notifies the LSP when those files are updated.
local custom_on_attach = {
	-- svelte = function(client)
	-- 	vim.api.nvim_create_autocmd("BufWritePost", {
	-- 		pattern = { "*.js", "*.ts" },
	-- 		group = vim.api.nvim_create_augroup("UserSvelteTsJsNotify", { clear = true }),
	-- 		callback = function(ctx)
	-- 			client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
	-- 		end,
	-- 	})
	-- end,
}

-- Set up each server.
for name, opts in pairs(servers) do
	opts.on_init = on_init
	opts.capabilities = opts.capabilities or capabilities
	opts.on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		-- If there is a custom on_attach for this server, then call it after the default.
		if custom_on_attach[name] then
			custom_on_attach[name](client, bufnr)
		end
	end

	pcall(vim.lsp.config, name, opts)
	pcall(vim.lsp.enable, name)
end

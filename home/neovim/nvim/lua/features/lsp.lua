local map = vim.keymap.set
local ok_util, util = pcall(require, "lspconfig.util")
if not ok_util then
  util = {
    root_pattern = function()
      return function()
        return nil
      end
    end,
  }
end

local function on_attach(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts "List workspace folders")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", vim.lsp.buf.rename, opts "Rename symbol")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

local function on_init(client)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink and blink.get_lsp_capabilities then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

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
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "config" .. "/lua",
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
  svelte = {},
  rust_analyzer = {},
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
  clangd = {
    cmd = {
      "clangd",
      "--fallback-style=webkit",
    },
  },
  nixd = {
    cmd = { "nixd" },
    settings = {
      nixpkgs = { expr = "import <nixpkgs> { }" },
      formatting = { command = { "nixfmt" } },
    },
  },
  sourcekit = {
    cmd = { "sourcekit-lsp" },
    filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
    root_dir = function(bufnr, on_dir)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      on_dir(
        util.root_pattern("buildServer.json", ".bsp")(filename)
          or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
          or util.root_pattern("compile_commands.json", "Package.swift")(filename)
          or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
      )
    end,
    get_language_id = function(_, ftype)
      local types = { objc = "objective-c", objcpp = "objective-cpp" }
      return types[ftype] or ftype
    end,
    capabilities = {
      workspace = {
        didChangeWatchedFiles = { dynamicRegistration = true },
      },
      textDocument = {
        diagnostic = {
          dynamicRegistration = true,
          relatedDocumentSupport = true,
        },
      },
    },
  },
  zls = {
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
  },
}

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

for name, opts in pairs(servers) do
  local cmd = server_cmd[name]
  if cmd and vim.fn.executable(cmd) ~= 1 then
    goto continue
  end

  opts.on_init = on_init
  opts.capabilities = opts.capabilities or capabilities
  opts.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    if custom_on_attach[name] then
      custom_on_attach[name](client, bufnr)
    end
  end

  local ok_config = pcall(vim.lsp.config, name, opts)
  if ok_config then
    pcall(vim.lsp.enable, name)
  end
  ::continue::
end

local lsp = require "configs.lsp"

local on_attach = lsp.on_attach
local on_init = lsp.on_init
local capabilities = lsp.capabilities

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
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
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

  rust_analyzer = {},

  ts_ls = {
    settings = {
      separate_diagnostic_server = true,
      public_diagnostic_on = "insert_leave",
      tsserver_plugins = {},
    },
  },

  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    -- root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
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
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
    },
  },

  svelte = {},

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

local custom_on_attaches = {
  svelte = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
      callback = function(ctx)
        -- Here use ctx.match instead of ctx.file
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end,
    })
  end,
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.capabilities = capabilities

  if custom_on_attaches[name] then
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      custom_on_attaches[name](client, bufnr)
    end
  else
    opts.on_attach = on_attach
  end

  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

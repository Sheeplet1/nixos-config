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
    root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
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

  -- clangd = {
  --   cmd = {
  --     "clangd",
  --     "--fallback-style=webkit",
  --   },
  -- },

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
  zls = {},
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  -- NOTE: No idea if I did this correct below
  -- opts.capabilities =
  --   vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(opts.capabilities))

  require("lspconfig")[name].setup(opts)
end

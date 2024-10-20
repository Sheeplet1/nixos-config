local nvlsp = require "nvchad.configs.lspconfig"

-- local nvchad_on_attach = nvlsp.on_attach
-- local on_attach = function(client, bufnr)
--   nvchad_on_attach(client, bufnr)
--   -- extend on_attach here
-- end

local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities

-- leaving this here incase I want to use this function again
-- local function organise_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = { vim.api.nvim_buf_get_name(0) },
--   }
--   vim.lsp.buf.execute_command(params)
-- end

local servers = {
  pyright = {},
  ruff = {},

  html = {},
  cssls = {},
  tailwindcss = {},

  eslint = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = require("lspconfig").util.root_pattern(
      ".eslintrc.js",
      ".eslintrc.json",
      ".eslintrc.yml",
      ".eslintrc.yaml",
      "package.json"
    ),
  },
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

  clangd = {
    cmd = {
      "clangd",
      "--fallback-style=webkit",
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  require("lspconfig")[name].setup(opts)
end

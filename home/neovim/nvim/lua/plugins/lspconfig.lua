return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function() return require "configs.mason" end,
    config = function(_, opts)
      if os.getenv "NIX_NEOVIM" ~= "1" then
        require("mason").setup(opts)
        vim.api.nvim_create_user_command("MasonInstallAll", function()
          if opts.ensure_installed and #opts.ensure_installed > 0 then
            vim.cmd "Mason"
            local mr = require "mason-registry"

            mr.refresh(function()
              for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then p:install() end
              end
            end)
          end
        end, {})

        vim.g.mason_binaries_list = opts.ensure_installed
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = { "saghen/blink.cmp" },
    -- dependencies = { "williamboman/mason.nvim" },
    -- opts = {
    --   setup = {
    --     clangd = function(_, opts)
    --       opts.capabilities.offsetEncoding = { "utf-16" }
    --     end,
    --   },
    -- },
    config = function()
      require("configs.lsp").defaults()
      require "configs.lspconfig"
    end,
  },
}

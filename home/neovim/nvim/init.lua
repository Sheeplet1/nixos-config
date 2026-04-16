-- Bootstrap entrypoint
-- The structure is intentionally split so manager/runtime concerns are isolated
-- from editor behavior (options/keymaps/autocmds) and language features.

-- Make this config self-contained even when launched via `-u <path>/init.lua`.
-- Without this, Lua `require("core.*")` resolution depends on APPNAME/runtimepath.
local init_file = debug.getinfo(1, "S").source:sub(2)
local config_dir = vim.fs.dirname(vim.fn.fnamemodify(init_file, ":p"))
vim.opt.rtp:prepend(config_dir)
package.path = table.concat({
	config_dir .. "/lua/?.lua",
	config_dir .. "/lua/?/init.lua",
	package.path,
}, ";")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Default to Nix/system-managed tools. Mason remains opt-in.
vim.g.use_mason = false

require("core.options")
require("core.autocmds")
require("plugins")
require("features.diagnostics")
require("features.lsp")
require("features.ui")
require("core.keymaps")

-- column border of 80
vim.opt.colorcolumn = "80"

vim.g.have_nerd_font = true

-- enable mouse support
vim.opt.mouse = "a"

-- relative numbers
vim.opt.relativenumber = true

-- sync clipboard between OS and Neovim
-- vim.schedule(function()
vim.opt.clipboard = "unnamedplus"
-- end)

-- enable break indent
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true

-- decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- set terminal gui colors to true
vim.o.termguicolors = true

-- minimum number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

local SPACES = 4
vim.o.tabstop = SPACES -- TAB looks like x SPACES
vim.o.expandtab = true -- use spaces instead of TABs
vim.o.softtabstop = SPACES -- Number of spaces inserted instead of a TAB
vim.o.shiftwidth = SPACES -- Number of spaces when indenting

-- stop swapfile
vim.o.swapfile = false
vim.o.backup = false

-- no need, we have lualine
vim.o.laststatus = 3
vim.o.showmode = false

-- enable sign column
vim.o.signcolumn = "yes"

-- split columns
vim.o.splitright = true
vim.o.splitbelow = true

-- go to the previous/next line when using h/l when the cursor reaches the end
-- of the line
vim.opt.whichwrap:append "<>[]hl"

-- disable some previous providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- numbers
vim.o.ruler = false
vim.o.number = true
vim.o.numberwidth = 2

-- disable neovim intro
vim.opt.shortmess:append "sI"

--------------------------------------------------------------------------------
-- Keybindings for saving and quitting (typos)
vim.cmd [[command! W w]]
vim.cmd [[command! Q q]]
vim.cmd [[command! Wq wq]]
vim.cmd [[command! WQ wq]]
vim.cmd [[command! Qa qa]]
vim.cmd [[command! QA qa]]

-- add binaries installed by mason.nvim to path (not needed on nixos)
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
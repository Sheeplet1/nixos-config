vim.g.omni_sql_default_compl_type = "syntax"
vim.g.have_nerd_font = true
vim.g.zig_fmt_parse_errors = 0

-- General
vim.opt.autoread = true
vim.opt.textwidth = 100
vim.opt.colorcolumn = "100"
vim.opt.mouse = "a"
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.ruler = false
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<>[]hl")

local spaces = 4
vim.opt.tabstop = spaces
vim.opt.softtabstop = spaces
vim.opt.shiftwidth = spaces
vim.opt.expandtab = true

-- Fix typos
vim.cmd([[command! W w]])
vim.cmd([[command! Q q]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Qa qa]])
vim.cmd([[command! QA qa]])

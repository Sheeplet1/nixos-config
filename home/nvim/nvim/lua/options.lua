require "nvchad.options"

-- column border of 80
vim.opt.colorcolumn = "80"

vim.g.have_nerd_font = true

-- enable mouse support
vim.opt.mouse = "a"

-- relative numbers
vim.opt.relativenumber = true

-- sync clipboard between OS and neovim
vim.o.clipboard = "unnamedplus"

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

-- local SPACES = 4
vim.o.tabstop = 4 -- TAB looks like x SPACES
vim.o.expandtab = true -- use spaces instead of TABs
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB
vim.o.shiftwidth = 4 -- Number of spaces when indenting

-- stop swapfile
vim.o.swapfile = false
vim.o.backup = false

---------------------------- Highlight yanked group ----------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

--------------------------------------------------------------------------------
-- Keybindings for saving and quitting (typos)
vim.cmd [[command! W w]]
vim.cmd [[command! Q q]]
vim.cmd [[command! Wq wq]]
vim.cmd [[command! WQ wq]]
vim.cmd [[command! Qa qa]]
vim.cmd [[command! QA qa]]

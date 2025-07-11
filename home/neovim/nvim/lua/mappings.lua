local map = vim.keymap.set

map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "<leader>p", '<cmd>"_dp<CR>', { desc = "Replace without yanking" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank into system clipboard" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save file and quit" })
map("n", "<leader>q", ":q!<CR>", { desc = "Quit file without saving" })

map("n", "n", "nzzzv", { desc = "Search terms stay centred" })
map("n", "N", "Nzzzv", { desc = "Search terms stay centred" })
map("n", "<C-d>", "<C-d>zz", { desc = "Centre screen while half page jumping" })
map("n", "<C-u>", "<C-u>zz", { desc = "Centre screen while half page jumping" })
map("n", "<S-}>", "<S-}>zzzv", { desc = "Move to the next paragraph and center" })
map("n", "<S-{", "<S-{>zzzv", { desc = "Move to the prev paragraph and center" })

map("n", "Y", "y$", { desc = "Yank till the end of the line" })
map("n", "D", "d$", { desc = "Delete till the end of the line" })
map("n", "C", "c$", { desc = "Change till the end of the line" })
map("n", "H", "0", { desc = "Go to the start of the line" })
map("n", "L", "$", { desc = "Go to the end of the line" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- mappings to create header blocks/lines
map(
  "n",
  "<leader>cb",
  ":center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.",
  { desc = "Create centered comment header block" }
)
map(
  "n",
  "<leader>cl",
  ":center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>",
  { desc = "Create centered comment header line" }
)

-- resizing windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

map(
  "n",
  "<leader>lf",
  function() vim.diagnostic.open_float(nil, { border = "rounded" }) end,
  { desc = "Open diagnostic" }
)

-- NvChad UI keybinds
map("n", "<Tab>", function() require("nvchad.tabufline").next() end, { desc = "Go to the next buffer" })
map("n", "<S-Tab>", function() require("nvchad.tabufline").prev() end, { desc = "Go to the prev buffer" })
map("n", "<leader>x", function() require("nvchad.tabufline").close_buffer() end, { desc = "Close buffer" })
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
map("n", "<leader>th", function() require("nvchad.themes").open() end, { desc = "Telescope nvchad themes" })

-- Remap commenting buttons to be similar to Comment.nvim
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- maps <Alt+i> keys to change buffers
for i = 1, 9, 1 do
  map("n", string.format("<A-%s>", i), function() vim.api.nvim_set_current_buf(vim.t.bufs[i]) end)
end

-- Harppon
local harpoon = require "harpoon"
harpoon:setup()
map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to Harpoon" })
map("n", "<A-h>", function() harpoon:list():select(1) end, { desc = "Open first Harpoon file" })
map("n", "<A-j>", function() harpoon:list():select(2) end, { desc = "Open second Harpoon file" })
map("n", "<A-k>", function() harpoon:list():select(3) end, { desc = "Open third Harpoon file" })
map("n", "<A-l>", function() harpoon:list():select(4) end, { desc = "Open fourth Harpoon file" })
map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Go to next Harpoon file" })
map("n", "<leader>hN", function() harpoon:list():prev() end, { desc = "Go to prev Harpoon file" })

local map = vim.keymap.set

map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "<leader>p", '"_dp', { desc = "Replace without yanking" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank into system clipboard" })

map("n", ";", ":", { desc = "Enter command mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })

map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up centered" })
map("n", "<S-}>", "<S-}>zzzv", { desc = "Next paragraph centered" })
map("n", "<S-{", "<S-{>zzzv", { desc = "Previous paragraph centered" })

map("n", "Y", "y$", { desc = "Yank to end of line" })
map("n", "D", "d$", { desc = "Delete to end of line" })
map("n", "C", "c$", { desc = "Change to end of line" })
map("n", "H", "0", { desc = "Start of line" })
map("n", "L", "$", { desc = "End of line" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Centered comment header mappings
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

-- Window resizing
map("n", "<A-h>", require("smart-splits").resize_left)
map("n", "<A-j>", require("smart-splits").resize_down)
map("n", "<A-k>", require("smart-splits").resize_up)
map("n", "<A-l>", require("smart-splits").resize_right)

-- Open floating diagnostics
map("n", "<leader>lf", function()
	vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Open diagnostics float" })

-- Split navigation
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Comment mapping
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Native buffer selector equivalent to your old vim.t.bufs behavior.
for i = 1, 9, 1 do
	map("n", string.format("<A-%s>", i), function()
		local listed = vim.fn.getbufinfo({ buflisted = 1 })
		if listed[i] then
			vim.api.nvim_set_current_buf(listed[i].bufnr)
		end
	end, { desc = string.format("Go to buffer %s", i) })
end

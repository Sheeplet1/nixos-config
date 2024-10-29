require "nvchad.mappings"

local map = vim.keymap.set

local mappings = {
  n = {
    -- disabled
    ["<leader>h"] = { "", "" },

    [";"] = { ":", "CMD enter command mode" },

    ["<leader>d"] = { '<cmd>"_d', "Delete without yank" },
    ["<leader>p"] = { '<cmd>"_dp', "Replace without yank" },

    ["n"] = { "nzzzv", "Search terms stay centred" },
    ["N"] = { "Nzzzv", "Search terms stay centred" },

    ["<C-d>"] = { "<C-d>zz", "Centre screen while half page jumping" },
    ["<C-u>"] = { "<C-u>zz", "Centre screen while half page jumping" },

    ["S-}"] = { "<S-}>zzzv", "Move to the next paragraph and center" },
    ["S-{"] = { "<S-{>zzzv", "Move to the prev paragraph and center" },

    ["<leader>y"] = { '"+y', "Yank into system clipboard" },
    ["<leader>w"] = { ":w<CR>", "Save file" },
    ["<leader>wq"] = { ":wq<CR>", "Save file and quit" },
    ["<leader>q"] = { ":q!<CR>", "Quit file without saving" },

    ["Y"] = { "y$", "Yank till the end of the line" },
    ["D"] = { "d$", "Delete till the end of the line" },
    ["C"] = { "c$", "Change till the end of the line" },
    ["H"] = { "0", "Go to the start of the line" },
    ["L"] = { "$", "Go to the end of the line" },

    ["<leader>cb"] = {
      ":center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.",
      "Create centered comment header block",
    },
    ["<leader>cl"] = {
      ":center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>",
      "Create centered comment header line",
    },

    ["<C-Up>"] = {
      "<cmd>resize +2<CR>",
      "Increase window height",
    },
    ["<C-Down>"] = {
      "<cmd>resize -2<CR>",
      "Decrease window height",
    },
    ["<C-Left>"] = {
      "<cmd>vertical resize +2<CR>",
      "Increase window width",
    },
    ["<C-Right>"] = {
      "<cmd>vertical resize -2<CR>",
      "Decrease window width",
    },

    ----------------------------------- dap ------------------------------------
    ["<leader>db"] = {
      function()
        require("lua.configs.nvim-dap").toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    ["<leader>dr"] = { "<cmd> DapContinue<CR>", "Run or continue the debugger" },
    ["<leader>dsi"] = {
      function()
        require("lua.configs.nvim-dap").step_into()
      end,
      "Step into function",
    },
    ["<leader>dso"] = {
      function()
        require("lua.configs.nvim-dap").step_over()
      end,
      "Step over function",
    },
    ["<leader>dsO"] = {
      function()
        require("lua.configs.nvim-dap").step_out()
      end,
      "Step out of function",
    },

    ----------------------------------------------------------------------------

    ["<leader>fu"] = { "<cmd>Telescope undo<CR>", "Open undotree" },
    -- ["<C-n>"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" },

    ["<leader>gg"] = { "<cmd>LazyGit<CR>", "Open LazyGit" },

    ["<leader>zm"] = { "<cmd>ZenMode<CR>", "ZenMode" },

    ["<leader>md"] = { "<cmd>MarkdownPreview<CR>", "Markdown Preview" },

    ["<leader>tt"] = { "<cmd>TroubleToggle<CR>", "TodoTrouble" },

    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Navigate left tmux pane" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Navigate down tmux pane" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Navigate up tmux pane" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Navigate right tmux pane" },

    ["<C-n>"] = { "<cmd>Oil --float<CR>", "Open Oil" },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float(nil, { border = "rounded" })
      end,
      "Open diagnostic",
    },
  },

  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move the selected lines down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move the selected lines up" },
    ["<leader>y"] = { '"+y', "Yank into system clipboard" },
    ["<leader>d"] = { '<cmd> "_d', "Delete without yanking" },
  },

  i = {},
}

----------------------------------- harpoon ------------------------------------

-- local harpoon = require "harpoon"
-- harpoon:setup()
--
-- map("n", "<leader>h", function()
--   harpoon.ui:toggle_quick_menu(harpoon:list())
-- end, { desc = "Harpoon Menu" })
--
-- map("n", "<leader>a", function()
--   harpoon:list():add()
-- end, { desc = "Add to Harpoon" })
--
-- map("n", "<A-h>", function()
--   harpoon:list():select(1)
-- end, { desc = "Open first Harpoon file" })
--
-- map("n", "<A-j>", function()
--   harpoon:list():select(2)
-- end, { desc = "Open second Harpoon file" })
--
-- map("n", "<A-k>", function()
--   harpoon:list():select(3)
-- end, { desc = "Open third Harpoon file" })
--
-- map("n", "<A-l>", function()
--   harpoon:list():select(4)
-- end, { desc = "Open fourth Harpoon file" })
--
-- map("n", "<leader>hn", function()
--   harpoon:list():next()
-- end, { desc = "Go to next Harpoon file" })
--
-- map("n", "<leader>hN", function()
--   harpoon:list():prev()
-- end, { desc = "Go to prev Harpoon file" })

-------------------------------------- - ---------------------------------------
for mode, maps in pairs(mappings) do
  for key, val in pairs(maps) do
    map(mode, key, val[1], { desc = val[2] })
  end
end

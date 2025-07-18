local ENABLED = false
if not ENABLED then return {} end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.50,
            results_width = 0.8,
          },
          vertical = {
            mirror = true,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "__pycache__",
          "%.pdf",
          "%.webp",
          "%.png",
          "%.jpg",
          "%.xlsx",
          "%.odt",
          "%.db",
          "%.mod",
          "%.sum",
          "%.lock",
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
          i = { ["<ESC>"] = require("telescope.actions").close },
        },
      },
      extensions_list = { "themes", "terms" },
      extensions = {},
    },
    keys = {
      {
        "<Leader>ff",
        require("telescope.builtin").find_files,
        desc = "[f]ind [f]iles (Telescope)",
      },
      {
        "<Leader>fw",
        require("telescope.builtin").live_grep,
        desc = "[l]ive [g]rep (Telescope)",
      },
      {
        "<Leader>fb",
        require("telescope.builtin").buffers,
        desc = "[f]ind [b]uffers (Telescope)",
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  -- pretty ui for code-actions mainly
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function() require("telescope").load_extension "ui-select" end,
  },
  -- undo tree
  {
    "debugloop/telescope-undo.nvim",
    event = "VeryLazy",
    config = function() require("telescope").load_extension "undo" end,
  },
}

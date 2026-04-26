local M = {}

local function gh(repo, spec)
	local plugin = spec or {}
	plugin.src = "https://github.com/" .. repo
	plugin.name = plugin.name or repo:match("/([^/]+)$")
	return plugin
end

function M.list()
	-- Define list of plugins here
	local specs = {
		gh("nvim-lua/plenary.nvim"),
		gh("sainnhe/everforest"),
		gh("saghen/blink.cmp"),
		gh("rafamadriz/friendly-snippets"),
		gh("nvim-treesitter/nvim-treesitter", { version = "main" }),
		gh("nvim-treesitter/nvim-treesitter-context"),
		gh("windwp/nvim-ts-autotag"),
		gh("JoosepAlviste/nvim-ts-context-commentstring"),
		gh("folke/snacks.nvim"),
		gh("lewis6991/gitsigns.nvim"),
		gh("stevearc/oil.nvim"),
		gh("nvim-tree/nvim-web-devicons"),
		gh("echasnovski/mini.move"),
		gh("echasnovski/mini.pairs"),
		gh("echasnovski/mini.tabline"),
		gh("nvim-mini/mini.indentscope"),
		gh("echasnovski/mini.statusline"),
		gh("kylechui/nvim-surround"),
		gh("folke/which-key.nvim"),
		gh("stevearc/conform.nvim"),
		gh("mfussenegger/nvim-lint"),
		gh("zbirenbaum/copilot.lua"),
		gh("kdheepak/lazygit.nvim"),
		gh("ThePrimeagen/harpoon", { version = "harpoon2" }),
		gh("ray-x/guihua.lua"),
		gh("ray-x/go.nvim"),
		gh("iamcco/markdown-preview.nvim"),
		gh("MunifTanjim/nui.nvim"),
		gh("nvim-tree/nvim-tree.lua"),
		gh("folke/todo-comments.nvim"),
		gh("lukas-reineke/indent-blankline.nvim"),
		gh("christoomey/vim-tmux-navigator"),
		gh("tpope/vim-sleuth"),
		gh("neovim/nvim-lspconfig"),
	}

	if vim.g.use_mason then
		table.insert(specs, gh("williamboman/mason.nvim"))
	end

	return specs
end

return M

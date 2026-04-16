local blink = require("blink.cmp")

blink.setup({
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		ghost_text = { enabled = false },
		menu = {
			border = "rounded",
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline"
			end,
		},
		documentation = {
			window = {
				min_width = 15,
				max_width = 50,
				max_height = 15,
				border = "rounded",
			},
			auto_show = false,
			auto_show_delay_ms = 250,
		},
	},
	signature = {
		enabled = true,
		window = { show_documentation = false },
	},
	fuzzy = { implementation = "lua" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "omni" },
		providers = {
			lsp = {
				min_keyword_length = 2,
				score_offset = -1,
			},
		},
	},
})

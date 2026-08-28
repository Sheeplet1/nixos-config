vim.pack.add({ 'https://github.com/saghen/blink.lib' })
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })

local blink = require("blink.cmp")

local function accept_copilot_suggestion()
	-- Keep blink.cmp as the owner of <Tab>, but let Copilot consume the key when
	-- blink has nothing to do.  This mirrors LazyVim's ai_accept idea without
	-- depending on LazyVim's wrapper APIs.
	if vim.b.copilot_suggestion_hidden then
		return false
	end

	-- Copilot is optional at runtime: pcall keeps completion usable if Copilot is
	-- disabled, missing, or has not attached to the current buffer yet.
	local ok, suggestion = pcall(require, "copilot.suggestion")
	if not ok or not suggestion.is_visible or not suggestion.accept then
		return false
	end

	if not suggestion.is_visible() then
		return false
	end

	suggestion.accept()
	return true
end

local copilot_suggestion_group = vim.api.nvim_create_augroup("UserBlinkCopilotSuggestions", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = copilot_suggestion_group,
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		-- blink's menu is not Vim's native popup menu, so Copilot cannot infer
		-- that it should hide.  Dismissing avoids stale ghost text being accepted
		-- while <Tab> is being used to navigate completion items.
		local ok, suggestion = pcall(require, "copilot.suggestion")
		if ok and suggestion.dismiss then
			suggestion.dismiss()
		end

		vim.b.copilot_suggestion_hidden = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = copilot_suggestion_group,
	pattern = "BlinkCmpMenuClose",
	callback = function()
		-- Let Copilot render inline suggestions again once blink is no longer
		-- presenting a competing completion UI.
		vim.b.copilot_suggestion_hidden = false
	end,
})

blink.setup({
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", accept_copilot_suggestion, "fallback" },
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

-- mini.statusline
vim.pack.add({ "https://github.com/echasnovski/mini.statusline" })

local statusline = require("mini.statusline")

--- Displays the names of LSP clients attached to the current buffer.
---@param args { trunc_width: integer, icon?: string }
---@return string
local function lsp_client_names(args)
	if statusline.is_truncated(args.trunc_width) then
		return ""
	end

	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
	})

	if #clients == 0 then
		return ""
	end

	local names = vim.tbl_map(function(client)
		return client.name
	end, clients)

	table.sort(names)

	return string.format("%s %s", args.icon or "󰒋", table.concat(names, ", "))
end

--- Builds the active statusline with attached LSP clients on the right.
---@return string
local function active_content()
	local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
	local git = statusline.section_git({ trunc_width = 40 })
	local diff = statusline.section_diff({ trunc_width = 75 })
	local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
	local lsp = statusline.section_lsp({ trunc_width = 75 })
	local filename = statusline.section_filename({ trunc_width = 140 })
	local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
	local location = statusline.section_location({ trunc_width = 75 })
	local search = statusline.section_searchcount({ trunc_width = 75 })

	return statusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
		"%<",
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=",
		{ hl = "MiniStatuslineDevinfo", strings = { lsp } },
		{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		{ hl = mode_hl, strings = { search, location } },
	})
end

statusline.section_lsp = lsp_client_names
statusline.setup({
	content = {
		active = active_content,
	},
})

-- Load ts-context-commentstring for better commenting in embedded languages
vim.pack.add({ "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" })

local get_option = vim.filetype.get_option
local internal = require("ts_context_commentstring.internal")

-- This preserves behavior for embedded-language comment toggling
-- (e.g. Svelte/Vue script/style sections).
vim.filetype.get_option = function(filetype, option)
	if option == "commentstring" then
		return internal.calculate_commentstring()
	end

	return get_option(filetype, option)
end

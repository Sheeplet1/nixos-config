local get_option = vim.filetype.get_option
local internal = require("ts_context_commentstring.internal")

-- This preserves your old behavior for embedded-language comment toggling
-- (e.g. Svelte/Vue script/style sections).
vim.filetype.get_option = function(filetype, option)
	if option == "commentstring" then
		return internal.calculate_commentstring()
	end

	return get_option(filetype, option)
end

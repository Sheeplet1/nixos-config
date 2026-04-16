local spec = require("plugins.spec")

if vim.fn.executable("git") == 0 then
	vim.notify("git executable is required for vim.pack", vim.log.levels.ERROR)
	return
end

vim.pack.add(spec.list(), { confirm = false })

require("plugins.setup")

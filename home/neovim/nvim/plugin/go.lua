-- Only load Go development plugins when enabled
if vim.g.enable_go_development == false then
	return
end

-- Load go.nvim plugin for Go development
vim.pack.add({ "https://github.com/ray-x/go.nvim" })

-- Load guihua.lua dependency
vim.pack.add({ "https://github.com/ray-x/guihua.lua" })

require("go").setup()

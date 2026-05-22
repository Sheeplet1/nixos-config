-- Load nvim-lint for linting
vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

-- Only configure Swift linting if swiftlint is available
if vim.fn.executable("swiftlint") == 1 then
	lint.linters_by_ft = {
		swift = { "swiftlint" },
	}
else
	lint.linters_by_ft = {}
end

-- Auto-lint on various events
local lint_augroup = vim.api.nvim_create_augroup("UserLinting", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
	group = lint_augroup,
	callback = function()
		-- Don't lint Swift interface files
		if not vim.endswith(vim.fn.bufname(), "swiftinterface") then
			require("lint").try_lint()
		end
	end,
})

vim.keymap.set("n", "<leader>ml", function()
	require("lint").try_lint()
end, { desc = "Lint file" })

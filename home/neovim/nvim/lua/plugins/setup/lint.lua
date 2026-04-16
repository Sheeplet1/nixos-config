local lint = require("lint")

if vim.fn.executable("swiftlint") == 1 then
	lint.linters_by_ft = {
		swift = { "swiftlint" },
	}
else
	lint.linters_by_ft = {}
end

local lint_augroup = vim.api.nvim_create_augroup("UserLinting", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
	group = lint_augroup,
	callback = function()
		if not vim.endswith(vim.fn.bufname(), "swiftinterface") then
			require("lint").try_lint()
		end
	end,
})

vim.keymap.set("n", "<leader>ml", function()
	require("lint").try_lint()
end, { desc = "Lint file" })

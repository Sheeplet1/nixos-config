local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

return {
  -- sets the `commentstring` option based on the cursor location of the
  -- file instead of by filetype. Helpful for embedded languages in certain
  -- file types like Svelte/Vue.
  "JoosepAlviste/nvim-ts-context-commentstring",
  opts = {
    enable_autocmd = false,
  },
}

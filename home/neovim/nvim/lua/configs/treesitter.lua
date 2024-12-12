pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "regex",
    "rust",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    -- "cpp",
  },

  auto_install = true,

  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == "html" then
        print "disabled"
        return true
      end

      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        vim.notify(
          "File larger than 100KB treesitter disabled for performance",
          vim.log.levels.WARN,
          { title = "Treesitter" }
        )
        return true
      end
    end,
    use_languagetree = true,
  },

  -- indent = { enable = true },
}

return options

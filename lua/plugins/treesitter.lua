local languages = {
  "lua",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "ruby",
  "python",
  "sql",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "c",
  "cpp",
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
  "query",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(languages)
    -- The main branch doesn't turn on highlighting or indent by itself anymore.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      callback = function(event)
        if not pcall(vim.treesitter.start, event.buf) then
          return
        end
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- Treesitter indent is flaky for Python.
        if vim.bo[event.buf].filetype ~= "python" then
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

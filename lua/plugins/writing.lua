return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    opts = {},
  },
  {
    "lervag/vimtex",
    lazy = false, -- VimTeX's docs say not to lazy-load it
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_syntax_conceal = { bold = 1, italic = 1, math_symbols = 1 }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },
}

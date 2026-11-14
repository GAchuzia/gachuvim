return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      options = {
        theme = "catppuccin-nvim", -- renamed upstream in catppuccin#979
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
      },
    },
  },
}

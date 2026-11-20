return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Listed instead of auto-detected: detection calls vim.pack, which leaves an empty
      -- site/pack/core folder that lazy.nvim's health check warns about.
      require("catppuccin").setup({
        auto_integrations = false,
        integrations = {
          alpha = true,
          blink_cmp = { enabled = true },
          dap = true,
          dap_ui = true,
          gitsigns = true,
          mason = true,
          mini = { enabled = true },
          telescope = true,
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

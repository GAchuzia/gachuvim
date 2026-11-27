return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "git hunks" },
      { "<leader>p", group = "plugins / tools" },
      { "<leader>t", group = "terminal / tests" },
      { "<leader>u", group = "ui" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>y", group = "copy path" },
    },
  },
}

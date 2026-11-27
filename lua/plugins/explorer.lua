return {
  {
    "stevearc/oil.nvim",
    -- Not lazy, so it takes over from netrw before `nvim <dir>` opens.
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<C-n>", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = { show_hidden = true },
      -- Oil's <C-p> (preview) shadowed find files, and <C-h>/<C-l> (split, refresh)
      -- shadowed window moves. Use :e to refresh.
      keymaps = { ["<C-p>"] = false, ["<C-h>"] = false, ["<C-l>"] = false },
    },
  },
}

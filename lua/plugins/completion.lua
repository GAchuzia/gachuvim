return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      -- <C-k> is for digraphs, and Neovim already has <C-s> for signature help.
      keymap = { preset = "default", ["<C-k>"] = false },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        list = { selection = { preselect = false, auto_insert = false } },
      },
      sources = { default = { "lsp", "path", "buffer" } },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}

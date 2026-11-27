return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.config("sqls", { root_markers = { ".git" } })
      -- Drop filetypes Neovim never sets (c.doxygen, cpp.doxygen, gotmpl).
      vim.lsp.config("clangd", { filetypes = { "c", "cpp", "objc", "objcpp", "cuda" } })
      vim.lsp.config("gopls", { filetypes = { "go", "gomod", "gowork" } })
      -- Not from Mason. Mason's ruby-lsp is stuck on the Ruby it was installed with, and some
      -- projects need their own Ruby to read Gemfile.lock. Install it with `gem install ruby-lsp`
      -- using the project's Ruby.
      vim.lsp.enable("ruby_lsp")
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "pyright",
          "sqls",
          "gopls",
          "clangd",
        },
        automatic_enable = true,
      })
    end,
  },
}

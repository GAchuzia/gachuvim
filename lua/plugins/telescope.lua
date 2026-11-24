-- Excluded once, by rg, so it never walks these directories at all.
local ignore_dirs = { ".git", "node_modules", "dist", "build", "vendor" }

local ignore_globs = {}
for _, dir in ipairs(ignore_dirs) do
  table.insert(ignore_globs, "--glob")
  table.insert(ignore_globs, "!**/" .. dir .. "/*")
end

-- Skip non-English translation and locale files. In large monorepos they are about half of
-- all files, and opening each file is most of rg's time. en.json and en.yml stay searchable.
for _, dir in ipairs({ "translations", "locales" }) do
  for _, name in ipairs({ "[!e]*", "e[!n]*", "en?*" }) do
    for _, ext in ipairs({ "json", "yml" }) do
      table.insert(ignore_globs, "--glob")
      table.insert(ignore_globs, "!**/" .. dir .. "/**/" .. name .. "." .. ext)
    end
  end
end

-- Neovim's default :grep uses rg -uu, which ignores .gitignore. Use the same filters instead.
vim.o.grepprg = "rg --vimgrep --smart-case --hidden "
  .. table.concat(vim.tbl_map(vim.fn.shellescape, ignore_globs), " ")

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search project text" },
      {
        "<leader>fG",
        function()
          -- Nearest component, then zone, then repo. Much faster than the whole monorepo.
          local root = vim.fs.root(0, { "component.yml", "dev.yml", ".git" })
          require("telescope.builtin").live_grep({ cwd = root })
        end,
        desc = "Search text in this component",
      },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
      { "<leader>fs", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
      { "<leader>xx", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          width = 0.95,
          height = 0.9,
          flex = { flip_columns = 120 },
          horizontal = { preview_width = 0.55, preview_cutoff = 0 },
          vertical = { preview_height = 0.45, preview_cutoff = 0 },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          unpack(ignore_globs),
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- Use Telescope's fallback if rg is missing.
          find_command = vim.fn.executable("rg") == 1
              and { "rg", "--files", "--hidden", unpack(ignore_globs) }
            or nil,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },
}

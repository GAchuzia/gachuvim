-- Excluded once, by rg, so it never walks these directories at all.
local ignore_globs = { "**/.git/*", "**/node_modules/*", "**/dist/*", "**/build/*", "**/vendor/*" }

-- Skip non-English translation and locale files. In large monorepos they are about half of
-- all files, and opening each file is most of rg's time. en.json and en.yml stay searchable.
for _, dir in ipairs({ "translations", "locales" }) do
  for _, name in ipairs({ "[!e]*", "e[!n]*", "en?*" }) do
    for _, ext in ipairs({ "json", "yml" }) do
      table.insert(ignore_globs, "**/" .. dir .. "/**/" .. name .. "." .. ext)
    end
  end
end

-- Neovim's default :grep uses rg -uu, which ignores .gitignore. Use the same filters instead.
vim.o.grepprg = "rg --vimgrep --smart-case --hidden "
  .. table.concat(
    vim.tbl_map(function(glob)
      return "--glob " .. vim.fn.shellescape("!" .. glob)
    end, ignore_globs),
    " "
  )

-- Nearest component, then zone, then repo. Grep here is much faster than across the monorepo.
local function component_root()
  return vim.fs.root(0, { "component.yml", "dev.yml", ".git" })
end

local function pick(source, opts)
  return function()
    Snacks.picker[source](opts and opts() or nil)
  end
end

local function in_component()
  return { cwd = component_root() }
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<C-p>", pick("files"), desc = "Find files" },
      { "<leader>ff", pick("files"), desc = "Find files" },
      { "<leader>fg", pick("grep", in_component), desc = "Search text in this component" },
      { "<leader>fG", pick("grep"), desc = "Search project text" },
      {
        "<leader>fw",
        pick("grep_word", in_component),
        desc = "Search word in this component",
        mode = { "n", "x" },
      },
      { "<leader>fW", pick("grep_word"), desc = "Search word in project", mode = { "n", "x" } },
      { "<leader>fb", pick("buffers"), desc = "Find buffers" },
      { "<leader>fr", pick("recent"), desc = "Recent files" },
      { "<leader>fh", pick("help"), desc = "Search help" },
      { "<leader>fk", pick("keymaps"), desc = "Search keymaps" },
      { "<leader>fs", pick("resume"), desc = "Resume last search" },
      { "<leader>ut", pick("colorschemes"), desc = "Toggle theme (live preview)" },
      { "<leader>xx", pick("diagnostics"), desc = "Workspace diagnostics" },
    },
    opts = {
      picker = {
        sources = {
          -- rg, not fd, so files and grep skip exactly the same paths.
          files = { cmd = "rg", hidden = true, exclude = ignore_globs },
          grep = { hidden = true, exclude = ignore_globs },
          grep_word = { hidden = true, exclude = ignore_globs },
        },
      },
    },
  },
}

-- rg skips these dirs entirely.
local ignore_globs = { "**/.git/*", "**/node_modules/*", "**/dist/*", "**/build/*", "**/vendor/*" }

-- Skip non-English translation and locale files. They're about half the files in a big
-- monorepo, and opening them is most of rg's time. en.json and en.yml still get searched.
for _, dir in ipairs({ "translations", "locales" }) do
  for _, name in ipairs({ "[!e]*", "e[!n]*", "en?*" }) do
    for _, ext in ipairs({ "json", "yml" }) do
      table.insert(ignore_globs, "**/" .. dir .. "/**/" .. name .. "." .. ext)
    end
  end
end

-- Default :grep runs rg -uu, which ignores .gitignore. Use the same filters as the picker.
vim.o.grepprg = "rg --vimgrep --smart-case --hidden "
  .. table.concat(
    vim.tbl_map(function(glob)
      return "--glob " .. vim.fn.shellescape("!" .. glob)
    end, ignore_globs),
    " "
  )

-- Closest dir with a component.yml, dev.yml or .git. Way faster to grep than the whole monorepo.
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
          -- rg for files too, so it skips the same paths as grep.
          files = { cmd = "rg", hidden = true, exclude = ignore_globs },
          grep = { hidden = true, exclude = ignore_globs },
          grep_word = { hidden = true, exclude = ignore_globs },
        },
      },
    },
  },
}

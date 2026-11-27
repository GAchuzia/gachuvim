-- config.options sets the leader keys, so it has to load before the plugins.
if vim.fn.has("nvim-0.12") == 0 then
  error("Use Neovim 0.12 or later. nvim-treesitter's main branch requires it.")
end

require("config.options")
require("config.keymaps")
require("config.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim. Check Git/network access:\n" .. result)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  rocks = { enabled = false },
  change_detection = { notify = false },
})

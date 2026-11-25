-- Theme collection + live toggling.
--
-- Browse/preview with <leader>ut (Telescope colorscheme, live preview).
-- Your choice is remembered across restarts.
--
-- To add a theme: drop another spec in the list below, then run :Lazy sync.
-- The string you pass to :colorscheme is shown in parentheses.

local persist_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

local function save_colorscheme(name)
  pcall(vim.fn.writefile, { name }, persist_file)
end

local function read_colorscheme()
  local ok, lines = pcall(vim.fn.readfile, persist_file)
  if ok and lines and lines[1] and lines[1] ~= "" then
    return lines[1]
  end
  return "catppuccin" -- default on first launch
end

-- Remember whatever colorscheme ends up applied (Telescope reverts on cancel,
-- so the final saved value matches what you actually selected). The `ready`
-- flag prevents transient startup/default schemes (e.g. habamax) from being
-- persisted before our saved theme has been applied.
local ready = false
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
  callback = function(args)
    if ready then
      save_colorscheme(args.match)
    end
  end,
})

-- Apply the saved colorscheme once all start plugins (themes) have loaded.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    pcall(vim.cmd.colorscheme, read_colorscheme())
    ready = true
  end,
})

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

  -- Additional themes for live toggling (<leader>ut). Add/remove freely.
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 }, -- tokyonight, tokyonight-night/storm/moon/day
  { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 }, -- rose-pine, rose-pine-moon/dawn
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 }, -- gruvbox
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 }, -- kanagawa, kanagawa-wave/dragon/lotus
  { "sainnhe/everforest", lazy = false, priority = 1000 }, -- everforest
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 }, -- nightfox, dayfox, duskfox, nordfox, carbonfox
}

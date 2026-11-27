-- Themes. <leader>ut opens a picker with live preview, and the pick sticks across restarts.
-- To add one, add a spec at the bottom and run :Lazy sync.
-- The comment after each spec lists its :colorscheme names.

local persist_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

local function save_colorscheme(name)
  pcall(vim.fn.writefile, { name }, persist_file)
end

local function read_colorscheme()
  local ok, lines = pcall(vim.fn.readfile, persist_file)
  if ok and lines and lines[1] and lines[1] ~= "" then
    return lines[1]
  end
  return "catppuccin" -- first launch
end

-- Save whatever theme ends up applied. The picker reverts on cancel, so the last
-- save is the theme you picked. `ready` stops startup themes (like habamax) from
-- being saved before ours loads.
local ready = false
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
  callback = function(args)
    if ready then
      save_colorscheme(args.match)
    end
  end,
})

-- Load the saved theme once all the theme plugins are in.
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
      -- Integrations listed by hand. Auto-detect calls vim.pack, which leaves an empty
      -- site/pack/core dir that lazy's health check complains about.
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
          snacks = { enabled = true },
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- More themes for <leader>ut.
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 }, -- tokyonight, tokyonight-night/storm/moon/day
  { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 }, -- rose-pine, rose-pine-moon/dawn
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 }, -- gruvbox
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 }, -- kanagawa, kanagawa-wave/dragon/lotus
  { "sainnhe/everforest", lazy = false, priority = 1000 }, -- everforest
  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 }, -- nightfox, dayfox, duskfox, nordfox, carbonfox
}

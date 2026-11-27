return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = { "nvim-mini/mini.icons", "nvim-lua/plenary.nvim", "amansingh-afk/milli.nvim" },
  opts = { theme = "startify" },
  config = function(_, opts)
    local alpha = require("alpha")
    local splash = { splash = "blackhole", loop = true }
    -- milli animates over the header, so the header starts as the splash's first frame.
    local splash_header = require("milli").load(splash).frames[1]
    local names = { "dashboard", "startify", "theta" }
    local descriptions = {
      dashboard = "Centered banner and shortcuts",
      startify = "Compact layout with recent files",
      theta = "Centered banner, recent files, and shortcuts",
    }

    local function configure(name)
      local theme = require("alpha.themes." .. name)
      local header = name == "theta" and theme.header or theme.section.header
      header.val = splash_header
      local button = theme.button or require("alpha.themes.dashboard").button
      local buttons = {
        button("e", "New file", "<cmd>enew<cr>"),
        button("f", "Find files", "<cmd>lua Snacks.picker.files()<cr>"),
        button("r", "Recent files", "<cmd>lua Snacks.picker.recent()<cr>"),
        button("s", "Search text", "<cmd>lua Snacks.picker.grep()<cr>"),
        button("d", "Choose layout", "<cmd>Dashboard<cr>"),
        button("q", "Quit", "<cmd>qa<cr>"),
      }
      if name == "startify" then
        theme.section.bottom_buttons.val = { table.remove(buttons) }
        theme.section.top_buttons.val = buttons
      elseif name == "theta" then
        theme.buttons.val = buttons
      else
        theme.section.buttons.val = buttons
      end
      theme.config.opts.autostart = #vim.api.nvim_list_uis() > 0
      alpha.setup(theme.config)
    end

    local function preview(name)
      if not name then
        return
      end
      if not vim.tbl_contains(names, name) then
        return vim.notify("Choose dashboard, startify, or theta.", vim.log.levels.WARN)
      end
      if vim.bo.filetype == "alpha" then
        vim.cmd.Alpha()
      end
      configure(name)
      alpha.start(false)
    end

    configure(opts.theme)
    require("milli").alpha(splash)
    vim.api.nvim_create_user_command("Dashboard", function(args)
      if args.args ~= "" then
        preview(args.args)
      else
        vim.ui.select(names, {
          prompt = "Dashboard layout:",
          format_item = function(name)
            return name .. " — " .. descriptions[name]
          end,
        }, preview)
      end
    end, {
      nargs = "?",
      complete = function()
        return names
      end,
      desc = "Choose a dashboard layout",
    })
  end,
}

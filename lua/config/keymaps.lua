local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save buffer" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>tt", "<cmd>botright 12split | terminal<cr>", { desc = "New terminal" })

-- Run `dev test` on this file, or just the test above the cursor, in a split.
local function run_test(nearest)
  local file = vim.fn.expand("%:p")
  local zone = vim.fs.root(0, "dev.yml")
  if file == "" or not zone then
    return vim.notify("Open a test file inside a dev zone first.", vim.log.levels.WARN)
  end
  local cmd = { "/opt/dev/bin/dev", "test", file }
  if nearest then
    local name
    for lnum = vim.fn.line("."), 1, -1 do
      local line = vim.fn.getline(lnum)
      -- `test "does a thing" do` defines test_does_a_thing.
      local declared = line:match([[^%s*test%s+["'](.+)["']%s+do]])
      name = declared and ("test_" .. declared:gsub("%s+", "_"))
        or line:match("^%s*def%s+(test_[%w_?!]+)")
      if name then
        break
      end
    end
    if not name then
      return vim.notify("No test above the cursor.", vim.log.levels.WARN)
    end
    vim.list_extend(cmd, { "-n", name })
  end
  vim.cmd("botright 15new")
  vim.fn.jobstart(cmd, { term = true, cwd = zone })
end
map("n", "<leader>tf", function()
  run_test(false)
end, { desc = "Test this file" })
map("n", "<leader>tn", function()
  run_test(true)
end, { desc = "Test the test under the cursor" })
map("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 0 then
    return vim.notify("Install lazygit and add it to PATH first.", vim.log.levels.WARN)
  end
  local root = vim.fs.root(vim.fn.getcwd(), ".git")
  if not root then
    return vim.notify("Use :cd to enter a Git repository first.", vim.log.levels.WARN)
  end
  vim.cmd.tabnew()
  local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  -- Pass Esc straight to LazyGit. Otherwise it waits to see if you're typing <Esc><Esc>.
  vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = buf, nowait = true })
  vim.fn.jobstart({ "lazygit" }, {
    term = true,
    cwd = root,
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
            pcall(vim.api.nvim_win_close, win, true)
          end
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end)
      end
    end,
  })
  vim.cmd.startinsert()
end, { desc = "Git dashboard (LazyGit)" })
map("n", "<leader>gw", function()
  local paths = {}
  for _, line in ipairs(vim.fn.systemlist({ "git", "worktree", "list", "--porcelain" })) do
    local path = line:match("^worktree (.+)")
    if path then
      table.insert(paths, path)
    end
  end
  if #paths == 0 then
    return vim.notify("Use :cd to enter a Git repository first.", vim.log.levels.WARN)
  end
  vim.ui.select(paths, { prompt = "Worktree" }, function(path)
    if path then
      vim.cmd.tcd(path)
    end
  end)
end, { desc = "Switch tab to worktree" })
local function copy_path(modifier, label)
  return function()
    local path = vim.fn.expand("%" .. modifier)
    if path == "" then
      return vim.notify("This buffer has no file.", vim.log.levels.WARN)
    end
    vim.fn.setreg("+", path)
    -- No path in the message. A long one wraps and triggers "Press ENTER".
    vim.notify("Copied " .. label)
  end
end
map("n", "<leader>yr", copy_path(":.", "relative path"), { desc = "Copy relative path" })
map("n", "<leader>yp", copy_path(":p", "absolute path"), { desc = "Copy absolute path" })
map("n", "<leader>yn", copy_path(":t", "file name"), { desc = "Copy file name" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down, centred" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up, centred" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontally" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move lines down", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move lines up", silent = true })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP health" })
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Buffer diagnostics list" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Manage language tools" })
map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Manage plugins" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })

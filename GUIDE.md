# Guide

Space is the leader key. Press it and wait to see the shortcuts.

## Plugins

| Plugin | Purpose |
| --- | --- |
| lazy.nvim | Plugin manager |
| catppuccin, tokyonight, rose-pine, gruvbox, kanagawa, everforest, nightfox | Colors. `Space ut` picks one, and the choice is remembered across restarts |
| alpha-nvim | Start dashboard |
| mini.icons | Icons |
| mini.surround | Add, change, and delete quotes and brackets |
| snacks.nvim | File, text, and symbol search |
| nvim-treesitter | Syntax highlighting and indentation |
| nvim-lspconfig + mason.nvim + mason-lspconfig.nvim | Language servers |
| blink.cmp | Completion |
| conform.nvim | Formatting |
| gitsigns.nvim | Git hunks and blame |
| which-key.nvim | Shortcut help |
| lualine.nvim | Statusline |
| oil.nvim | File explorer |
| render-markdown.nvim | Markdown rendering in the editor |
| vimtex | LaTeX: `\ll` compiles, `\lv` opens the PDF in Skim |
| nvim-dap + nvim-dap-ui + nvim-nio + nvim-dap-python | Debugger |

## Shortcuts

Normal mode unless noted.

| Keys | Action |
| --- | --- |
| `Ctrl-p` / `Space ff` | Find files |
| `Space fg` / `Space fw` | Search text / word under cursor in this component |
| `Space fG` / `Space fW` | Search text / word under cursor in the whole project |
| `Space fb` / `Space fr` | Buffers / recent files |
| `Space fh` / `Space fk` | Help / keymaps |
| `Space fs` | Resume last search |
| `Space ut` | Pick a theme (live preview) |
| `Space yr` / `Space yp` / `Space yn` | Copy relative path / absolute path / file name |
| `Ctrl-n` / `Space e` | File explorer |
| `Space w` / `Space q` | Save / close window |
| `[b` / `]b` | Previous / next buffer |
| `Space bd` | Close buffer |
| `Ctrl-h/j/k/l` | Move between windows |
| `Ctrl-d` / `Ctrl-u` | Half page down / up, cursor centred |
| `Space \|` / `Space -` | Vertical / horizontal split |
| `gd` / `gD` / `gy` | Definition / declaration / type definition |
| `grr` / `gri` | References / implementations |
| `K` | Hover docs |
| `Space cr` / `Space ca` | Rename / code action |
| `Space cs` | Document symbols |
| `[d` / `]d` / `Space cd` | Previous / next / show diagnostic |
| `Space xx` / `Space xl` | Workspace / buffer diagnostics |
| `Space cf` | Format buffer or selection |
| `gcc` / Visual `gc` | Comment line / selection |
| Visual `J` / `K` | Move selected lines down / up |
| `saiw"` / `sr"'` / `sd(` | Add quotes around a word / swap `"` for `'` / delete brackets |
| `za` / `zM` / `zR` | Toggle fold / fold everything / open everything |
| `]s` / `[s` / `z=` / `zg` | Next / previous misspelling, suggestions, add word (Markdown, commits, LaTeX) |
| `Space gg` | LazyGit |
| `[h` / `]h` | Previous / next hunk |
| `Space ghp` / `Space ghs` / `Space ghr` | Preview / stage / **discard** hunk |
| `Space gb` / `Space gd` | Blame line / diff against index |
| `Space gw` | Switch this tab to a worktree |
| `Space db` / `Space dc` | Breakpoint / start or continue |
| `Space dn` / `Space di` / `Space do` | Step over / into / out |
| `Space dm` / `Space du` / `Space dt` | Debug Python test / debug UI / stop |
| `Space tt` | Terminal |
| `Space tf` / `Space tn` | Run `dev test` on this file / on the test under the cursor |
| `Esc Esc` (terminal) | Leave terminal mode (`Ctrl-\ Ctrl-n` in LazyGit) |
| `Space cl` | LSP health |
| `Space pm` / `Space pl` | Mason / Lazy |

Completion (Insert mode): `Ctrl-Space` open, `Ctrl-n` / `Ctrl-p` select, `Ctrl-y` accept, `Ctrl-e` close, `Ctrl-s` signature help.

Oil: `Enter` open, `-` parent folder, `g.` hidden files, `g?` all keys. Edit the lines, then `:w` to rename, move, or delete.

## Dashboard layouts

Plain `nvim` opens the dashboard. Press `d` on it to switch layouts.

| Command | Layout |
| --- | --- |
| `:Dashboard dashboard` | Centered banner and shortcuts |
| `:Dashboard startify` | Banner, shortcuts, and recent files |
| `:Dashboard theta` | Banner, recent files in this folder, and shortcuts |

Set the startup layout with `opts.theme` in `lua/plugins/dashboard.lua`.

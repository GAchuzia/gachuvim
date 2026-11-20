# nvim-config

My Neovim setup: search, LSP, completion, Git, a file explorer, and a debugger.

## You need

- Neovim 0.12 or later.
- Git, ripgrep, the tree-sitter CLI, Node.js with npm, and a C compiler.

## Install

On macOS or Linux, back up any existing `~/.config/nvim` first.

```sh
git clone https://github.com/GAchuzia/nvim-config.git ~/personal/nvim-config
mkdir -p ~/.config
ln -s ~/personal/nvim-config ~/.config/nvim
nvim
```

Plugins install on the first launch. Restart, then open a code file so the language servers install.

## More

[GUIDE.md](GUIDE.md) has the keys, plugins, Windows setup, and fixes for common problems.

# nvim-config

> My Neovim setup

## Reqirements

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

For Ruby, run `gem install ruby-lsp` with the project's Ruby. For Python debugging, run `:MasonInstall debugpy`.

## More

[GUIDE.md](GUIDE.md) lists the plugins, shortcuts, and dashboard layouts.

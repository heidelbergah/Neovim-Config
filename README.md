# Neovim config

My Neovim setup, managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It works on Arch Linux and macOS.

## Requirements

- Neovim 0.12 or newer
- git, curl and tar
- A C compiler (gcc or clang)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) 0.26.1 or newer, used to build parsers. Install it from your package manager, not npm.
- [ripgrep](https://github.com/BurntSushi/ripgrep), used by Telescope for searching
- unzip, used by Mason to install language servers
- A terminal with background transparency turned on, if you want the transparent look

### Arch Linux

```sh
sudo pacman -S --needed neovim git base-devel tree-sitter-cli ripgrep unzip
```

### macOS

Install the Xcode command line tools for clang and git, then the rest through Homebrew:

```sh
xcode-select --install
brew install neovim tree-sitter-cli ripgrep
```

## Installation

Back up any existing config first:

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

Clone the dotfiles repo and link this folder into place:

```sh
git clone https://github.com/heidelbergah/dotfiles.git ~/dotfiles
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
```

Start `nvim`. On first launch lazy.nvim installs itself and every plugin, treesitter builds its parsers, and Mason installs clangd and lua_ls. Give it a minute, then restart Neovim once everything has finished.

### Keeping machines in sync

`lazy-lock.json` records the exact commit of every plugin. Commit it to the repo, and on another machine run `:Lazy restore` to install the same versions. Without that step, each machine gets whatever is newest at the time it installs.

## Layout

```
nvim/
├── init.lua                  entry point, loads lua/james
└── lua/james/
    ├── init.lua              loads the files below in order
    ├── remap.lua             leader key and general keymaps
    ├── set.lua               editor options
    ├── lazy.lua              installs lazy.nvim and loads plugins/
    └── plugins/
        ├── colorscheme.lua   themes and transparency
        ├── harpoon.lua
        ├── lsp.lua           language servers and completion
        ├── misc.lua          vimwiki, lexima
        ├── nerdtree.lua
        ├── telescope.lua
        └── treesitter.lua
```

Each file in `plugins/` returns a lazy.nvim spec. To add a plugin, create a new file there.

## Plugins

| Plugin | Purpose |
| --- | --- |
| everforest-nvim | Default colorscheme |
| gruvbox.nvim, nightfox.nvim | Alternate colorschemes, loaded when selected |
| telescope.nvim | Fuzzy finder for files and text |
| harpoon | Quick switching between a few marked files |
| nerdtree | File tree |
| nvim-treesitter | Syntax highlighting |
| nvim-lspconfig, mason.nvim, mason-lspconfig.nvim | Language servers (clangd, lua_ls) |
| nvim-cmp, cmp-nvim-lsp, LuaSnip | Autocompletion |
| lexima.vim | Auto-closes brackets and quotes |
| vimwiki | Personal wiki and notes |

## Keymaps

The leader key is Space.

### General

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>pv` | Normal | Open netrw file explorer |
| `J` / `K` | Visual | Move selected lines down / up |

### Files and navigation

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<C-p>` | Find files tracked by git |
| `<leader>fs` | Search for text in the project |
| `<C-t>` | Toggle NERDTree |
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Open the Harpoon menu |
| `<C-h>` / `<C-n>` / `<C-s>` | Jump to Harpoon file 1 / 3 / 4 |

Harpoon file 2 has no key, since `<C-t>` belongs to NERDTree. It can still be opened from the Harpoon menu.

### LSP

These are only active in buffers with a language server attached.

| Key | Action |
| --- | --- |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | List references |
| `gs` | Signature help |
| `gl` | Show diagnostics for the current line |
| `[d` / `]d` | Previous / next diagnostic |
| `<F2>` | Rename symbol |
| `<F3>` | Format file or selection |
| `<F4>` | Code actions |

On a Mac laptop the function keys may need `fn` held down, depending on keyboard settings.

### Completion

| Key | Action |
| --- | --- |
| `<C-n>` / `<C-p>` | Next / previous item, or open the menu |
| `<Down>` / `<Up>` | Next / previous item |
| `<C-y>` | Accept the selected item |
| `<C-e>` | Close the menu |
| `<C-d>` / `<C-u>` | Scroll the documentation window |

## Colorschemes

Everforest loads by default. To switch for the current session:

```vim
:lua ColorMyPencils("gruvbox")
:lua ColorMyPencils("terafox")
```

To change the default, edit the fallback in `ColorMyPencils` in `plugins/colorscheme.lua`. Any colorscheme that loads has its backgrounds cleared, including floating windows, the completion menu and Telescope, so the terminal background shows through.

## Maintenance

| Command | Purpose |
| --- | --- |
| `:Lazy` | Plugin manager window |
| `:Lazy sync` | Install, update and remove plugins to match the config |
| `:TSUpdate` | Update treesitter parsers |
| `:Mason` | Manage language servers |
| `:checkhealth` | Diagnose missing dependencies |

To add a language server, install it from `:Mason` and add its name to `ensure_installed` and `vim.lsp.enable` in `plugins/lsp.lua`. Server names are listed in the [nvim-lspconfig docs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).

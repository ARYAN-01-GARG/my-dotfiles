# 🛸 Neovim Custom LazyVim Overhaul

This package contains your modern Neovim setup, powered by [LazyVim](https://github.com/LazyVim/LazyVim) and customized with clean themes and file-system editing utilities.

---

## 🎨 Theme Selection

* **Default Flavour**: **Catppuccin (Mocha)** with elegant transparency rules enabled, creating a highly premium layout inside transparent terminal screens.
* **Secondary Flavour**: **Solarized Osaka** is pre-configured and loaded. You can switch to it easily by changing the `colorscheme` variable in `lua/plugins/colorscheme.lua`.

---

## 🛠️ Included Premium Plugins & Integrations

### 1. [Oil.nvim](https://github.com/stevearc/oil.nvim) (Parent Directory Editing)
Allows you to edit your file directory structure just like a standard Neovim text buffer. You can rename, delete, copy, or create new files simply by typing text and running `:w`!
* **Keyboard Hotkey**: Tap `-` or `<leader>te` in Normal mode to open.

### 2. [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (Fuzzy Explorer)
Supercharged with customized layouts, fuzzy previews, and history finders.
* `<leader>ff` : Fuzzy find files.
* `<leader>fg` : Live grep text search across your project.
* `<leader>fp` : Instantly search Neovim's plugin source code files!

### 3. [Dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) (Doom-Style Header)
A customized Doom-style minimalist landing dashboard on launch with slick ASCII art and quick-key bindings for new files, old files, or telescope searches.

### 4. [Noice.nvim](https://github.com/folke/noice.nvim) (Modern Popups)
Revamps the command-line, message popups, and search status to look like interactive floating boxes with smooth visual animations.

---

## ⌨️ Custom Keybindings

* `+` : Increment number under cursor.
* `-` : Decrement number under cursor / Open parent folder in Oil.
* `<C-a>` : Select all text inside current buffer.
* `Visual J / K` : Move selected blocks of code down / up.
* `Visual < / >` : Indent block and keep selection active.
* `<leader>nh` : Turn off active search highlighting.

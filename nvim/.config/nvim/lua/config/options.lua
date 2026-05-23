-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Line numbering
opt.number = true
opt.relativenumber = true

-- Tab / Indentation settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Clipboard integration (system sync)
opt.clipboard = "unnamedplus"

-- Line wrap behavior
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Screen split orientations
opt.splitright = true
opt.splitbelow = true

-- Color and theme prep
opt.termguicolors = true
opt.signcolumn = "yes"

-- Cursor lines and views
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Timing configurations (home-row friendly)
opt.updatetime = 250
opt.timeoutlen = 300

-- Fold optimization
opt.foldmethod = "manual"
opt.foldlevel = 99

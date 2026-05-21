-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Note: + and - are owned by dial.nvim (see lua/plugins/editor.lua) for
-- smart increment/decrement over numbers, booleans, dates, etc.

-- Select all content inside buffer
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all lines" })

-- Clear search highlighting
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Move selected line(s) up/down in Visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Indent adjustments in visual mode (keeps selection active)
keymap.set("v", "<", "<gv", { desc = "Shift indent left" })
keymap.set("v", ">", ">gv", { desc = "Shift indent right" })

-- Split control shortcuts
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab navigation
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Floating Oil.nvim Explorer keybind
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory with Oil" })
keymap.set("n", "<leader>te", "<CMD>Oil<CR>", { desc = "Open file explorer (Oil)" })

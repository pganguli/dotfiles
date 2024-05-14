-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- turn off search highlighting
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)

-- create new windows as vertical splits
vim.keymap.set("n", "<C-w>n", vim.cmd.vnew)
vim.keymap.set("n", "<C-w><C-n>", vim.cmd.vnew)

-- goto previous / next buffer
vim.keymap.set("n", "<M-Left>", vim.cmd.bprevious)
vim.keymap.set("n", "<M-Right>", vim.cmd.bnext)

-- replace visual selection while preserving registers
vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set("x", "<leader>P", '"_dP')

-- correct previous spelling mistake in insert mode
vim.keymap.set("i", "<C-l>", '<C-g>u<Esc>[s1z=`]a<C-g>u')

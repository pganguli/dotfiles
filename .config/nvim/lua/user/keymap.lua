vim.keymap.set('n', '<Space>',    '<C-w>p')          -- goto last accessed window
vim.keymap.set('n', '<C-w>n',     vim.cmd.vnew)      -- create new windows as vertical splits
vim.keymap.set('n', '<C-w><C-n>', vim.cmd.vnew)      -- create new windows as vertical splits
vim.keymap.set('n', '<M-Left>',   vim.cmd.bprevious) -- goto previous buffer
vim.keymap.set('n', '<M-Right>',  vim.cmd.bnext)     -- goto next buffer

vim.keymap.set('n', 'J', "mzJ`z")                    -- concatenate line below to current line preserving cursor position
vim.keymap.set('v', 'J', ":move '>+1<CR>gv=gv")      -- move a visual selection down 1 line and indent
vim.keymap.set('v', 'K', ":move '<-2<CR>gv=gv")      -- move a visual selection up 1 line and indent

vim.keymap.set('n', '<C-d>', '<C-d>zz')              -- scroll down 1 window, keeping cursor in the middle
vim.keymap.set('n', '<C-u>', '<C-u>zz')              -- scroll up 1 window, keeping cursor in the middle
vim.keymap.set('n', 'N', 'Nzzzv')                    -- search backward, keeping cursor in the middle and opening enough folds to view cursor
vim.keymap.set('n', 'n', 'nzzzv')                    -- search forward, keeping cursor in the middle and opening enough folds to view cursor
vim.keymap.set('n', 'N', 'Nzzzv')                    -- search backward, keeping cursor in the middle and opening enough folds to view cursor

vim.keymap.set('x', '<leader>p', '\"_dp')            -- replace visual selection while preserving registers

-- Your own keys, and a list of the keys that you get without config.

--[=[ Keys in the other files:
  30_treesitter.lua  af/if function · ac/ic class · aa/ia argument
                     ]m [m ]M [M function · ]] [[ class
  40_lsp.lua         gd definition · gD declaration · <Leader>ti inlay hints
  50_ui.lua          <Leader>f… pickers · yss and Visual S surround

Neovim and the plugins already give these keys. No file sets them.
  LSP          K hover · gra code action · grn rename · grr references
               gri implementation · grt type definition · gO file symbols
               <C-s> signature help (Insert mode) · gq format · [d ]d diagnostics
  Completion   <C-n> next · <C-p> previous · <C-y> accept · <C-e> close
  Selection    v an: select the syntax node. an: make larger. in: make smaller.
  Comments     gcc line · gc{motion} · gc text object
  Surround     ys{motion}{char} add · ds{char} delete · cs{old}{new} change
  Git signs    ]h [h next/previous change · gh/gH apply/reset · ih text object
  Jump labels  <CR> in Normal mode
  Search       <C-l> clears the search highlight (as <Esc> below)
  Buffers      [b ]b previous/next buffer (as <M-Left> <M-Right> below)
  Replace      P in Visual mode: replace the selection, keep the register
--]=]

local map = vim.keymap.set

map('n', '<Esc>', vim.cmd.nohlsearch,   { desc = 'Clear search highlight' })
map('n', '<C-w>n', vim.cmd.vnew,        { desc = 'New window (vertical split)' })
map('n', '<C-w><C-n>', vim.cmd.vnew,    { desc = 'New window (vertical split)' })
map('n', '<M-Left>', vim.cmd.bprevious, { desc = 'Previous buffer' })
map('n', '<M-Right>', vim.cmd.bnext,    { desc = 'Next buffer' })

-- Correct the last spelling mistake before the cursor (Insert mode, with :set spell).
map('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { desc = 'Correct last spelling mistake' })

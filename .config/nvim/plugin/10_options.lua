-- Editor options.

-- Turn off the remote-plugin providers.
for _, p in ipairs({ 'python3', 'ruby', 'perl', 'node' }) do vim.g['loaded_' .. p .. '_provider'] = 0 end

local o = vim.o
o.number      = true
o.signcolumn  = 'yes'
o.scrolloff   = 5
o.ignorecase  = true
o.smartcase   = true
o.splitright  = true
o.splitbelow  = true
o.undofile    = true
o.updatetime  = 250
o.wrap        = false
o.textwidth   = 80       -- gw wraps text at 80 columns. (gq uses the language server.)
o.title       = true
o.spelllang   = 'en_us'
o.matchpairs  = o.matchpairs .. ',<:>' -- % also jump between < and >.

-- Use the system clipboard (PRIMARY and CLIPBOARD) for yank and put.
-- Set after startup, because the clipboard check makes startup slower.
vim.schedule(function() o.clipboard = 'unnamed,unnamedplus' end)

-- Show whitespace.
o.list      = true
o.listchars = 'tab:› ,nbsp:⍽,trail:␣,precedes:«,extends:»'

-- Show the whitespace symbols in a dim color.
-- The default colors already do this. Other color schemes can change it,
-- so set it again each time the color scheme changes.
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function() vim.api.nvim_set_hl(0, 'Whitespace', { link = 'NonText' }) end,
})

-- The completion menu opens while you type.
-- It shows words from the open buffers.
-- If a buffer has a language server, the server results come first (see 40_lsp.lua).
o.autocomplete = true
o.complete     = '.,w,b'
o.completeopt  = 'menuone,noselect,popup,fuzzy'
o.pumheight    = 12

-- UI plugins (from mini.nvim), and their keys.
-- The plugins load after the first screen, so startup stays fast.

vim.schedule(function()
  require('mini.pick').setup()   -- Fuzzy pickers, like the Helix space-mode pickers
  require('mini.extra').setup()  -- More pickers: symbols, diagnostics, jumplist, file explorer
  require('mini.pairs').setup()  -- Closes brackets and quotes automatically
  require('mini.jump2d').setup() -- Jump labels, like Helix `gw`. Press <CR> to start.

  -- Git signs: show changed lines in the gutter.
  require('mini.diff').setup({
    view = { style = 'sign', signs = { add = '▎', change = '▎', delete = '▁' } },
  })

  -- Surround: use the tpope/vim-surround keys (ys, ds, cs, and S in Visual mode).
  require('mini.surround').setup({
    mappings = {
      add = 'ys', delete = 'ds', replace = 'cs',
      find = '', find_left = '', highlight = '', suffix_last = '', suffix_next = '',
    },
    search_method = 'cover_or_next',
  })
  -- Remove `ys` in Visual mode. If it stays, `y` waits for a second key.
  vim.keymap.del('x', 'ys')

  -- Key hints: a popup shows the next keys after you press a prefix key.
  -- Helix has the same info box.
  local clue = require('mini.clue')
  clue.setup({
    window = { delay = 300 },
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' },
      { mode = { 'n', 'x' }, keys = 'g' },
      { mode = { 'n', 'x' }, keys = '[' },
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = { 'n', 'x' }, keys = 'z' },
      { mode = 'n',          keys = '<C-w>' },
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'i',          keys = '<C-x>' },
    },
    clues = {
      { mode = 'n', keys = '<Leader>f', desc = '+Find' },
      { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.square_brackets(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  })
end)

local map = vim.keymap.set

-- More surround keys: yss surrounds the line. S surrounds the selection.
map('n', 'yss', 'ys_', { remap = true, desc = 'Surround line' })
map('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true, desc = 'Surround selection' })

-- Pickers. These are like the Helix space-mode pickers.
local function pick(name, opts) return function() MiniPick.builtin[name](opts) end end
local function extra(name, opts) return function() MiniExtra.pickers[name](opts) end end
map('n', '<Leader>ff', pick('files'),                                     { desc = 'Files' })
map('n', '<Leader>fg', pick('grep_live'),                                 { desc = 'Grep (live)' })
map('n', '<Leader>fw', function() MiniPick.builtin.grep({ pattern = vim.fn.expand('<cword>') }) end, { desc = 'Grep word under cursor' })
map('n', '<Leader>fb', pick('buffers'),                                   { desc = 'Buffers' })
map('n', '<Leader>fr', pick('resume'),                                    { desc = 'Resume last picker' })
map('n', '<Leader>fh', pick('help'),                                      { desc = 'Help' })
map('n', '<Leader>fj', extra('list', { scope = 'jump' }),                 { desc = 'Jumplist' })
map('n', '<Leader>fs', extra('lsp', { scope = 'document_symbol' }),       { desc = 'Symbols (file)' })
map('n', '<Leader>fS', extra('lsp', { scope = 'workspace_symbol_live' }), { desc = 'Symbols (workspace)' })
map('n', '<Leader>fd', extra('diagnostic', { scope = 'current' }),       { desc = 'Diagnostics (file)' })
map('n', '<Leader>fD', extra('diagnostic', { scope = 'all' }),           { desc = 'Diagnostics (workspace)' })
map('n', '<Leader>fm', extra('git_hunks'),                                { desc = 'Modified hunks (git)' })
map('n', '<Leader>fc', extra('commands'),                                 { desc = 'Command palette' })
map('n', '<Leader>fe', extra('explorer'),                                 { desc = 'File explorer' })

-- Tree-sitter: colors, indent, text objects, and their keys.

-- Start tree-sitter for each file.
-- If the parser is not installed, download it one time.
-- (Helix includes its parsers. This config gets each parser on first use.)
local pending = {}
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local buf, lang = ev.buf, vim.treesitter.language.get_lang(ev.match)
    if not lang then return end

    -- Start colors. If the language has tree-sitter indent rules, use them too.
    local function start()
      if vim.api.nvim_buf_is_valid(buf) and pcall(vim.treesitter.start, buf, lang)
        and #vim.treesitter.query.get_files(lang, 'indents') > 0 then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    -- If the parser is available, use it now. It can come with Neovim,
    -- or you installed it before.
    if vim.treesitter.language.add(lang) then return start() end

    -- If not, install it. Do this only for real files.
    -- LSP popups are markdown buffers. They use the parser that comes with Neovim.
    if vim.bo[buf].buftype ~= '' or pending[lang] then return end
    if not require('nvim-treesitter.parsers')[lang] then return end
    pending[lang] = true
    require('nvim-treesitter').install(lang):await(function(err)
      if not err then vim.schedule(start) end
    end)
  end,
})

-- Helpers for the keys below.
-- They load their module when you first use them.
-- If tree-sitter cannot find the object, the standard Vim motion runs.

-- Find out if this language has the object (for example, '@function.outer').
local function has(capture)
  local parser = vim.treesitter.get_parser(0, nil, { error = false })
  local query = parser and vim.treesitter.query.get(parser:lang(), 'textobjects')
  return query ~= nil and vim.list_contains(query.captures, capture:sub(2))
end

-- Select the object.
local function textobject(capture)
  return function()
    if not has(capture) then return end
    require('nvim-treesitter-textobjects').setup({ select = { lookahead = true } })
    require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects')
  end
end

-- Go to the object. If tree-sitter cannot, use the Vim keys in fallback_keys.
local function motion(fallback_keys, fn, capture)
  return function()
    if has(capture) then
      return require('nvim-treesitter-textobjects.move')[fn](capture, 'textobjects')
    end
    vim.cmd('normal! ' .. vim.v.count1 .. fallback_keys)
  end
end

local map = vim.keymap.set

-- Text objects. Use them in Visual mode and after an operator.
-- Examples: daf deletes a function. vic selects the inside of a class.
map({ 'x', 'o' }, 'af', textobject('@function.outer'),  { desc = 'around function' })
map({ 'x', 'o' }, 'if', textobject('@function.inner'),  { desc = 'inside function' })
map({ 'x', 'o' }, 'ac', textobject('@class.outer'),     { desc = 'around class' })
map({ 'x', 'o' }, 'ic', textobject('@class.inner'),     { desc = 'inside class' })
map({ 'x', 'o' }, 'aa', textobject('@parameter.outer'), { desc = 'around argument' })
map({ 'x', 'o' }, 'ia', textobject('@parameter.inner'), { desc = 'inside argument' })

-- Motions. These are the standard Vim keys, but they use the syntax tree.
local nxo = { 'n', 'x', 'o' }
map(nxo, ']m', motion(']m', 'goto_next_start', '@function.outer'),     { desc = 'Next function start' })
map(nxo, '[m', motion('[m', 'goto_previous_start', '@function.outer'), { desc = 'Previous function start' })
map(nxo, ']M', motion(']M', 'goto_next_end', '@function.outer'),       { desc = 'Next function end' })
map(nxo, '[M', motion('[M', 'goto_previous_end', '@function.outer'),   { desc = 'Previous function end' })
map(nxo, ']]', motion(']]', 'goto_next_start', '@class.outer'),        { desc = 'Next class' })
map(nxo, '[[', motion('[[', 'goto_previous_start', '@class.outer'),    { desc = 'Previous class' })

--[[
Neovim with the Helix features and the Vim keys.

You must have:
  - Neovim 0.12 or later
  - git and a C compiler
  - the tree-sitter CLI, 0.26.1 or later
  - ripgrep
  - the language servers for your languages

This file runs first. Then Neovim loads each file in plugin/ in alphabetical order.
  plugin/10_options.lua     Editor options, whitespace, clipboard
  plugin/20_plugins.lua     Plugin list
  plugin/30_treesitter.lua  Colors, indent, text objects and their keys
  plugin/40_lsp.lua         Language server list, completion, diagnostics, format on save
  plugin/50_ui.lua          Pickers, surround, git signs, key hints, and their keys
  plugin/60_keymaps.lua     Your own keys, and a list of the built-in keys
  plugin/70_commands.lua    User commands (:Rdupe, :Rtrail, :Sudow)
--]]

-- Stop if Neovim is too old. Show one clear message, and do not load plugin/.
if vim.fn.has('nvim-0.12') == 0 then
  vim.o.loadplugins = false
  vim.api.nvim_echo({ { 'This config needs Neovim 0.12+, this is ' .. tostring(vim.version()), 'ErrorMsg' } }, true, {})
  return
end

-- Keep compiled Lua modules in a cache. This makes startup faster.
vim.loader.enable()

-- Set the leader key before any file makes a keymap with it.
vim.g.mapleader = ' '

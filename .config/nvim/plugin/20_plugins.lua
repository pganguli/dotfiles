-- Plugins.
-- Neovim's own plugin manager (vim.pack) installs these plugins.
-- To update them, type :lua vim.pack.update()

-- When nvim-treesitter updates, build the parsers again.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',   -- Pickers, surround, pairs, git signs, key hints, jump labels
  'https://github.com/neovim/nvim-lspconfig', -- Settings for each language server (data only)
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },             -- Installs parsers
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' }, -- Function, class and argument objects
})

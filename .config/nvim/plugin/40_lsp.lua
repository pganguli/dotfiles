-- Language servers: completion, signature help, diagnostics, format on save.

-- Language servers. Each line has the server name and its program name.
-- The config starts a server only if its program is on your PATH.
-- To add a language, add a line. For server names, see:
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
local servers = {
  rust_analyzer = 'rust-analyzer',
  clangd        = 'clangd',
  gopls         = 'gopls',
  basedpyright  = 'basedpyright-langserver',
  ruff          = 'ruff',
  ts_ls         = 'typescript-language-server',
  lua_ls        = 'lua-language-server',
  bashls        = 'bash-language-server',
  jsonls        = 'vscode-json-language-server',
  yamlls        = 'yaml-language-server',
  html          = 'vscode-html-language-server',
  cssls         = 'vscode-css-language-server',
  taplo         = 'taplo',
  marksman      = 'marksman',
  zls           = 'zls',
}

-- Format the file when you save it. Helix does this by default.
-- Your old config turned it off. Set this to true to turn it on.
local format_on_save = false

vim.diagnostic.config({
  severity_sort = true,
  virtual_text  = true, -- Show the message at the end of the line.
  float         = { border = 'rounded' },
  jump          = { -- When you jump with ]d or [d, show the message.
    on_jump = function(_, buf) vim.diagnostic.open_float({ bufnr = buf, scope = 'cursor', focus = false }) end,
  },
})

-- Start the installed servers after the first screen.
-- They still connect to the files that are open.
vim.schedule(function()
  local installed = {}
  for name, program in pairs(servers) do
    if vim.fn.executable(program) == 1 then table.insert(installed, name) end
  end
  vim.lsp.enable(installed)
end)

-- Do these steps each time a server connects to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client, buf = assert(vim.lsp.get_client_by_id(ev.data.client_id)), ev.buf

    -- Completion: show the server results first in the menu.
    -- Accept with <C-y>. Then the server also adds imports and expands snippets.
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      vim.bo[buf].complete = 'o,.,w,b'
    end

    -- Signature help: open it automatically when you type '(' or ','.
    -- Helix does this too.
    local sig = client.server_capabilities.signatureHelpProvider
    if sig then
      local triggers = {}
      for _, c in ipairs(sig.triggerCharacters or {}) do triggers[c] = true end
      for _, c in ipairs(sig.retriggerCharacters or {}) do triggers[c] = true end
      -- Use one group for each server and buffer.
      -- Then `:lsp restart` replaces this hook and does not add a second one.
      local group = vim.api.nvim_create_augroup(('my.lsp.%s.%d'):format(client.name, buf), { clear = true })
      vim.api.nvim_create_autocmd('InsertCharPre', {
        group = group,
        buffer = buf,
        callback = function()
          if not triggers[vim.v.char] then return end
          vim.schedule(function()
            vim.lsp.buf.signature_help({ silent = true, focusable = false, close_events = { 'InsertLeave', 'CursorMoved' } })
          end)
        end,
      })
    end
  end,
})

-- Format on save.
-- The config looks for a formatting server when you save, not when the server
-- connects. Some servers (for example, ruff) add formatting later.
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    if format_on_save and #vim.lsp.get_clients({ bufnr = ev.buf, method = 'textDocument/formatting' }) > 0 then
      vim.lsp.buf.format({ bufnr = ev.buf, timeout_ms = 1000 })
    end
  end,
})

-- Keys. (Neovim gives the other LSP keys. See the list in 60_keymaps.lua.)
local map = vim.keymap.set

-- gd and gD use the language server. If the file has none, they do the standard Vim action.
-- (Give the function name as text. If the code uses vim.lsp.buf here,
-- Neovim loads the LSP module at startup. That takes about 1.7 ms.)
local function lsp_or_vim(method, fn_name, keys)
  return function()
    if #vim.lsp.get_clients({ bufnr = 0, method = method }) > 0 then return vim.lsp.buf[fn_name]() end
    vim.cmd('normal! ' .. keys)
  end
end
map('n', 'gd', lsp_or_vim('textDocument/definition', 'definition', 'gd'),    { desc = 'Go to definition' })
map('n', 'gD', lsp_or_vim('textDocument/declaration', 'declaration', 'gD'), { desc = 'Go to declaration' })
map('n', '<Leader>ti', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Toggle inlay hints' })

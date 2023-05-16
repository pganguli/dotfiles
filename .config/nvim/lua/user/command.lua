-- Highlight only as long as in search mode
vim.api.nvim_create_augroup('vim-incsearch-highlight', { clear = true })
vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = 'vim-incsearch-highlight',
    pattern = '/,?', command = 'set hlsearch',
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = 'vim-incsearch-highlight',
    pattern = '/,?', command = 'set nohlsearch',
})


-- Remove duplicate lines in-place
vim.api.nvim_create_user_command('Rdupe', "%!awk '\\!visited[$0]++'", {})

-- Remove trailing spaces and tabs
vim.api.nvim_create_user_command('Rtrail', "%s/\\s\\+$//g", {})

-- See the differences between the current buffer and the file it was loaded from
vim.api.nvim_create_user_command('DiffOrig', function()
    local filetype = vim.bo.filetype -- save filetype locally for later
    vim.cmd.vnew()                   -- verticl split
    vim.bo.buftype = 'nofile'        -- this new buffer is not associated with any file
    vim.bo.filetype = filetype       -- restore filetype that we had saved
    vim.cmd('read #')                -- read the previous buffer into this new buffer
    vim.cmd('0d_')                   -- delete the extra line that :read puts, into the black hole register
    vim.cmd.diffthis()               -- add this new buffer to diff window
    vim.cmd.wincmd('p')              -- go back to previous buffer
    vim.cmd.diffthis()               -- make this original buffer part of diff window
end, {})

-- Jump to the last known position in a file just after opening it, if the '"' mark is set
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function(event)
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd("normal! g`\"")
        end
    end,
})

-- Write file with sudo
vim.api.nvim_create_user_command('Sudow', "set buftype=nowrite | write !SUDO_ASKPASS='/usr/libexec/openssh/lxqt-openssh-askpass' sudo --askpass tee % &> /dev/null", {})

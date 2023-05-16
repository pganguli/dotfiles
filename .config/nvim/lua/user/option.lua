--
-- Set status line
--
vim.opt.statusline = '%<%f %m%r%=%B %y[%{&fileencoding}][%{&fileformat}] %-14.(%l,%c%V%) %P %L'
--                    %< truncate-at-start if too long
--                      %f path to file in buffer
--                         %m modified flag
--                           %r readonly flag
--                             %= equal-space section alignment
--                               %B value of character under cursor in hex
--                                  %y file type in Vim
--                                    [%{&fileencoding}] file encoding format in Vim
--                                                      [%{&fileformat}] line ending format in Vim
--                                                                       %-14. left-justify-item with minwidth=14.maxwidth=inf
--                                                                            (%l,%c%V%) line-number,column-number,virtual-column-number
--                                                                                       %P %L percentage-through-file total-lines

vim.opt.shortmess:append('I')     -- disable startup intro message
vim.opt.title     = true          -- set window title to filename
vim.opt.autochdir = true          -- cd to path of current file
vim.opt.clipboard = 'unnamedplus' -- use system clipboard for unnamed register

vim.opt.matchpairs:append('<:>')  -- consider <> to be a matchpair
vim.opt.number     = true         -- print line number in front of each line
vim.opt.signcolumn = 'no'         -- never draw the signcolumn
vim.opt.cursorline = true         -- highlight text line of cursor
vim.opt.wrap       = false        -- do not wrap lines longer than window width
vim.opt.scrolloff  = 5            -- try to put 5 lines before and after cursorline
vim.opt.listchars  = {
    tab      = '› ',              -- '›' is always used, then ' ' as many times as will
    trail    = '␣',               -- character to show for trailing spaces
    precedes = '«',               -- character to show in first column for unwrapped line
    extends  = '»',               -- character to show in last column for unwrapped line
    nbsp     = '⍽',               -- character to show for non-breakable space characters
}
vim.opt.list       = true         -- show listchars
vim.opt.splitright = true         -- open new split panes to right
vim.opt.splitbelow = true         -- open new split panes to bottom

vim.opt.shiftwidth  = 4           -- spaces for each step of (auto)indent
vim.opt.tabstop     = 4           -- number of spaces that <Tab> a counts for
vim.opt.expandtab   = true        -- use spaces to insert a <Tab>
vim.opt.smartindent = true        -- smart autoindenting on newline

vim.opt.incsearch   = true        -- highlight matches as you type
vim.opt.ignorecase  = true        -- ignore case of normal letters
vim.opt.smartcase   = true        -- override ignorecase if pattern has upper case letters

vim.opt.autowrite  = true         -- sync file to disk before :make
vim.opt.updatetime = 200          -- swapfile disk sync and CursorHold delay
vim.opt.undofile   = true         -- persistent undo history

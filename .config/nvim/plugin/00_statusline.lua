-- Statusline: the Neovim default, with more information in the ruler.
--
-- The default statusline shows 'rulerformat' on its right side.
-- Thus this one option adds the extra information. No Lua runs at redraw.
-- Neovim evaluates each %{} item in the window that it draws.
-- Thus each window shows the values of its own buffer.
--
-- The ruler shows, from left to right:
--   [encoding]       Only when it is not plain UTF-8, for example "[latin1]".
--                    "-bom" shows when the file has a byte order mark.
--   [fileformat]     Only when it is not unix, for example "[dos]".
--   [filetype]       The %y item. It shows nothing when the filetype is empty.
--   U+%04B           Unicode code point of the character under the cursor,
--                    for example "U+0041" for "A".
--   %l/%L,%c%V %P    The default ruler, with the number of lines after the line,
--                    for example "12/120,5-9 42%".
--
-- NOTE: With 'laststatus' 0 or 1, a window can have no statusline.
-- Then Neovim shows the ruler in the command line, and cuts it to 18 columns.
-- Use 'laststatus' 2 (the default) or 3 to see all of the ruler.
local encoding = "%{(&fenc != '' && &fenc != 'utf-8') || &bomb"
  .. " ? '[' . (&fenc != '' ? &fenc : &enc) . (&bomb ? '-bom' : '') . ']' : ''}"
local fileformat = "%{&ff != 'unix' ? '[' . &ff . ']' : ''}"
vim.o.rulerformat = encoding .. fileformat .. "%y U+%04B %-14.(%l/%L,%c%V%) %P"

-- This file needs the default statusline, and the default statusline shows
-- the ruler only when 'ruler' is on. Set both here, so that a different value
-- (from a plugin or from an earlier version of this file) does not hide the ruler.
vim.cmd("set statusline& ruler")

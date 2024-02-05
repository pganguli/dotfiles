-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false -- Do not autoformat files

vim.opt.autochdir = true -- Always cd to path of current file
vim.opt.cmdheight = 0 -- Hide command-line unless it is being used
vim.opt.incsearch = true -- highlight matches as you type
vim.opt.listchars = { -- Strings to show in 'list' mode
  tab = "› ", -- Character to show for tabs: The '›' is always used, then ' ' as many times as will fit
  trail = "␣", -- Character to show for trailing spaces
  precedes = "«", -- Character to show in first column, when 'wrap' is off
  extends = "»", -- Character to show in last column, when 'wrap' is off
  nbsp = "⍽", -- Character to show for a non-breakable space character
}
vim.opt.matchpairs:append("<:>") -- Consider <> to be a matchpair
vim.opt.showcmdloc = "statusline" -- Display (partially) entered command in status line
vim.opt.spelllang = "en_us" -- Set language for spellcheck
vim.opt.title = true -- Set window title to filename

--
-- Add any additional user commands here
--

-- Remove duplicate lines in-place
vim.api.nvim_create_user_command("Rdupe", "%!awk '\\!visited[$0]++'", {})

-- Remove trailing spaces and tabs
vim.api.nvim_create_user_command("Rtrail", "%s/\\s\\+$//g", {})

-- Write file with sudo
vim.api.nvim_create_user_command(
  "Sudow",
  "set buftype=nowrite | write !SUDO_ASKPASS='/usr/libexec/openssh/lxqt-openssh-askpass' sudo --askpass tee % &> /dev/null",
  {}
)

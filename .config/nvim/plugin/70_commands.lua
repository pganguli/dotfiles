-- User commands.

-- :Rdupe  Remove duplicate lines. Keep the first one, and keep the order.
vim.api.nvim_create_user_command('Rdupe', "%!awk '\\!visited[$0]++'", {})

-- :Rtrail  Remove spaces and tabs at the end of lines.
-- Without a range, it changes the current line. For the whole file, use :%Rtrail
vim.api.nvim_create_user_command('Rtrail', '<line1>,<line2>s/\\s\\+$//e', { range = true })

-- :Sudow  Write the file with sudo. A graphic password prompt opens.
vim.api.nvim_create_user_command('Sudow',
  "set buftype=nowrite | silent! write !SUDO_ASKPASS='/usr/libexec/openssh/lxqt-openssh-askpass' sudo --askpass tee % &> /dev/null",
  {})

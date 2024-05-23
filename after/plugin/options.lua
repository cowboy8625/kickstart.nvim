-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true
-- enable lua filetype
vim.g.do_filetype_lua = 1
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.autoread = true

vim.cmd [[ packadd cfilter ]]

vim.cmd [[ autocmd BufRead,BufNewFile *.snow set filetype=snow ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.snack set filetype=snack ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.a set filetype=a ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.tera set filetype=html ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.zon set filetype=zig ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.nl set filetype=lisp ]]

local uname = vim.loop.os_uname()
if uname.sysname == 'Darwin' then
  -- Disable newlines at the end of files
  vim.opt.binary = true
  vim.opt.eol = false
end

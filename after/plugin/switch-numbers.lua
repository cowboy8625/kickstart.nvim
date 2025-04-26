vim.api.nvim_create_autocmd('WinEnter', {
  pattern = '*',
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  pattern = '*',
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = false
  end,
})

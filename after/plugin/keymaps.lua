-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('t', '<c-k>', '<c-\\><c-n>:wincmd k<CR>')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n>:wincmd j<CR>')
vim.keymap.set('t', '<c-h>', '<c-\\><c-n>:wincmd h<CR>')
vim.keymap.set('t', '<c-l>', '<c-\\><c-n>:wincmd l<CR>')

vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })

-- Spawn terminal at bottom of screen
-- vim.keymap.set('n', '<leader>;', ':belowright split | term<CR>')
--
-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
--
-- vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>')

vim.api.nvim_create_user_command('InsertDate', function()
  local currentDateTime = vim.fn.system 'date'
  local trimmedDateTime = currentDateTime:gsub('^%s*(.-)%s*$', '%1')
  vim.api.nvim_put({ trimmedDateTime }, 'c', true, true)
end, {})
vim.api.nvim_create_user_command('DeleteNoNameBuffers', function()
  vim.cmd [[
    bufdo if getbufvar(bufnr('%'), '&buftype') == '' && getbufvar(bufnr('%'), '&modified') == 0 && bufname('%') == '' | bdelete | endif
  ]]
end, {})

-- vim.keymap.set('i', '<F5>', '<C-o>:InsertDate<CR>')
-- vim.keymap.set('n', '<F5>', ':InsertDate<CR>')

vim.keymap.set('n', '<leader>rl', ':w<CR>:so %<CR>', { desc = 'Save and Reload [S]ource' })

vim.keymap.set('n', '<leader>fc', ':e $MYVIMRC<CR>', { desc = 'Edit [F]ile [C]onfig' })

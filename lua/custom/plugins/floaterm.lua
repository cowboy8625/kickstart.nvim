return {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_gitcommit = 'floaterm'
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_keymap_toggle = '<c-/>'
    -- vim.g.floaterm_background = '#0f0f0f'
    -- vim.g.floaterm_borderchars = '─│─│╭╮╰╯'
  end,
  vim.keymap.set('n', '<c-_>', ':FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' }),
  vim.keymap.set('i', '<c-_>', ':FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' }),
  vim.keymap.set('t', '<c-_>', '<c-\\><c-n>:FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' }),
}

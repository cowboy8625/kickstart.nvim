return {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_gitcommit = 'floaterm'
    vim.g.floaterm_title = 'mege awesome terminal'
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1

    local function getKeys()
      if vim.env.KITTY_WINDOW_ID ~= nil then
        return '<c-_>'
      end
      return '<c-/>'
    end

    local keys = getKeys()
    vim.keymap.set('n', keys, ':FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' })
    vim.keymap.set('i', keys, '<C-o>:FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' })
    vim.keymap.set('t', keys, '<c-\\><c-n>:FloatermToggle<CR>', { desc = 'Toggle [F]loaterm' })
  end,
}

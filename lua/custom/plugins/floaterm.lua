return {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_gitcommit = 'floaterm'
    vim.g.floaterm_title = ''
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

    local function getKeys()
      -- local uname = vim.loop.os_uname().sysname
      if vim.env.KITTY_WINDOW_ID ~= nil then
        return '<c-_>'
      end
      return '<c-/>'
    end

    local keys = getKeys()
    vim.keymap.set('n', keys, ':FloatermToggle<CR>', { desc = 'Toggle [F]loaterm', silent = true })
    vim.keymap.set('i', keys, '<C-o>:FloatermToggle<CR>', { desc = 'Toggle [F]loaterm', silent = true })
    vim.keymap.set('t', keys, '<c-\\><c-n>:FloatermToggle<CR>', { desc = 'Toggle [F]loaterm', silent = true })

    -- Define a highlight group for Floaterm border
    local color = vim.api.nvim_get_hl_by_name('Normal', true)
    vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = color.background, fg = color.foreground })
  end,
}

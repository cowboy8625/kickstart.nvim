return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = true,
  vim.keymap.set('n', '<leader>ng', ':Neogit<cr>', { desc = 'Open Neogit' }),
}

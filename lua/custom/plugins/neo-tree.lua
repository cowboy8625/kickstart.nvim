return {
  'nvim-neo-tree/neo-tree.nvim',
  priority = 1000,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'right',
      },
    }
  end,

  vim.keymap.set('n', '<c-n>', ':Neotree  reveal_force_cwd toggle<cr>', { desc = 'Toggle NeoTree', silent = true }),
}

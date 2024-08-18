-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- { dir = '~/Documents/neovim_plugins/epoc.nvim' },
  { 'cowboy8625/epoc.nvim' },
  { 'cowboy8625/case-swap.nvim' },
  { 'nvim-neotest/nvim-nio' },
  { 'mattn/webapi-vim' },
  -- json and yaml formating and more tools
  {
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json', 'yaml' },
  },
  {
    'tjdevries/colorbuddy.nvim',
  },
}

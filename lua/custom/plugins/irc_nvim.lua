return {
  dir = '~/Documents/neovim_plugins/irc.nvim',
  config = function()
    local cowboy8625 = 'cowboy8625'
    require('irc_nvim').setup {
      opt = {
        server = 'irc.libera.chat',
        port = 6667,
        nickname = cowboy8625,
        username = cowboy8625,
        realname = cowboy8625,
        password = os.getenv 'IRC_PASSWORD',
        hidden_commands = {
          'JOIN',
          'PART',
          'QUIT',
        },
        channels = {
          'libera\\.chat',
          '#dailycodex',
          '#llvm',
          '#lisp',
          '#neovim',
          '#systemcrafters',
          '#emacs',
          '##rust',
        },
      },
    }

    local function nmap(keys, cmd, desc)
      vim.keymap.set('n', '<leader>' .. keys, ':' .. cmd .. '<CR>', { desc = desc, noremap = true, silent = true })
    end

    nmap('ii', 'IrcInit', '[I]nitialize [I]rc')
    nmap('io', 'IrcOpenUi', '[I]rc [O]pen')
    nmap('ic', 'IrcOpenUi', '[I]rc [C]lose')
    vim.keymap.set('n', '<leader>iq', ':lua require("irc_nvim").quit()<CR>', { desc = '[I]rc [Q]uit', noremap = true, silent = true })
  end,
}

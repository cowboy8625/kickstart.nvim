-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
<<<<<<< Updated upstream
  {
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
          hide = {
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
    end,
  },
=======
  -- {
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'rcarriga/nvim-notify',
  --   },
  --   dir = '~/Documents/NeovimPlugins/twitch_watch.nvim',
  -- },
  { 'rcarriga/nvim-notify' },
>>>>>>> Stashed changes
  { 'nvim-neotest/nvim-nio' },
  { 'mattn/webapi-vim' },
  -- json and yaml formating and more tools
  {
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json', 'yaml' },
  },
  -- {
  --   'mxsdev/nvim-dap-vscode-js',
  --   dependencies = { 'mfussenegger/nvim-dap' },
  --   config = function()
  --     require('dap-vscode-js').setup {
  --       node_path = '$NODE_PATH/node', -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  --       debugger_path = '(runtimedir)/site/pack/packer/opt/vscode-js-debug', -- Path to vscode-js-debug installation.
  --       debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  --       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  --       log_file_path = '(stdpath cache)/dap_vscode_js.log', -- Path for file logging
  --       log_file_level = 0, -- Logging level for output to file. Set to false to disable file logging.
  --       log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
  --     }
  --
  --     for _, language in ipairs { 'typescript', 'javascript' } do
  --       require('dap').configurations[language] = {
  --         {
  --           type = 'node',
  --           request = 'launch',
  --           name = 'Run API',
  --           cwd = '${workspaceFolder}/api',
  --           runtimeExecutable = 'npm',
  --           runtimeArgs = { 'run', 'dev' },
  --           env = {
  --             NODE_ENV = 'LOCAL',
  --             USE_LOCALSTACK = 'true',
  --           },
  --           console = 'integratedTerminal',
  --           presentation = {
  --             hidden = false,
  --             group = '',
  --             order = 1,
  --           },
  --         },
  --         {
  --           type = 'pwa-node',
  --           request = 'attach',
  --           name = 'Attach',
  --           processId = require('dap.utils').pick_process,
  --           cwd = '${workspaceFolder}',
  --         },
  --         {
  --           type = 'pwa-node',
  --           request = 'launch',
  --           name = 'Debug Mocha Tests',
  --           -- trace = true, -- include debugger info
  --           runtimeExecutable = 'node',
  --           runtimeArgs = {
  --             './node_modules/mocha/bin/mocha.js',
  --           },
  --           rootPath = '${workspaceFolder}',
  --           cwd = '${workspaceFolder}',
  --           console = 'integratedTerminal',
  --           internalConsoleOptions = 'neverOpen',
  --         },
  --         {
  --           type = 'pwa-node',
  --           request = 'launch',
  --           name = 'Debug Mocha Tests',
  --           -- trace = true, -- include debugger info
  --           runtimeExecutable = 'node',
  --           runtimeArgs = {
  --             './node_modules/mocha/bin/mocha.js',
  --           },
  --           rootPath = '${workspaceFolder}',
  --           cwd = '${workspaceFolder}',
  --           console = 'integratedTerminal',
  --           internalConsoleOptions = 'neverOpen',
  --         },
  --       }
  --     end
  --   end,
  -- },
  -- {
  --   'microsoft/vscode-js-debug',
  --   opt = true,
  --   build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
  -- },
}

-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local function js_debugger_setup()
  local js_based_languages = {
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'vue',
  }

  local dap = require 'dap'
  require('dap.ext.vscode').json_decode = require('json5').parse
  local dap_vscode = require 'dap.ext.vscode'
  dap_vscode.load_launchjs(nil, {
    ['pwa-node'] = js_based_languages,
    ['node2'] = { 'javascript', 'typescript' },
    ['chrome'] = js_based_languages,
    ['pwa-chrome'] = js_based_languages,
  })

  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      -- Debug single nodejs files
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
      },
      -- Debug nodejs processes (make sure to add --inspect when you run the process)
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
      },
      {
        -- name = 'Run crmSyncTester.ts with tsx',
        name = 'Run crmSyncTester.ts with Node and tsx',
        type = 'pwa-node', -- Assuming you're using the 'pwa-node' adapter
        request = 'launch',
        program = '${workspaceFolder}/api/tools/crmSyncTester.ts', -- The script to run
        cwd = vim.fn.getcwd(), -- Current working directory (optional)

        -- This matches the `--inspect-brk=9229` flag to start the debugger and break before execution
        runtimeArgs = { '--inspect-brk=9229', '--import', 'tsx' },

        -- Node.js runtime executable
        runtimeExecutable = 'node', -- You can also specify the full path if needed, e.g., '/usr/local/bin/node'

        -- Environment variables
        env = {
          NODE_ENV = 'LOCAL_PRODUCTION', -- Pass NODE_ENV as environment variable
        },

        sourceMaps = false, -- If you are not using source maps
        protocol = 'inspector', -- The inspector protocol used for Node.js
        console = 'integratedTerminal', -- Use Neovim's integrated terminal for the output
      },
      -- Debug web applications (client side)
      {
        type = 'pwa-chrome',
        request = 'launch',
        name = 'Launch & Debug Chrome',
        url = function()
          local co = coroutine.running()
          return coroutine.create(function()
            vim.ui.input({
              prompt = 'Enter URL: ',
              default = 'http://localhost:3000',
            }, function(url)
              if url == nil or url == '' then
                return
              else
                coroutine.resume(co, url)
              end
            end)
          end)
        end,
        webRoot = vim.fn.getcwd(),
        protocol = 'inspector',
        sourceMaps = true,
        userDataDir = false,
      },
      -- Divider for the launch.json derived configs
      {
        name = 'json-admin2',
        type = 'pwa-node', -- Replace "node2" with "pwa-node" for nvim-dap
        request = 'launch',
        cwd = vim.fn.getcwd() .. '/api', -- Equivalent to "${workspaceFolder}/api"
        runtimeExecutable = 'npm',
        runtimeArgs = { 'run', 'admin' },
        env = {
          IS_APP_ADMIN = 'true',
          PORT = '8085',
          NODE_ENV = 'LOCAL',
          USE_LOCALSTACK = 'true',
        },
        autoAttachChildProcesses = true,
        restart = true,
        skipFiles = { '<node_internals>/**' },
        console = 'integratedTerminal',
      },
      {
        name = '----- ↓ launch.json configs ↓ -----',
        type = '',
        request = 'launch',
      },
    }
  end
end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    ----
    {
      'microsoft/vscode-js-debug',
      -- After install, build it and rename the dist directory to out
      build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
      version = '1.*',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('dap-vscode-js').setup {
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            'chrome',
            'pwa-node',
            'pwa-chrome',
            'pwa-msedge',
            'pwa-extensionHost',
            'node-terminal',
            'node2',
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        }
      end,
    },
    {
      'Joakker/lua-json5',
      build = './install.sh',
    },
    -- {
    --   'nvim-telescope/telescope-dap.nvim',
    -- },
    ---
  },
  config = function()
    require('dap.ext.vscode').json_decode = require('json5').parse
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- local telescope = require 'telescope'
    -- require('telescope').load_extension 'dap'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>dh', dapui.eval, { noremap = true, silent = true, desc = 'Debug: Evaluate' })
    -- vim.keymap.set('n', '<leader>db', function()
    --   telescope.extensions.dap.list_breakpoints()
    -- end, { noremap = true, silent = true, desc = 'Debug: List Breakpoints' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
    js_debugger_setup()
  end,
}

-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

-- local function read_vscode_launch_json()
--   if vim.fn.isdirectory '.vscode' == 0 then
--     return
--   end
--
--   local json_file = '.vscode/launch.json'
--   local json5 = require('json5').parse
--
--   local file = io.open(json_file, 'r')
--   if not file then
--     print('Failed to open file:', json_file)
--     return nil
--   end
--
--   local jsonc_data = file:read '*a'
--   file:close()
--
--   local obj = json5(jsonc_data)
--   if not obj then
--     print('Failed to parse JSON:', jsonc_data)
--     return nil
--   end
--
--   return obj
-- end

-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local function read_vscode_launch_json()
  if vim.fn.isdirectory '.vscode' == 0 then
    return
  end

  local json_file = '.vscode/launch.json'
  local json5 = require('json5').parse

  local file = io.open(json_file, 'r')
  if not file then
    print('Failed to open file:', json_file)
    return nil
  end

  local jsonc_data = file:read '*a'
  file:close()

  local obj = json5(jsonc_data)
  if not obj then
    print('Failed to parse JSON:', jsonc_data)
    return nil
  end

  return obj
end

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
    ['node'] = js_based_languages,
    ['chrome'] = js_based_languages,
    ['pwa-chrome'] = js_based_languages,
  })
  --
  -- local config_vscode = read_vscode_launch_json()
  -- if config_vscode ~= nil then
  --   for _, language in ipairs(js_based_languages) do
  --     require('dap').configurations[language] = config_vscode.configurations
  --   end
  -- end
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
        name = '----- ↓ launch.json configs ↓ -----',
        type = '',
        request = 'launch',
      },
    }
  end
end

local function rust_debugger_options()
  local dap = require 'dap'
  dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb',
    name = 'lldb',
  }

  dap.configurations.rust = {
    {
      name = 'Debug executable',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = function()
        local input = vim.fn.input 'Args: '
        return vim.fn.split(input, ' ') -- Split input into a table of arguments
      end,
      runInTerminal = false,
    },
  }
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
    ---
  },
  config = function()
    require('dap.ext.vscode').json_decode = require('json5').parse
    local dap = require 'dap'
    local dapui = require 'dapui'

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
    -- rust_debugger_options()
  end,
}

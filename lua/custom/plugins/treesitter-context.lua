return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      -- Enable this plugin (Can be enabled/disabled later via commands)
      enable = true,

      -- Enable multiwindow support.
      multiwindow = false,

      -- How many lines the window should span. Values <= 0 mean no limit.
      max_lines = 0,

      -- Minimum editor window height to enable context. Values <= 0 mean no
      -- limit.
      min_window_height = 0,

      -- Whether to show line numbers
      line_numbers = true,

      -- Maximum number of lines to show for a single context
      multiline_threshold = 20,

      -- Which context lines to discard if `max_lines` is exceeded.
      -- Choices: 'inner', 'outer'
      trim_scope = 'outer',

      -- Line used to calculate context.
      -- Choices: 'cursor', 'topline'
      mode = 'cursor',

      -- Separator between context and content. Should be a single character
      -- string, like '-'. When separator is set, the context will only show
      -- up when there are at least 2 lines above cursorline.
      separator = '⎼',

      -- The Z-index of the context window
      zindex = 20,

      -- (fun(buf: integer): boolean) return false to disable attaching
      on_attach = nil,
    }
  end,
}

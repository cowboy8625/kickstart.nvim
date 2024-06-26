vim.o.makeprg = 'cargo'

vim.cmd [[
setlocal errorformat=
                        \%f:%l:%c:\ %t%*[^:]:\ %m,
                        \%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
                        \%-G%f:%l\ %s,
                        \%-G%*[\ ]^,
                        \%-G%*[\ ]^%*[~],
                        \%-G%*[\ ]...

" New errorformat (after nightly 2016/08/10)
setlocal errorformat+=
                        \%-G,
                        \%-Gerror:\ aborting\ %.%#,
                        \%-Gerror:\ Could\ not\ compile\ %.%#,
                        \%Eerror:\ %m,
                        \%Eerror[E%n]:\ %m,
                        \%Wwarning:\ %m,
                        \%Inote:\ %m,
                        \%C\ %#-->\ %f:%l:%c

setlocal errorformat+=
                        \%-G%\\s%#Downloading%.%#,
                        \%-G%\\s%#Compiling%.%#,
                        \%-G%\\s%#Finished%.%#,
                        \%-G%\\s%#error:\ Could\ not\ compile\ %.%#,
                        \%-G%\\s%#To\ learn\ more\\,%.%#

]]

local function filtersQuickfixList()
  local quickfix_list = vim.fn.getqflist()
  local filtered = {}
  for _, v in ipairs(quickfix_list) do
    if v.type == 'E' then
      filtered[#filtered + 1] = {
        bufnr = v.bufnr,
        lnum = v.lnum,
        col = v.col,
        text = v.text,
      }
    end
  end

  vim.fn.setqflist(filtered)
end

local function openQuickfixListInTelescope()
  if #vim.fn.getqflist() == 0 then
    return
  end

  require('telescope.builtin').quickfix {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
      horizontal = { width = 0.9, height = 0.9 },
      vertical = { height = 0.9, width = 0.9 },
      preview_height = 0.7,
    },
  }
end

local function cargoRun()
  vim.cmd [[ silent! make run ]]
  filtersQuickfixList()
  openQuickfixListInTelescope()
end

local function cargoCheck()
  vim.cmd [[ silent! make check --workspace ]]
  filtersQuickfixList()
  openQuickfixListInTelescope()
end

local function cargoClippy()
  vim.cmd [[ silent! make clippy --workspace ]]
  filtersQuickfixList()
  openQuickfixListInTelescope()
end

vim.api.nvim_create_user_command('MyRustRun', cargoRun, { desc = 'Cargo Run' })
vim.api.nvim_create_user_command('MyRustCheck', cargoCheck, { desc = 'Cargo Check with Workspace' })
vim.api.nvim_create_user_command('MyRustClippy', cargoClippy, { desc = 'Cargo Clippy with Workspace' })

vim.keymap.set('n', ';;', ':MyRustRun<CR>')
vim.keymap.set('n', ';c', ':MyRustCheck<CR>')
vim.keymap.set('n', ';mc', ':MyRustClippy<CR>')

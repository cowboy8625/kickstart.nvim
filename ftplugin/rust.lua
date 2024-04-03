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
vim.keymap.set('n', ';;', ':make run<CR>')
vim.keymap.set('n', ';c', ':make check --workspace<CR>')
vim.keymap.set('n', ';mc', ':make clippy --workspace<CR>')

-- function OpenQuickfixList()
--   vim.api.nvim_cmd({ cmd = 'make', args = { 'check' } }, {})
--   vim.api.nvim_cmd({ cmd = 'Telescope', args = { 'quickfix' }, {})
-- end
--
-- vim.api.nvim_create_user_command('MyRustRun', OpenQuickfixList, {})

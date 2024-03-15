-- set makeprg=sbcl\ --script\ %
vim.cmd [[ set makeprg=python3\ % ]]
-- vim.api.nvim_set_var('makeprg', 'sbcl --script %')
vim.keymap.set('n', ';;', ':make<CR>')

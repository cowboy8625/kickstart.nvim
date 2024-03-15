-- set makeprg=sbcl\ --script\ %
vim.cmd [[ set makeprg=sbcl\ --script\ % ]]
-- vim.api.nvim_set_var('makeprg', 'sbcl --script %')
vim.keymap.set('n', ';;', ':make<CR>')

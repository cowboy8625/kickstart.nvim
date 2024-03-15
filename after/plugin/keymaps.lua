-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("t", "<c-k>", "<c-\\><c-n>:wincmd k<CR>")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n>:wincmd j<CR>")
vim.keymap.set("t", "<c-h>", "<c-\\><c-n>:wincmd h<CR>")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n>:wincmd l<CR>")

-- Spawn terminal at bottom of screen
vim.keymap.set("n", "<leader>;", ":belowright split | term<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")

-- vim.api.nvim_create_user_command("InsertDate", function()
-- 	local currentDateTime = vim.fn.system("date")
-- 	local trimmedDateTime = currentDateTime:gsub("^%s*(.-)%s*$", "%1")
-- 	vim.api.nvim_put({ trimmedDateTime }, "c", true, true)
-- end, {})
--
-- vim.keymap.set("i", "<F5>", "<C-o>:InsertDate<CR>")
-- vim.keymap.set("n", "<F5>", ":InsertDate<CR>")

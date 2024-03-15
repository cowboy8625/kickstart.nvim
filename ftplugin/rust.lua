-- vim.keymap.set('n', ';;', ':!cargo run --release<CR>')
-- vim.keymap.set('n', ';c', ':!cargo check --release --workspace<CR>')
-- function QfMakeConv()
--    echo "Rust Make"
-- endfunction

-- au QuickfixCmdPost make call QfMakeConv()

-- Creating an autocommand in 0.7
-- vim.api.nvim_create_autocmd("QuickfixCmdPost", {
--     pattern = "*.rs",
--     callback = function(args)
--         print("Entered buffer " .. args.buf .. "!")
--     end,
--     desc = "run cargo run",
-- })

--  vim.ui.select(
--    { 'Option 1', 'Option 2', 'Option 3' }, -- options for the user to pick
--    { prompt = 'Choose an option: ' }, -- prompt text
--    function(choice) -- callback function to handle the selection
--      if choice == 'Option 1' then
--        print 'You chose Option 1!'
--      elseif choice == 'Option 2' then
--        print 'You chose Option 2!'
--      elseif choice == 'Option 3' then
--        print 'You chose Option 3!'
--      else
--        print 'No valid option selected.'
--      end
--    end
--  )
-- vim.ui.open '~/.config/nvim/after/plugin/button.lua'
-- vim.ui.input({ prompt = 'Enter your name: ' }, function(name)
--   print('Hello, ' .. name .. '!')
-- end)
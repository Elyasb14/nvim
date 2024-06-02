-- hello_world.lua
local M = {}

function M.setup()
  vim.api.nvim_create_user_command('HelloWorld', M.hello_world, {})
end

function M.hello_world()
  print('Hello, World!')
end

return M

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
vim.lsp.enable('lua_ls')

vim.lsp.config["zls"] = {
    cmd = {'zls'},
    filetypes = {'zig', 'zir'},
}
vim.lsp.enable('zls')

local cmp = require 'cmp'
cmp.setup({
    completion = { completeopt = 'menu,menuone,noinsert' },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'path' },
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    -- Check if the client supports formatting
    if args.client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        group = augroup,
        callback = function()
          -- Format the buffer before saving
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

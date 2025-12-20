vim.pack.add {
    	'git@github.com:nvim-treesitter/nvim-treesitter',
	'git@github.com:neovim/nvim-lspconfig',
}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false

vim.treesitter.build = ':TSUpdate'
vim.treesitter.ensure_installed = {'zig', 'c', 'bash', 'lua'}
vim.treesitter.highlight = true

vim.lsp.config['lua-language-server'] = {
       -- Command and arguments to start the server.
       cmd = { 'lua-language-server' },
       -- Filetypes to automatically attach to.
       filetypes = { 'lua' },
       -- Sets the "workspace" to the directory where any of these files is found.
       -- Files that share a root directory will reuse the LSP server connection.
       -- Nested lists indicate equal priority, see |vim.lsp.Config|.
       root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
       -- Specific settings to send to the server. The schema is server-defined.
       -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
       settings = {
         Lua = {
           runtime = {
             version = 'LuaJIT',
           }
         }
       }
     }




     vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.lsp.start({
  name = 'lua_ls',
  cmd = {'L'},
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end,
})

vim.lsp.enable('lua_ls')

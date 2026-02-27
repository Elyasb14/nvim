--- @param name string LSP server name
--- @param cmd string[] Command to start the LSP server
--- @param filetypes string[] File types this server handles
--- @param settings table? Optional settings for the server
--- @param root_markers string[]? Optional root markers
--- @return nil
local function setup_lsp(name, cmd, filetypes, settings, root_markers)
    vim.lsp.config[name] = {
        cmd = cmd,
        filetypes = filetypes,
        root_markers = root_markers or {},
        settings = settings or {}
    }
    vim.lsp.enable(name)
end

setup_lsp('lua_ls', { 'lua-language-server' }, { 'lua' }, {
    Lua = { runtime = { version = 'LuaJIT' } }
}, { '.luarc.json', '.luarc.jsonc', '.git' })
setup_lsp('zls', { 'zls' }, { 'zig', 'zir' }, {})
setup_lsp('clangd', { 'clangd' }, { 'c' }, {})
setup_lsp('basedpyright', { 'basedpyright-langserver', '--stdio' }, { 'python' }, {},
    { 'pyproject.toml', 'setup.py', '.git' })

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

vim.diagnostic.config({
    signs = false, -- no letters in left bar
    virtual_text = true,
    underline = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", {}),
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
})

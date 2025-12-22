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
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspFormatting", {}),
    callback = function(event)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                -- format the buffer before saving
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
})

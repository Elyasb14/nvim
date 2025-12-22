vim.pack.add({
    'git@github.com:nvim-treesitter/nvim-treesitter',
    'git@github.com:neovim/nvim-lspconfig',
    'git@github.com:hrsh7th/nvim-cmp.git',
    'git@github.com:hrsh7th/cmp-nvim-lsp',
    'git@github.com:hrsh7th/cmp-path',
    'git@github.com:folke/tokyonight.nvim',
    'git@github.com:rose-pine/neovim'

})

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

local ts = require 'nvim-treesitter'
ts.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
    ensure_installed = { "zig", "c", "bash", "lua" },
    highlight = { enable = true },
    auto_install = true,
    build = ':TSUpdate',
})

-- highlight what you copied
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


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

local tn = require('tokyonight')
tn.setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = false },
        sidebars = "dark",
        floats = "dark",
    },
})

local rp = require('rose-pine')
rp.setup({
    disable_background = true,
    styles = {
        italic = false,
    },
})

vim.cmd.colorscheme('rose-pine')

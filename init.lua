vim.pack.add({
    'git@github.com:nvim-treesitter/nvim-treesitter',
    'git@github.com:neovim/nvim-lspconfig',
    'git@github.com:hrsh7th/nvim-cmp.git',
    'git@github.com:hrsh7th/cmp-nvim-lsp',
    'git@github.com:hrsh7th/cmp-path',
    'git@github.com:sainnhe/everforest',
    'git@github.com:junegunn/fzf',
    'git@github.com:junegunn/fzf.vim'

})

vim.g.mapleader = ' '
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-f>', ':Files<CR>', { desc = 'Fuzzy find files' })
vim.keymap.set('n', '<C-g>', ':Rg<CR>', { desc = 'Grep search in files' })
vim.keymap.set('n', '<C-m>', vim.cmd.Ex)

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
    ensure_installed = { "zig", "c", "cpp", "bash", "lua" },
    highlight = { enable = true },
    auto_install = true,
    sync_install = true,
    prefer_git = true,
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


require('lsp')
vim.cmd.colorscheme('everforest')

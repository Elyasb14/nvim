vim.pack.add {
    'git@github.com:nvim-treesitter/nvim-treesitter',
	'git@github.com:neovim/nvim-lspconfig',
    'git@github.com:hrsh7th/nvim-cmp.git',
    'git@github.com:hrsh7th/cmp-nvim-lsp',
    'git@github.com:hrsh7th/cmp-path',
    'git@github.com:folke/tokyonight.nvim',
'git@github.com:rose-pine/neovim'
}

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
  build = ':TSUpdate',
  indent = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

require("lsp")
require("color")


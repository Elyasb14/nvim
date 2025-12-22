local tn = require('tokyonight')
tn.setup({
              style = "night",
              transparent = true,
              terminal_colors = true,
              styles = {
                  comments = { italic = true},
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

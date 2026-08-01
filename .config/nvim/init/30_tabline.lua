vim.pack.add({ { src = 'https://github.com/echasnovski/mini.nvim.git' } })

-- vim.o.showtabline = 1
require('mini.tabline').setup({
    show_icons = false,
    tabpage_section = 'right',
})

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bold = false,  fg = "#ffe0ff"   })
vim.api.nvim_set_hl(0, 'MiniTablineVisible', { bold = false})

-- $ vim-startuptime -vimpath nvim | grep '^Total'
--
-- Total Average: 5.900700 msec
-- Total Max:     6.221000 msec
-- Total Min:     5.663000 msec

-- https://github.com/nullchilly/fsread.nvim
-- https://github.com/evanpurkhiser/image-paste.nvim

-- TODO
-- https://this-week-in-neovim.org/
--
-- https://github.com/adelarsq/image_preview.nvim
--
-- https://github.com/lewis6991/hover.nvim
--
-- netrw replace
-- https://github.com/miversen33/netman.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- https://www.reddit.com/r/neovim/comments/yfbfvu/sympy_luasnip_vimtex/
-- https://castel.dev/post/lecture-notes-1/

-- https://github.com/jakewvincent/mkdnflow.nvim
-- https://github.com/glepnir/easyformat.nvim
-- https://gitlab.com/HiPhish/nvim-ts-rainbow2
-- https://github.com/vimpostor/vim-tpipeline
-- https://github.com/Wansmer/treesj
-- https://github.com/Wansmer/sibling-swap.nvim

vim.cmd [[
let g:dbs = {
\  'tooljet': 'postgres://postgres:postgres@localhost:5432/tooljet_production'
\ }
]]

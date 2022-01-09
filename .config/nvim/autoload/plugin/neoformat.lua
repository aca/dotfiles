vim.cmd([[
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_go = ['gofumports']
packadd neoformat
]])

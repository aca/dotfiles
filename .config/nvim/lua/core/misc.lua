vim.g.github_enterprise_urls = {
    "https://git" .. "hub.t" .. "os" .. "sin" .. "ve" .. "st.bz",
}

vim.cmd.packadd 'plenary.nvim'
vim.cmd.packadd 'tree-sitter-just'

-- vim.cmd.packadd 'telescope.nvim'
-- vim.cmd.packadd "telescope-fzf-native.nvim"
-- vim.cmd.packadd "telescope-hop.nvim"

-- vim.cmd.packadd 'clever-f.vim'


vim.cmd([[
" packadd vim-scriptease
" packadd vim-characterize
" packadd vim-rfc
" packadd symbols-outline.nvim
" packadd vim-diagon
" packadd bufferize.vim
" packadd diffview.nvim
" packadd nvim-colorizer.lua
" packadd todo-comments.nvim
" packadd webapi-vim
" packadd vim-gist

command! Codi packadd codi.vim | :Codi
command! Luapad packadd nvim-luapad | :Luapad

" packadd vim-boxdraw
" packadd vim-markdown-toc
packadd vim-dirdiff
]])

-- edit
vim.cmd.packadd 'quickfix-reflector.vim'
vim.cmd.packadd 'vim-ReplaceWithRegister'
vim.cmd.packadd 'vim-eunuch'

vim.cmd([[
" vim-swap
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
]])

-- navigate
vim.cmd([[
packadd vim-fetch " TODO: replace or mv to start

let g:nf_map_next=']f'
let g:nf_map_previous='[f'
packadd nextfile.vim
packadd vim-dirvish
]])

-- etc
vim.cmd([[
imap <silent><c-d> <c-r>=strftime("## %Y-%m-%d %a %H:%M:%S %Z")<cr><cr>
]])

-- vim.o.cmdheight = 2
vim.o.laststatus = 3

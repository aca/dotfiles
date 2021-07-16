" vim: foldmethod=marker

" PAQ {{{
command PaqInstall call <sid>loadPaq() | :PaqInstall
command PaqClean   call <sid>loadPaq() | :PaqClean
command PaqUpdate  call <sid>loadPaq() | :PaqUpdate

function s:loadPaq()
  if empty(glob('~/.local/share/nvim/site/pack/paqs/opt/paq-nvim'))
    silent !git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/opt/paq-nvim
  endif
  packadd paq-nvim
lua << EOF
local paq = require'paq-nvim'.paq

-- paq {'axvr/photon.vim'}
-- paq {'chriskempson/base16-vim'}

paq {'kristijanhusak/orgmode.nvim'}

-- paq 'gelguy/wilder.nvim' -- TODO
paq {'aca/nvim-colors'}

paq {'gennaro-tedesco/nvim-peekup', opt=true}
paq {'lambdalisue/pastefix.vim', opt=true}

-- paq {'lukas-reineke/indent-blankline.nvim', opt=true}
-- paq {'Yggdroot/indentLine', opt=true}

paq {'ojroques/vim-oscyank', opt=true}

paq {'glacambre/firenvim', opt=true, run=vim.fn['firenvim#install(0)'] }
paq {'tzachar/compe-tabnine', run='./install.sh'}
paq {'heapslip/vimage.nvim'}
paq {'nacro90/numb.nvim', opt=true}

-- paq {'tyru/columnskip.vim'}
paq {'inkarkat/vim-ReplaceWithRegister', opt=true}
paq {'norcalli/nvim-colorizer.lua', opt=true}
paq {'ap/vim-buftabline', opt=true}
paq {'norcalli/nvim-terminal.lua', opt=true}
paq {'savq/paq-nvim', opt=true}
paq {'aca/funcs.nvim', opt=true}
paq {'aca/vidir.nvim'}
paq {'phaazon/hop.nvim', opt=true} -- easymotion
paq {'dstein64/nvim-scrollview', opt=true}
paq {'rhysd/clever-f.vim', opt=true}
paq {'vifm/vifm.vim', opt=true} -- replaced with floaterm
paq {'voldikss/vim-floaterm', opt=true}
paq {'wsdjeg/vim-fetch', opt=true}
paq {'mhinz/vim-startify', opt=true}
paq {'gyim/vim-boxdraw', opt=true}
paq {'aca/xdg_open.vim', opt=true}
paq {'arecarn/vim-fold-cycle', opt=true}
paq {'RyanMillerC/better-vim-tmux-resizer', opt=true}

paq {'rafcamlet/nvim-luapad', opt=true}
paq {'folke/lua-dev.nvim'}

paq {'vim-test/vim-test', opt=true}

paq {'christoomey/vim-tmux-navigator', opt=true}
paq {'junegunn/fzf', opt=true}
paq {'junegunn/fzf.vim', opt=true}

paq {'justinmk/vim-dirvish'}

paq {'hrsh7th/vim-vsnip'}
paq {'hrsh7th/nvim-compe'}
-- paq {'andersevenrud/compe-tmux'}
paq {'ray-x/lsp_signature.nvim'}
paq {'pylance', url="git@git.sr.ht:~acadx0/pylance"}
paq {'neovim/nvim-lspconfig'}
paq {'stevearc/aerial.nvim'}
-- paq {'glepnir/lspsaga.nvim', opt=true}

-- paq {'camspiers/snap'}

paq {'stefandtw/quickfix-reflector.vim', opt=true}
paq {'lambdalisue/suda.vim', opt=true}
paq {'RREthy/vim-illuminate', opt=true}

paq {'arp242/switchy.vim', opt=true}

paq {'psliwka/vim-smoothie', opt=true}
-- paq {'tzachar/compe-tabnine', hook='./install.sh'}

-- paq 'simrat39/symbols-outline.nvim'

paq {'tommcdo/vim-lion', opt=true}
paq {'machakann/vim-sandwich', opt=true}
-- paq {'machakann/vim-sandwich'}
-- paq {'b3nj5m1n/kommentary', opt=true}
-- paq {'terrortylor/nvim-comment', opt=true}
-- paq {'tpope/vim-commentary', opt=true}
paq {'tomtom/tcomment_vim', opt=true}

-- TODO: replace with https://github.com/AndrewRadev/sideways.vim
paq {'matze/vim-move', opt=true}
paq {'machakann/vim-swap', opt=true}
paq {'aca/fzf-proj.vim', opt=true}
-- paq {'tmsvg/pear-tree', opt=true}
paq {'windwp/nvim-autopairs', opt=true}
-- paq {"steelsojka/pears.nvim", opt=true}

-- paq {'glepnir/galaxyline.nvim', branch='main'}
-- paq 'kyazdani42/nvim-web-devicons'

-- paq {"cohama/lexima.vim"}
paq {'dhruvasagar/vim-table-mode', opt=true}
paq {'tpope/vim-sleuth', opt=true} -- detect indent
paq {'sbdchd/neoformat', opt=true}
paq {'metakirby5/codi.vim', opt=true}
paq {'pedrohdz/vim-yaml-folds', opt=true}
paq {'ferrine/md-img-paste.vim', opt=true}
paq {'buoto/gotests-vim', opt=true}
paq {'110y/vim-go-expr-completion', opt=true}
paq {'iamcco/markdown-preview.nvim', opt=true, run='yarn install --cwd app/' }
-- paq {'tpope/vim-markdown', opt=true}
paq {'tweekmonster/startuptime.vim', opt=true}

-- https://github.com/Pocco81/TrueZen.nvim
paq {'folke/zen-mode.nvim', opt=true}


paq {'monaqa/dial.nvim', opt=true}
-- paq {'tpope/vim-speeddating', opt=true}
paq {'thinca/vim-quickrun', opt=true}

-- git
paq {'lambdalisue/gina.vim', opt=true}
-- paq {'tpope/vim-fugitive'}
-- paq {'junegunn/gv.vim'}
paq {'cohama/agit.vim', opt=true}
paq {'mhinz/vim-signify', opt=true}
paq {'rhysd/git-messenger.vim', opt=true}
paq {'sindrets/diffview.nvim', opt=true}

-- paq {'Rasukarusan/nvim-block-paste', opt=true}
paq { 'nvim-lua/plenary.nvim', opt=true}
paq { 'lewis6991/gitsigns.nvim', opt=true}

paq {'axvr/zepl.vim', opt=true}
paq {'jbyuki/venn.nvim', opt=true}
-- paq {'yamatsum/nvim-cursorline', opt=true}

-- Language specific
-- https://github.com/sheerun/vim-polyglot
paq {'lervag/vimtex', opt=true}
paq {'aca/nvim-go', opt=true}
paq {'mattn/vim-goaddtags', opt=true}

-- paq {'Raku/vim-raku'}
-- paq {'neovimhaskell/haskell-vim'}
-- paq {'vmchale/just-vim'}
paq {'aca/vim-fish'}
-- paq {'ziglang/zig.vim'}
-- paq {'rust-lang/rust.vim'}
-- paq {'wlangstroth/vim-racket'}
-- paq {'plasticboy/vim-markdown', opt=true}
-- paq {'rhysd/vim-gfm-syntax', opt=true} -- markdown
-- paq {'rhysd/vim-gfm-syntax'} -- markdown
-- paq {'gabrielelana/vim-markdown', opt=true}
-- paq {'gabrielelana/vim-markdown'}
-- paq {'masukomi/vim-markdown-folding'}
-- paq {'rafkaplon/vim-markdown-folding', opt=true}
-- paq {'plasticboy/vim-markdown', opt=true}
paq {'vim-pandoc/vim-pandoc-syntax'}

paq {'xolox/vim-colorscheme-switcher', opt=true}
paq {'xolox/vim-misc', opt=true}

-- TODO! https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- paq {'JoosepAlviste/nvim-ts-context-commentstring'}
paq {'nvim-treesitter/nvim-treesitter', run=vim.api.nvim_command('TSUpdate')}
paq {'p00f/nvim-ts-rainbow'}
-- paq {'nvim-treesitter/nvim-treesitter'}

paq {'nvim-treesitter/playground'}

-- paq {'haringsrob/nvim_context_vt'}
paq {'ThePrimeagen/git-worktree.nvim', opt=true}
paq {'mfussenegger/nvim-dap'}
paq {'rcarriga/nvim-dap-ui'}
paq {'theHamsta/nvim-dap-virtual-text'}

EOF
endfunction
" }}}

" inkarkat/vim-ReplaceWithRegister {{{
" [count]["x]gr{motion}   Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr          Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr          Replace the selection with the contents of register x.
" nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
" nmap <Leader>rr <Plug>ReplaceWithRegisterLine
" xmap <Leader>r  <Plug>ReplaceWithRegisterVisual
packadd vim-ReplaceWithRegister
" }}}

" machakann/vim-swap {{{
let g:swap_no_default_key_mappings = 1
packadd vim-swap
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
" }}}


packadd diffview.nvim
packadd vim-smoothie
packadd hop.nvim
packadd clever-f.vim
packadd tcomment_vim
packadd vim-fold-cycle
" packadd vim-oscyank
packadd firenvim
" packadd vim-sleuth
packadd pastefix.vim
packadd vim-illuminate
packadd vim-fetch
packadd funcs.nvim
packadd nvim-colorizer.lua
packadd codi.vim

packadd xdg_open.vim
let g:xdg_open_command='xdg-open'
let g:netrw_browsex_viewer='xdg-open'

let test#strategy = "neovim"
packadd vim-test

command! Grammar packadd vim-grammarous | :GrammarousCheck

" vim-quickrun {{{
let g:quickrun_no_default_key_mappings=1
let g:quickrun_config = {
      \'*': {
      \'outputter/buffer/split': ':10split'}}
packadd vim-quickrun
nnoremap <silent><Leader>r :QuickRun -mode n<cr>
vnoremap <silent><Leader>r :QuickRun -mode v<cr>
" }}}

" https://github.com/tommcdo/vim-lion {{{
" https://github.com/tommcdo/vim-lion/pull/28/files
let g:lion_squeeze_spaces = 1
packadd vim-lion
" }}}

" https://github.com/lewis6991/gitsigns.nvim {{{
packadd plenary.nvim
packadd gitsigns.nvim
lua <<EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  current_line_blame = false,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}
EOF
" }}}


" https://github.com/steelsojka/pears.nvim {{{
" packadd pears.nvim 
" lua require("pears").setup()
" lua require("pears").attach()
" }}}

" zepl.vim {{{
let g:repl_config = {
            \   'python': {
            \     'cmd': 'ipython',
            \     'formatter': function('zepl#contrib#python#formatter')
            \   }
            \ }
packadd zepl.vim
runtime zepl/contrib/python.vim  " Enable the Python contrib module.
runtime zepl/contrib/nvim_autoscroll_hack.vim
" }}}

" matze/vim-move {{{
let g:move_map_keys = 0
packadd vim-move
vmap <M-j> <Plug>MoveBlockDown
vmap <M-k> <Plug>MoveBlockUp
vmap <M-h> <Plug>MoveBlockLeft
vmap <M-l> <Plug>MoveBlockRight

vmap <A-s> <Plug>MoveBlockDown
vmap <A-w> <Plug>MoveBlockUp
vmap <A-a> <Plug>MoveBlockLeft
vmap <A-d> <Plug>MoveBlockRight

nmap <M-s> <Plug>MoveLineDown
nmap <M-w> <Plug>MoveLineUp
nmap <M-a> <Plug>MoveCharLeft
nmap <M-d> <Plug>MoveCharRight
" }}}

" https://github.com/gennaro-tedesco/nvim-peekup {{{
packadd nvim-peekup
lua require('nvim-peekup.config').on_keystroke["delay"] = ''
" }}}

" lambdalisue/gina.vim {{{
packadd gina.vim
cnoreabbrev Git Gina
command! Gbrowse execute "normal! vv" | :'<,'>Gina browse --exact :
command! Glog :Gina log -- %:p
command! Agit :packadd agit.vim | :Agit

" let g:gina#process#command='git'

" gina show always in vsplit
call gina#custom#command#option(
        \ '/\%(show\)',
        \ '--opener', 'vsplit'
        \)

" gina show close with q
call gina#custom#mapping#nmap(
        \ 'show', 'q',
        \ ':q<CR>',
        \ {'noremap': 1, 'silent': 1},
        \)

call gina#custom#mapping#nmap(
        \ 'log', 'd',
        \ ':execute printf(":new term://git diff %s \| resize +10", gina#action#candidates()[0].rev)<cr>',
        \ {'noremap': 1, 'silent': 1},
        \)

call gina#custom#mapping#nmap(
        \ 'log', 'q',
        \ ':bd<CR>',
        \ {'noremap': 1, 'silent': 1},
        \)

" %domain in the acceptable url pattern list will be substituted into
" 'gitlab.hashnote.net'
" '_' of a url translation scheme dictionary is used as a default
" scheme
" '^' of a url translation scheme dictionary is used as a repository
" scheme
call extend(g:gina#command#browse#translation_patterns, {
    \ 'k8s.io': [
    \   [
    \     '\vhttps?://(%domain)/(.{-})/(.{-})%(\.git)?$',
    \     '\vgit://(%domain)/(.{-})/(.{-})%(\.git)?$',
    \     '\vgit\@(%domain):(.{-})/(.{-})%(\.git)?$',
    \     '\vssh://git\@(%domain)/(.{-})/(.{-})%(\.git)?$',
    \   ], {
    \     'root':  'https://\1/\2/\3/tree/%r1/',
    \     '_':     'https://\1/\2/\3/blob/%r1/%pt%{#L|}ls%{-}le',
    \     'exact': 'https://\1/\2/\3/blob/%h1/%pt%{#L|}ls%{-}le',
    \   },
    \ ],
    \})

" }}}

" bronson/vim-visual-star-search {{{
function! VisualStarSearchSet(cmdtype,...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction
xnoremap * :<C-u>call VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>
" }}}

" dstein64/nvim-scrollview {{{
" autocmd CursorHold * packadd nvim-scrollview | :ScrollViewEnable
" let g:scrollview_winblend=20
" let g:scrollview_base='right'
" }}}

" mhinz/vim-signify {{{
" let g:signify_sign_show_text = 1
" let g:signify_sign_show_count = 0
" " let g:signify_disable_by_default = 1
" highlight! SignifySignAdd    ctermfg=green  guifg=#696969 cterm=NONE guibg=NONE
" highlight! SignifySignDelete ctermfg=red    guifg=#696969 cterm=NONE guibg=NONE
" highlight! SignifySignChange ctermfg=yellow guifg=#696969 cterm=NONE guibg=NONE
" nmap <silent> ]h <plug>(signify-next-hunk)
" nmap <silent> [h <plug>(signify-prev-hunk)
" autocmd User DeferLoad packadd vim-signify | :SignifyEnable
" }}}

" dial.nvim {{{
packadd dial.nvim
lua << EOF
local dial = require("dial")
dial.config.searchlist.normal = {
    "number#decimal",
    "number#hex",
    "number#binary",
    "number#decimal#fixed#zero",
    "number#decimal#fixed#space",
    "date#[%Y/%m/%d]",
    "markup#markdown#header",
    "char#alph#small#str",
}
EOF
" }}}

" rafcamlet/nvim-luapad {{{
command Luapad packadd nvim-luapad | :Luapad
" }}}

" phaazon/hop.nvim {{{
" nmap <silent><Leader>w :HopWord<cr>
" }}}

" lambdalisue/suda.vim {{{
command! SudoWrite packadd suda.vim | :SudaWrite
command! SudoRead packadd suda.vim | :SudaRead
" }}}

" https://github.com/rhysd/git-messenger.vim {{{
command! GitMessenger packadd git-messenger.vim | :GitMessenger
nnoremap gm :GitMessenger<cr>
" }}}

" STARTIFY {{{
function s:startify()
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  " same as above, but show untracked files, honouring .gitignore
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  let g:startify_change_to_vcs_root = 1
  let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
          \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
  let g:startify_custom_header = ''
  packadd vim-startify
endfunction
nnoremap <silent><leader>x :call <sid>startify()\|Startify<cr>
" }}}

" settings {{{
" if there's no other window but quickfix close it
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

" set formatoptions-=ro

" Highlight TODO
autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)

" Autoclose terminal without prompt
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" https://stackoverflow.com/questions/630884/opening-vim-help-in-a-vertical-split-window
" au FileType help wincmd L

" 0 goes to first https://github.com/yuki-yano/zero.nvim/blob/main/lua/zero.lua
lua vim.api.nvim_set_keymap('n', '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

" }}}

" GO {{{
" open test (toggle test)
nnoremap <silent> <leader>tt :call switchy#switch('edit', 'edit')<CR>
" }}}

let g:dap_virtual_text = v:true
lua << EOF
local dap = require('dap')

dap.set_log_level('TRACE')

dap.adapters.go = function(callback, config)
  local handle
  local pid_or_err
  local port = 38697
  handle, pid_or_err =
    vim.loop.spawn(
    "dlv",
    {
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    },
    function(code)
      handle:close()
      print("Delve exited with exit code: " .. code)
    end
  )
  -- Wait 100ms for delve to start
  vim.defer_fn(
    function()
      --dap.repl.open()
      callback({type = "server", host = "127.0.0.1", port = port})
    end,
    500)
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    mode = "test",
    request = "launch",
    program = "./${relativeFileDirname}",
  },
}
EOF

packadd zen-mode.nvim
nnoremap <silent> <bslash>z :ZenMode<CR>
lua << EOF
  require("zen-mode").setup {
    plugins = {
        gitsigns = { enabled = true },
      },
  }
EOF

" DAP  {{{
nnoremap <silent> 'c :lua require'dap'.continue()<CR>
nnoremap <silent> 'n :lua require'dap'.step_over()<CR>
nnoremap <silent> 'i :lua require'dap'.step_into()<CR>
nnoremap <silent> 'o :lua require'dap'.step_out()<CR>
nnoremap <silent> 'b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

function s:dap()
  lua require("dapui").setup()
  lua require("dapui").open()
endfunction

command Dap call s:dap()
" cnoreabbrev dap Dap
" }}}

" GREP {{{
" call grepprg in a system shell instead of internal shell
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

set grepprg=rg\ --vimgrep\ --no-heading
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
" }}}
"
" VIFM {{{
function s:vifm()
  let g:floaterm_opener="edit"
  packadd vim-floaterm
  if expand('%:p') != "" 
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm --select '%:p'
  else
    FloatermNew --height=0.9 --width=0.9 --title=vifm vifm -c ':vs |:tree! | :view! | set nodotfiles'
  end
endfunction

" https://vi.stackexchange.com/questions/17901/how-to-make-neovim-to-not-show-the-process-exited-num-when-quitting-a-term
" autocmd TermClose * :bd!

au FileType floaterm tnoremap <buffer> <Esc> <c-c>
command! DiffVifm packadd vifm.vim | :DiffVifm
nnoremap <silent><c-e> <cmd>call <sid>vifm()<cr>
" }}}

" vim-sandwich {{{
packadd vim-sandwich

" sa surround add
" sd surround delete
" sr surround replace
" vim-surround replacement
runtime macros/sandwich/keymap/surround.vim

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
      \   {
      \     'buns'    : ['print(', ')'],
      \     'filetype': ['python'],
      \     'nesting' : 0,
      \     'input'   : ['p', 'P'],
      \   },
      \   {
      \     'buns'    : ['fmt.Printf(', ')'],
      \     'filetype': ['go'],
      \     'nesting' : 0,
      \     'input'   : ['p', 'P'],
      \   },
      \   {
      \     'buns'    : ['log.Print(', ')'],
      \     'filetype': ['go'],
      \     'nesting' : 0,
      \     'input'   : ['l', 'L'],
      \   },
      \   {
      \     'buns'    : ['
      \```', '```
      \'],
      \     'filetype': ['markdown'],
      \     'nesting' : 0,
      \     'input'   : ['c','C'],
      \   },
      \   {
      \     'buns'    : ['[](', ')'],
      \     'filetype': ['markdown'],
      \     'nesting' : 0,
      \     'input'   : ['l','L'],
      \   },
      \   {
      \     'buns'    : ['console.log(', ')'],
      \     'filetype': ['javascript','typescript'],
      \     'nesting' : 0,
      \     'input'   : ['p', 'P'],
      \   },
      \   {
      \     'buns'    : ['print(', ')'],
      \     'filetype': ['lua'],
      \     'nesting' : 0,
      \     'input'   : ['p', 'P'],
      \   },
      \ ]
" }}}

" RyanMillerC/better-vim-tmux-resizer {{{
packadd better-vim-tmux-resizer
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <m-h> <cmd>TmuxResizeLeft<cr>
nnoremap <silent> <m-j> <cmd>TmuxResizeDown<cr>
nnoremap <silent> <m-k> <cmd>TmuxResizeUp<cr>
nnoremap <silent> <m-l> <cmd>TmuxResizeRight<cr>
" }}}

" christoomey/vim-tmux-navigator {{{
packadd vim-tmux-navigator
nnoremap <silent> <c-h> <cmd>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> <cmd>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> <cmd>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> <cmd>TmuxNavigateRight<cr>

tnoremap <c-h> <C-\><C-N><cmd>TmuxNavigateLeft<cr>
tnoremap <c-j> <C-\><C-N><cmd>TmuxNavigateDown<cr>
tnoremap <c-k> <C-\><C-N><cmd>TmuxNavigateUp<cr>
tnoremap <c-l> <C-\><C-N><cmd>TmuxNavigateRight<cr>
" }}}

" aca/funcs.nvim {{{
xmap s :SortVis<CR>
nnoremap yp :YankPath<cr>
" }}}

" https://github.com/nacro90/numb.nvim {{{
packadd numb.nvim
lua require('numb').setup()
" }}}

" https://github.com/windwp/nvim-autopairs {{{
packadd nvim-autopairs 
lua <<EOF
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

require('nvim-autopairs').setup({
  check_ts = true
})
EOF
" }}}

" treesitter {{{
lua <<EOF
if os.getenv("USER") == "rok" then
  require'nvim-treesitter.configs'.setup{
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 200, -- Do not enable for files with more than 1000 lines, int
    },
    -- ensure_installed = "all",
    ensure_installed = "maintained",
    autopairs = {enable = true},
    highlight = {
      enable = true,
    },
  }
end
EOF
" }}}

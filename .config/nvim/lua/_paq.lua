require "paq" {
    {"savq/paq-nvim"},

    {"kristijanhusak/vim-dadbod-ui", opt=true},
    {"kristijanhusak/vim-dadbod-completion"},
    {"tpope/vim-dadbod", opt=true},

    {"kristijanhusak/orgmode.nvim"},
    -- paq 'gelguy/wilder.nvim' -- TODO
    {"aca/nvim-colors"},
    {"gennaro-tedesco/nvim-peekup", opt = true},
    {"lambdalisue/pastefix.vim", opt = true},
    -- paq {'lukas-reineke/indent-blankline.nvim', opt=true},
    -- paq {'Yggdroot/indentLine', opt=true},

    {"ojroques/vim-oscyank", opt = true},
    -- paq {'glacambre/firenvim', opt=true, run=vim.fn['firenvim#install(0)'] },
    {"tzachar/compe-tabnine", run = "./install.sh"},
    {"nacro90/numb.nvim", opt = true},
    -- paq {'tyru/columnskip.vim'},
    {"inkarkat/vim-ReplaceWithRegister", opt = true},
    {"norcalli/nvim-colorizer.lua", opt = true},
    {"ap/vim-buftabline", opt = true},
    {"norcalli/nvim-terminal.lua", opt = true},
    {"aca/vidir.nvim"},
    {"phaazon/hop.nvim", opt = true}, -- easymotion
    {"dstein64/nvim-scrollview", opt = true},
    {"rhysd/clever-f.vim", opt = true},
    {"vifm/vifm.vim", opt = true}, -- replaced with floaterm
    {"voldikss/vim-floaterm", opt = true},
    {"wsdjeg/vim-fetch", opt = true},
    {"mhinz/vim-startify", opt = true},
    {"gyim/vim-boxdraw", opt = true},
    {"aca/xdg_open.vim", opt = true},
    {"arecarn/vim-fold-cycle", opt = true},
    {"RyanMillerC/better-vim-tmux-resizer", opt = true},
    {"rafcamlet/nvim-luapad", opt = true},
    {"folke/lua-dev.nvim"},
    {"vim-test/vim-test", opt = true},
    {"christoomey/vim-tmux-navigator", opt = true},
    {"junegunn/fzf", opt = true},
    {"junegunn/fzf.vim", opt = true},
    {"justinmk/vim-dirvish"},
    {"hrsh7th/vim-vsnip"},
    -- {'andersevenrud/compe-tmux'},
    {"ray-x/lsp_signature.nvim"},
    {"pylance", url = "git@git.sr.ht:~acadx0/pylance"},
    {"neovim/nvim-lspconfig"},
    -- {"stevearc/aerial.nvim"},
    {"kabouzeid/nvim-lspinstall", opt = true},

    {"stefandtw/quickfix-reflector.vim", opt = true},
    {"tpope/vim-eunuch", opt = true},
    {"lambdalisue/suda.vim", opt = true},

    {"RREthy/vim-illuminate", opt = true},
    {"arp242/switchy.vim", opt = true},
    {"psliwka/vim-smoothie", opt = true},

    {"tommcdo/vim-lion", opt = true},
    {"machakann/vim-sandwich", opt = true},
    {"tomtom/tcomment_vim", opt = true},
    -- TODO: replace with https://github.com/AndrewRadev/sideways.vim
    {"matze/vim-move", opt = true},
    {"machakann/vim-swap", opt = true},
    {"aca/fzf-proj.vim", opt = true},
    -- paq {'tmsvg/pear-tree', opt=true},
    {"windwp/nvim-autopairs", opt = true},
    -- paq {"steelsojka/pears.nvim", opt=true},

    -- paq {'glepnir/galaxyline.nvim', branch='main'},
    -- paq 'kyazdani42/nvim-web-devicons'

    {"dhruvasagar/vim-table-mode", opt = true},
    {"tpope/vim-sleuth", opt = true}, -- detect indent
    {"sbdchd/neoformat", opt = true},
    {"metakirby5/codi.vim", opt = true},
    {"pedrohdz/vim-yaml-folds", opt = true},
    {"ferrine/md-img-paste.vim", opt = true},
    {"buoto/gotests-vim", opt = true},
    {"110y/vim-go-expr-completion", opt = true},
    {"iamcco/markdown-preview.nvim", opt = true, run = "yarn install --cwd app/"},
    -- paq {'tpope/vim-markdown', opt=true},
    {"tweekmonster/startuptime.vim", opt = true},
    -- https://github.com/Pocco81/TrueZen.nvim
    {"folke/zen-mode.nvim", opt = true},
    {"monaqa/dial.nvim", opt = true},
    -- paq {'tpope/vim-speeddating', opt=true},
    {"thinca/vim-quickrun", opt = true},
    -- git
    {"lambdalisue/gina.vim", opt = true},
    -- paq {'tpope/vim-fugitive'},
    -- paq {'junegunn/gv.vim'},
    {"cohama/agit.vim", opt = true},
    {"mhinz/vim-signify", opt = true},
    {"rhysd/git-messenger.vim", opt = true},
    {"sindrets/diffview.nvim", opt = true},
    -- paq {'Rasukarusan/nvim-block-paste', opt=true},
    {"nvim-lua/plenary.nvim"},
    {"lewis6991/gitsigns.nvim", opt = true},
    {"axvr/zepl.vim", opt = true},
    {"jbyuki/venn.nvim", opt = true},
    -- paq {'yamatsum/nvim-cursorline', opt=true},

    -- Language specific
    -- https://github.com/sheerun/vim-polyglot
    {"lervag/vimtex", opt = true},
    {"aca/nvim-go", opt = true},
    {"mattn/vim-goaddtags", opt = true},
    -- paq {'Raku/vim-raku'},
    -- paq {'neovimhaskell/haskell-vim'},
    -- paq {'vmchale/just-vim'},
    {"aca/vim-fish"},
    -- paq {'ziglang/zig.vim'},
    -- paq {'rust-lang/rust.vim'},
    -- paq {'wlangstroth/vim-racket'},
    {"plasticboy/vim-markdown", opt = true},
    -- paq {'rhysd/vim-gfm-syntax', opt=true}, -- markdown
    -- paq {'rhysd/vim-gfm-syntax'}, -- markdown
    -- paq {'gabrielelana/vim-markdown', opt=true},
    -- paq {'gabrielelana/vim-markdown'},
    -- paq {'masukomi/vim-markdown-folding'},
    -- paq {'rafkaplon/vim-markdown-folding', opt=true},
    -- paq {'plasticboy/vim-markdown', opt=true},
    -- paq {'vim-pandoc/vim-pandoc-syntax'},

    {"xolox/vim-colorscheme-switcher", opt = true},
    {"xolox/vim-misc", opt = true},
    -- TODO! https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    -- paq {'JoosepAlviste/nvim-ts-context-commentstring'},
    {"nvim-treesitter/nvim-treesitter", run = function()
            vim.api.nvim_command("TSUpdate")
        end},
    {"p00f/nvim-ts-rainbow"},
    {"nvim-treesitter/playground", opt=true},
    --  DAP
    -- paq {'haringsrob/nvim_context_vt'},
    {"mfussenegger/nvim-dap"},
    {"rcarriga/nvim-dap-ui"},
    -- {"theHamsta/nvim-dap-virtual-text"},
    {"ThePrimeagen/git-worktree.nvim", opt = true}
}

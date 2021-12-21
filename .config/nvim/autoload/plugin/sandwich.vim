packadd vim-sandwich
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

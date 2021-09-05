vim.cmd [[
  packadd vim-oscyank
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' |  silent OSCYankReg " | endif
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | silent OSCYankReg + | endif
]]

set foldmethod=manual
augroup remember_folds
  autocmd!
  autocmd BufWinLeave ?* mkview 1
  autocmd BufWinEnter ?* silent! loadview 1
augroup END

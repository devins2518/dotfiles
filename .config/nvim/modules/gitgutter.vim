function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

set t_u7=
autocmd BufEnter * :GitGutterLineNrHighlightsDisable
autocmd BufEnter * :GitGutterSignsEnable
let g:gitgutter_max_signs = 500  " default value (Vim < 8.1.0614, Neovim < 0.4.0)

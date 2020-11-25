" Theme settings
set background=dark
colorscheme codedark
" Enables 256b colors for terminals
set t_Co=256

" Color column
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set number

syntax on

set listchars=tab:▸\ ,eol:¬
set list " To enable by default

highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

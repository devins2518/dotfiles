" coc config
let g:coc_global_extensions = [
  \ 'coc-rust-analyzer',
  \ 'coc-pairs',
  \ 'coc-snippets',
  \ 'coc-python',
  \ 'coc-json',
  \ 'coc-sh',
  \ 'coc-clangd',
  \ ]

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> gb <C-^>

" Commands for lspconfigs
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>                 
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>                      
"nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>             
"nnoremap <silent> gs    <cmd>lua vim.lsp.buf.signature_help()<CR>             
"nnoremap <silent> gy  <cmd>lua vim.lsp.buf.type_definition()<CR>            
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>                 
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>            
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>           
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>


" Show documentation
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

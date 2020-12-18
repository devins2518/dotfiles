nnoremap <silent> gb <C-^>

autocmd BufEnter * lua require'completion'.on_attach()
" Use up and down arrows to navigate through popup menu (yes I know...)
inoremap <expr> <Down>   pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

let g:completion_confirm_key = ""
imap <expr> <tab>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<tab>" :  "\<tab>"

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noinsert

" Avoid showing message extra message when using completion
set shortmess+=c

imap <silent> <c-Space> <Plug>(completion_trigger)

let g:completion_trigger_keyword_length = 1
let g:completion_trigger_on_delete = 1

let g:completion_matching_strategy_list = ['exact', 'substring', 'all']
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'vim-vsnip']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
let g:completion_matching_smart_case = 1
let g:completion_timer_cycle = 80 " Most lower values will peg 1 core to 100%

call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})

" diagnostic-nvim
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_virtual_text_prefix = ' '
let g:diagnostic_trimmed_virtual_text = 0
let g:diagnostic_insert_delay = 1

" completion-nvim
let g:completion_enable_auto_hover = 1
let g:completion_auto_change_source = 1

let g:completion_max_items = "10"
let g:completion_enable_auto_paren = "1"
set complete=.,w,b,u

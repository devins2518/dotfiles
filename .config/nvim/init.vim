let mapleader = "\<Space>"
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>
set mouse=a

source $HOME/.config/nvim/modules/plugins.vim
source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/ctrlp.vim
source $HOME/.config/nvim/modules/gitgutter.vim
source $HOME/.config/nvim/modules/nerdtree.vim
source $HOME/.config/nvim/modules/vim-airline.vim
source $HOME/.config/nvim/modules/vim-devicons.vim
source $HOME/.config/nvim/modules/rainbow.vim
source $HOME/.config/nvim/modules/theme.vim
"luafile $HOME/.config/nvim/modules/lsp.lua

"nmap <tab> <Plug>(completion_smart_tab)
"nmap <s-tab> <Plug>(completion_smart_s_tab)
"let g:completion_trigger_on_delete = 1
"let g:diagnostic_enable_virtual_text = 1
"let g:diagnostic_auto_popup_while_jump = 1
"let g:diagnostic_insert_delay = 1
"" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert

"" Avoid showing message extra message when using completion
"set shortmess+=c

"let g:completion_confirm_key = "\<Tab>"
"let g:completion_enable_snippet = 'UltiSnips'
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch

set ruler

set visualbell

set formatoptions=tcqrn1
set expandtab
set noshiftround

set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

set ttyfast

set laststatus=2

set showmode
set showcmd

nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Split settings
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:rustfmt_autosave = 1
" Run with :!
let g:cargo_shell_command_runner = '!'


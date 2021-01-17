vim.api.nvim_exec(
[[
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | luafile $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tweekmonster/startuptime.vim'

" Ctrlp fuzzy finding
Plug 'ctrlpvim/ctrlp.vim'

" Gitgutter symbols
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'

" Commenting help
Plug 'scrooloose/nerdcommenter'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Theme
Plug 'tomasiser/vim-code-dark'
Plug 'frazrepo/vim-rainbow'

" Rust stuff
Plug 'rust-lang/rust.vim'

" Auto surrounding parens, brackets, etc
Plug 'tpope/vim-surround'

" Quick escape
Plug 'zhou13/vim-easyescape'

" Live Markdown editing
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |   PlugInstall --sync | q | endif
]], false)

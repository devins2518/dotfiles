" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Ctrlp fuzzy finding
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files

" Gitgutter
Plug 'airblade/vim-gitgutter'

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'

" Status bar
Plug 'vim-airline/vim-airline'

" Icons for NERDTree
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

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

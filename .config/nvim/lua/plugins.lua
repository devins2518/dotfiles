fn = vim.fn                          -- to call Vim functions e.g. fn.bufnr()
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself

-- LSP
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', hook = fn['remote#host#UpdateRemotePlugins']}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}

-- Fuzzy finding
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}

-- Gitgutter symbols
paq {'lewis6991/gitsigns.nvim'}
paq {'nvim-lua/plenary.nvim'}

-- Theme
paq {'frazrepo/vim-rainbow'}

-- Rust stuff
paq {'rust-lang/rust.vim'}

-- Auto surrounding parens, brackets, etc
paq {'tpope/vim-surround'}

-- Quick escape
paq {'zhou13/vim-easyescape'}

-- Markdown live editing
paq {'iamcco/markdown-preview.nvim', hook = fn['mkdp#util#install()']}

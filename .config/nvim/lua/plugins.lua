fn = vim.fn                          -- to call Vim functions e.g. fn.bufnr()
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself

-- LSP
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/completion-nvim'}
paq {'nvim-lua/lsp-status.nvim'}
paq {'hrsh7th/vim-vsnip'}
paq {'hrsh7th/vim-vsnip-integ'}

-- Fuzzy finding
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}

-- Gitgutter symbols
paq {'lewis6991/gitsigns.nvim'}
paq {'nvim-lua/plenary.nvim'}

-- Theme
paq {'p00f/nvim-ts-rainbow'}
paq {'tomasiser/vim-code-dark'}
paq {'norcalli/nvim-colorizer.lua'}
paq {'luochen1990/rainbow'}

-- Rust stuff
paq {'rust-lang/rust.vim'}

-- Commands to help work with parens, brackets, etc
paq {'tpope/vim-surround'}

-- Quick escape
paq {'zhou13/vim-easyescape'}

-- Markdown live editing
paq {'iamcco/markdown-preview.nvim', hook = fn['mkdp#util#install()']}

-- Status bar
paq {'vim-airline/vim-airline'}
paq {'vim-airline/vim-airline-themes'}
paq {'ryanoasis/vim-devicons'}

-- Autopairs for parens, brackets, etc
paq {'windwp/nvim-autopairs'}

paq {'tweekmonster/startuptime.vim'}

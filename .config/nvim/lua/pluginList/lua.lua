vim.cmd [[packadd packer.nvim]]

return require("packer").startup(
    function()
        -- Package Manager
        use {"wbthomason/packer.nvim", opt = true}

        -- Better tree
        use {"kyazdani42/nvim-web-devicons"}
        use {"kyazdani42/nvim-tree.lua"}

        -- Git status
        use {"nvim-lua/plenary.nvim"}
        use {"lewis6991/gitsigns.nvim"}
        use { 'tpope/vim-fugitive' }

        -- Buffer lines and statusline
        use {"glepnir/galaxyline.nvim"}
        use {"akinsho/nvim-bufferline.lua"}

        -- Theme stuffs
        --use {"nvim-treesitter/nvim-treesitter"}
        use {"sainnhe/edge"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"Yggdroot/indentLine"}
        use {"ryanoasis/vim-devicons"}
        use {'frazrepo/vim-rainbow'}

        -- Autoformatting
        use {"sbdchd/neoformat"}

        -- Completion
        --use {"neovim/nvim-lspconfig"}
        --use {"hrsh7th/nvim-compe"}
        use { "neoclide/coc.nvim", branch = 'release' }

        -- Automatically close pairs
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}

        -- Measure startup time
        use {"tweekmonster/startuptime.vim"}

        -- Pictures for lsp completions
        --use {"onsails/lspkind-nvim"}

        -- FZF and file manager
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {"nvim-lua/popup.nvim"}

        -- Commenting shortcuts
        use {'noahares/nvim-commenter'}

        -- Surrounding shortcuts
        use {'tpope/vim-surround'}

        -- Quick esc
        use {'zhou13/vim-easyescape'}

        -- Markdown live editing
        use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }

        -- Rust
        use { 'rust-lang/rust.vim' }
        use { 'fatih/vim-go' }

    end
)

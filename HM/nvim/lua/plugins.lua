local present, _ = pcall(require, 'packerinit')
local packer

if present then
    packer = require 'packer'
else
    return false
end

local use = packer.use

return packer.startup({
    function()
        use { 'wbthomason/packer.nvim' }

        use {
            'EdenEast/nightfox.nvim',
            config = function()
                require('nightfox').load('nightfox')
            end
        }
        use {
            'p00f/nvim-ts-rainbow',
            event = 'BufRead',
            config = function()
                require 'treesitter'
            end,
            requires = { 'nvim-treesitter/nvim-treesitter' }
        }
        use {
            'kyazdani42/nvim-web-devicons',
            config = function()
                require'nvim-web-devicons'.setup {
                    override = {
                        css = { icon = '', color = '#61afef', name = 'css' },
                        html = { icon = '', color = '#DE8C92', name = 'html' },
                        jpeg = { icon = ' ', color = '#BD77DC', name = 'jpeg' },
                        jpg = { icon = ' ', color = '#BD77DC', name = 'jpg' },
                        js = { icon = '', color = '#EBCB8B', name = 'js' },
                        kt = { icon = '󱈙', color = '#ffcb91', name = 'kt' },
                        lock = { icon = '', color = '#DE6B74', name = 'lock' },
                        lua = { icon = '', color = '#7daea3', name = 'lua' },
                        mp3 = { icon = '', color = '#C8CCD4', name = 'mp3' },
                        mp4 = { icon = '', color = '#C8CCD4', name = 'mp4' },
                        nix = { icon = '', color = '#7daea3', name = 'nix' },
                        out = { icon = '', color = '#C8CCD4', name = 'out' },
                        png = { icon = ' ', color = '#BD77DC', name = 'png' },
                        toml = { icon = '', color = '#61afef', name = 'toml' },
                        ts = { icon = 'ﯤ', color = '#519ABA', name = 'ts' },
                        xz = { icon = '', color = '#EBCB8B', name = 'xz' },
                        zip = { icon = '', color = '#EBCB8B', name = 'zip' }
                    }
                }
            end
        }
        use {
            'norcalli/nvim-colorizer.lua',
            event = 'BufRead',
            config = function()
                require'colorizer'.setup()
            end
        }

        -- LSP
        use {
            'neovim/nvim-lspconfig',
            after = { 'lsp_signature.nvim', 'lsp-status.nvim' },
            config = function()
                vim.cmd [[packadd nvim-lspconfig]]
                require 'nvim-lspconfig'
            end
        }
        use {
            'hrsh7th/nvim-cmp',
            after = { 'nvim-lspconfig' },
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/cmp-calc',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/vim-vsnip'
            },
            config = function()
                require 'nvim-compe'
            end
        }
        use {
            'tami5/lspsaga.nvim',
            after = { 'FixCursorHold.nvim', 'nvim-cmp' },
            config = function()
                vim.cmd [[packadd lspsaga.nvim]]
                require'lspsaga'.init_lsp_saga {
                    code_action_keys = { quit = 'q', exec = '<CR>' },
                    rename_action_keys = {
                        exec = '<CR>' -- quit can be a table
                    }
                }
            end
        }
        use {
            'nvim-lua/lsp_extensions.nvim',
            after = 'nvim-cmp',
            config = function()
                vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp
                                                                          .with(
                    vim.lsp.diagnostic.on_publish_diagnostics, {
                        underline = true,
                        virtual_text = { prefix = '', spacing = 2 },
                        signs = { enable = true, priority = 20 },
                        update_in_insert = true
                    }, require('lsp_extensions.workspace.diagnostic').handler,
                    { signs = { severity_limit = 'Error' } })
            end
        }
        use { 'ray-x/lsp_signature.nvim' }
        use { 'folke/lsp-colors.nvim', after = 'nvim-cmp' }
        use { 'nvim-lua/lsp-status.nvim' }

        -- Debugger
        use {
            'mfussenegger/nvim-dap',
            config = function()
                vim.cmd [[packadd dap]]
                require 'debugger'
            end,
            requires = {
                'nvim-telescope/telescope-dap.nvim',
                'rcarriga/nvim-dap-ui',
                'Pocco81/DAPInstall.nvim'
            },
            ft = { 'c', 'cpp', 'rust' }
        }

        -- Filetypes
        use { 'LnL7/vim-nix', ft = { 'nix' } }
        use { 'fatih/vim-go', ft = { 'go' } }
        use {
            'ziglang/zig.vim',
            ft = { 'zig' },
            config = function()
                G['zig_fmt_autosave'] = 1
            end
        }
        use {
            'rust-lang/rust.vim',
            ft = { 'rust' },
            after = 'lsp_extensions.nvim',
            config = function()
                require 'rust'
            end
        }
        use {
            'plasticboy/vim-markdown',
            ft = { 'markdown' },
            config = function()
                vim.cmd [[packadd vim-markdown]]
                G['vim_markdown_folding_disabled'] = 1
            end
        }
        use { 'octol/vim-cpp-enhanced-highlight', ft = { 'c', 'cpp' } }

        -- Git
        use {
            'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require 'gitsymbols'
            end
        }
        use { 'tpope/vim-fugitive' }

        -- Bars
        use {
            'akinsho/nvim-bufferline.lua',
            after = { 'nightfox.nvim', 'nvim-web-devicons' },
            config = function()
                require 'buffer'
            end
        }
        use {
            'glepnir/galaxyline.nvim',
            after = { 'nightfox.nvim', 'nvim-web-devicons', 'lsp-status.nvim' },
            config = function()
                require 'statusline'
            end
        }

        -- Formatting
        use {
            'mhartington/formatter.nvim',
            cmd = 'FormatWrite',
            config = function()
                require 'format'
            end
        }

        -- Markdown
        use {
            'iamcco/markdown-preview.nvim',
            ft = { 'markdown' },
            run = function()
                vim.fn['mkdp#util#install']()
            end,
            cmd = 'MarkdownPreview'
        }

        -- Utils
        use { 'jiangmiao/auto-pairs' }
        use {
            'folke/which-key.nvim',
            config = function()
                require 'whichkey'
            end
        }
        use {
            'terrortylor/nvim-comment',
            config = function()
                require('nvim_comment').setup({
                    marker_padding = true,
                    comment_empty = false,
                    create_mappings = false
                })

                Map('n', '++', [[:CommentToggle<CR>]], {})
                Map('v', '++', [[:'<,'>CommentToggle<CR>]], {})
            end
        }
        use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
        use { 'zhou13/vim-easyescape' }

        use {
            'antoinemadec/FixCursorHold.nvim',
            config = function()
                G['cursorhold_updatetime'] = 100
            end
        }
        use { 'tpope/vim-surround' }
        use {
            'kyazdani42/nvim-tree.lua',
            after = { 'nightfox.nvim', 'nvim-web-devicons' },
            config = function()
                require 'nvimTree'
            end
        }
        use {
            'Yggdroot/indentLine',
            config = function()
                G['indentLine_enabled'] = 1
                G['indentLine_char_list'] = { '|', '¦', '┆', '┊' }
            end
        }
        use {
            'nvim-telescope/telescope.nvim',
            requires = { { 'nvim-lua/plenary.nvim' } },
            config = function()
                require 'ts'
            end
        }
    end
})

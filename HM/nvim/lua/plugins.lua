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
                vim.cmd [[ colorscheme nightfox ]]
            end
        }
        use {
            'HiPhish/rainbow-delimiters.nvim',
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
            config = function()
                vim.cmd [[packadd nvim-lspconfig]]
                require 'nvim-lspconfig'
            end
        }
        use {
            'hrsh7th/nvim-cmp',
            after = { 'nvim-lspconfig' },
            requires = {
                'hrsh7th/cmp-calc',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lsp-signature-help',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/vim-vsnip'
            },
            config = function()
                require 'nvim-compe'
            end
        }
        use {
            'nvimdev/lspsaga.nvim',
            after = { 'FixCursorHold.nvim', 'nvim-cmp' },
            config = function()
                vim.cmd [[packadd lspsaga.nvim]]
                require'lspsaga'.setup {
                    border_style = 'rounded',
                    code_action_keys = { quit = 'q', exec = '<CR>' },
                    rename_action_keys = { quit = 'q', exec = '<CR>' }
                }
            end
        }
        use { 'folke/lsp-colors.nvim', after = 'nvim-cmp' }
        use {
            'j-hui/fidget.nvim',
            after = 'nvim-cmp',
            tag = 'legacy',
            config = function()
                vim.cmd [[packadd fidget.nvim]]
                require'fidget'.setup {}
            end
        }

        -- Debugger
        -- use {
        --     'mfussenegger/nvim-dap',
        --     config = function()
        --         vim.cmd [[packadd dap]]
        --         require 'debugger'
        --     end,
        --     requires = {
        --         'mrcjkb/rustaceanvim',
        --         'rcarriga/nvim-dap-ui',
        --         'Pocco81/DAPInstall.nvim',
        --         'nvim-neotest/nvim-nio'
        --     },
        --     ft = { 'c', 'cpp', 'rust' }
        -- }

        -- Filetypes
        use { 'LnL7/vim-nix', ft = { 'nix' } }
        use {
            'ocaml/vim-ocaml',
            ft = { 'ocaml' },
            config = function()
                vim.opt.tabstop = 2
            end
        }
        use { 'fatih/vim-go', ft = { 'go' } }
        use {
            'ziglang/zig.vim',
            ft = { 'zig' },
            config = function()
                G['zig_fmt_autosave'] = 0
            end
        }
        use { 'neovimhaskell/haskell-vim', ft = 'haskell' }
        use {
            'mrcjkb/rustaceanvim',
            version = '^4', -- Recommended
            ft = { 'rust' },
            after = { 'nvim-lspconfig' },
            config = function()
                -- Update this path
                local extension_path = os.getenv('CODELLDB_PATH') .. '/'
                local codelldb_path = extension_path .. 'adapter/codelldb'
                local liblldb_path = extension_path .. 'lldb/lib/liblldb'
                local this_os = vim.uv.os_uname().sysname;

                -- The liblldb extension is .so for Linux and .dylib for MacOS
                liblldb_path = liblldb_path ..
                                   (this_os == 'Linux' and '.so' or '.dylib')

                local cfg = require('rustaceanvim.config')

                vim.g.rustaceanvim = {
                    -- Plugin configuration
                    tools = {},
                    -- LSP configuration
                    server = {
                        on_attach = on_attach,
                        default_settings = {
                            -- rust-analyzer language server configuration
                            ['rust-analyzer'] = {
                                imports = {
                                    granularity = { group = 'module' },
                                    prefix = 'self'
                                },
                                cargo = {
                                    buildScripts = { enable = true },
                                    allFeatures = true
                                },
                                procMacro = { enable = true },
                                checkOnSave = { allTargets = true }
                            }
                        }
                    },
                    dap = {
                        adapter = cfg.get_codelldb_adapter(codelldb_path,
                            liblldb_path)
                    }
                }
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
        use {
            'lervag/vimtex',
            ft = { 'tex' },
            config = function()
                vim.cmd [[packadd vimtex]]
                G['vimtex_view_method'] = 'zathura'
            end
        }
        use { 'antiagainst/vim-tablegen' }
        use {
            'whonore/Coqtail',
            ft = { 'coq' },
            config = function()
                G['coqtail_noimap'] = 1
            end
        }

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

        -- Formatting
        use {
            'mhartington/formatter.nvim',
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
        use {
            'max397574/better-escape.nvim',
            config = function()
                require('better_escape').setup({
                    mappings = {
                        i = { j = { k = '<Esc>' } },
                        c = { j = { k = false, j = false } },
                        t = { j = { k = false } },
                        v = { j = { k = false } },
                        s = { j = { k = false } }
                    }
                })
            end
        }

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

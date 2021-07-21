vim.cmd [[packadd packer.nvim]]

G = vim.g
function Map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local packer = require 'packer'

local use = packer.use

local common_ft = {"c", "cpp", "go", "lua", "nix", "rust", "zig"}

return packer.startup({
    function()
        use {"wbthomason/packer.nvim"}

        -- Colorscheme
        use {
            "folke/tokyonight.nvim",
            config = function()
                G["tokyonight_style"] = "night"
                G["tokyonight_italic_comments"] = true
                G["tokyonight_italic_keywords"] = true
                G["tokyonight_sidebars"] = {
                    "qf", "vista_kind", "terminal", "packer"
                }
                vim.cmd [[colorscheme tokyonight]]
            end
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                vim.cmd [[packadd nvim-treesitter]]
                require"nvim-treesitter.configs".setup {
                    ensure_installed = {
                        "c", "cpp", "go", "gomod", "lua", "nix", "rust", "toml",
                        "yaml", "zig"
                    },
                    highlight = {enable = true}
                }
            end
        }
        use {
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
            config = function()
                vim.cmd [[packadd nvim-ts-rainbow]]
                require"nvim-treesitter.configs".setup {
                    rainbow = {
                        enable = true,
                        extended_mode = true, -- Highlight also non-parentheses delimiters
                        max_file_lines = 1000,
                        colors = {
                            "#7aa2f7", "#7dcfff", "#2ac3de", "#3d59a1",
                            "#73daca", "#41a6b5", "#b4f9f8" -- "#1abc9c"  , "#737aa2", "#9d7cd8"
                        }
                    }
                }
            end
        }
        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require"nvim-web-devicons".setup {
                    override = {
                        css = {icon = "", color = "#61afef", name = "css"},
                        html = {icon = "", color = "#DE8C92", name = "html"},
                        jpeg = {icon = " ", color = "#BD77DC", name = "jpeg"},
                        jpg = {icon = " ", color = "#BD77DC", name = "jpg"},
                        js = {icon = "", color = "#EBCB8B", name = "js"},
                        kt = {icon = "󱈙", color = "#ffcb91", name = "kt"},
                        lock = {icon = "", color = "#DE6B74", name = "lock"},
                        lua = {icon = "", color = "#61afef", name = "lua"},
                        mp3 = {icon = "", color = "#C8CCD4", name = "mp3"},
                        mp4 = {icon = "", color = "#C8CCD4", name = "mp4"},
                        nix = {icon = "", color = "#61afef", name = "nix"},
                        out = {icon = "", color = "#C8CCD4", name = "out"},
                        png = {icon = " ", color = "#BD77DC", name = "png"},
                        toml = {icon = "", color = "#61afef", name = "toml"},
                        ts = {icon = "ﯤ", color = "#519ABA", name = "ts"},
                        xz = {icon = "", color = "#EBCB8B", name = "xz"},
                        zip = {icon = "", color = "#EBCB8B", name = "zip"}
                    }
                }
            end
        }
        use {
            "norcalli/nvim-colorizer.lua",
            config = function() require"colorizer".setup() end
        }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            after = "lsp_signature.nvim",
            config = function()
                vim.cmd [[packadd nvim-lspconfig]]
                require 'nvim-lspconfig'
            end
        }
        use {
            "hrsh7th/nvim-compe",
            after = {"nvim-lspconfig"},

            requires = "hrsh7th/vim-vsnip",
            config = function()
                vim.cmd [[packadd nvim-compe]]
                require 'nvim-compe'
            end
        }
        use {
            "glepnir/lspsaga.nvim",
            config = function()
                vim.cmd [[packadd lspsaga.nvim]]
                require'lspsaga'.init_lsp_saga {
                    code_action_keys = {quit = 'q', exec = '<CR>'},
                    rename_action_keys = {
                        quit = 'q',
                        exec = '<CR>' -- quit can be a table
                    }
                }
            end,
            after = {"FixCursorHold.nvim", "nvim-compe"}
        }
        use {
            "nvim-lua/lsp_extensions.nvim",
            after = "nvim-compe",
            config = function()
                vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp
                                                                          .with(
                                                                          vim.lsp
                                                                              .diagnostic
                                                                              .on_publish_diagnostics,
                                                                          {
                        -- Enable underline, use default values
                        underline = true,
                        -- Enable virtual text, override spacing to 4
                        virtual_text = {prefix = "", spacing = 2},
                        signs = {enable = true, priority = 20},
                        -- Disable a feature
                        update_in_insert = false
                    }, require('lsp_extensions.workspace.diagnostic').handler, {
                        signs = {severity_limit = "Error"}
                    })
            end
        }
        use {"ray-x/lsp_signature.nvim"}
        use {"folke/lsp-colors.nvim", after = "nvim-compe"}

        -- Filetypes
        use {"LnL7/vim-nix", ft = {"nix"}}
        use {"fatih/vim-go", ft = {"go"}}
        use {
            "ziglang/zig.vim",
            ft = {"zig"},
            config = function()
                vim.cmd [[packadd zig.vim]]
                G["zig_fmt_autosave"] = 0
                vim.api.nvim_command([[augroup zig]])
                vim.api.nvim_command(
                    [[autocmd BufNewFile,BufRead gyro.zzz set filetype=yaml]])
                vim.api.nvim_command([[augroup END]])
            end
        }
        use {
            "rust-lang/rust.vim",
            ft = {"rust"},
            after = "lsp_extensions.nvim",
            config = function()
                vim.cmd [[packadd rust.vim]]
                vim.api.nvim_command([[augroup rust]])
                vim.api.nvim_command([[au!]])
                vim.api.nvim_command(
                    [[autocmd FileType rust let g:rustfmt_autosave=0]])
                vim.api.nvim_command(
                    [[autocmd Filetype rust let g:cargo_shell_command_runner="!"]])
                vim.api.nvim_command(
                    [[autocmd FileType rust nmap <leader>cc :Ccheck<CR>]])
                vim.api.nvim_command(
                    [[autocmd FileType rust nmap <leader>cb :Cbuild<CR>]])
                vim.api.nvim_command(
                    [[autocmd FileType rust nmap <leader>cr :Crun<CR>]])
                vim.api.nvim_command(
                    [[autocmd FileType rust nmap <leader>cl :Cclean<CR>]])
                vim.api.nvim_command(
                    [[autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ highlight = "NonText", prefix = " » " ,enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}]])
                vim.api.nvim_command([[augroup END ]])
            end
        }
        use {
            "plasticboy/vim-markdown",
            ft = {"markdown"},
            config = function()
                vim.cmd [[packadd vim-markdown]]
                G["vim_markdown_folding_disabled"] = 1
                vim.api.nvim_command([[augroup Markdown]])
                vim.api.nvim_command([[au!]])
                vim.api.nvim_command(
                    [[autocmd BufNewFile,BufRead *.md set filetype=markdown]])
                vim.api.nvim_command(
                    [[autocmd FileType markdown set conceallevel=2]])
                vim.api.nvim_command([[autocmd Filetype markdown set wrap]])
                vim.api.nvim_command(
                    [[autocmd FileType markdown set colorcolumn=]])
                vim.api.nvim_command(
                    [[autocmd FileType markdown set scrolloff=999]])
                vim.api.nvim_command(
                    [[autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>]])
                vim.api.nvim_command(
                    [[autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &]])
                vim.api.nvim_command(
                    [[autocmd InsertCharPre *.md if search('\v(%^|[.!?#-]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif]])
                vim.api.nvim_command([[augroup END]])
            end
        }

        -- Git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require 'gitsymbols' end
        }
        use {
            "tpope/vim-fugitive",
            config = function()
                Map("n", "<leader>gs", [[:G<CR>]], {})
                Map("n", "<leader>gj", [[:diffget //3<CR>]], {})
                Map("n", "<leader>gf", [[:diffget //2<CR>]], {})
            end
        }

        -- Bars
        use {
            "akinsho/nvim-bufferline.lua",
            after = {"nvim-web-devicons"},
            config = function()
                vim.cmd [[packadd nvim-bufferline.lua]]
                require 'buffer'
            end
        }
        use {
            "hoob3rt/lualine.nvim",
            after = {"tokyonight.nvim", "nvim-web-devicons"},
            requires = "arkav/lualine-lsp-progress",
            config = function() require 'statusline' end
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            config = function() require 'telescope-nvim' end,
            requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
        }

        -- Formatting
        use {
            "mhartington/formatter.nvim",
            event = "BufWritePost",
            ft = common_ft,
            config = function()
                vim.cmd [[packadd formatter.nvim]]
                require 'format'
            end,
            cmd = "FormatWrite"
        }

        -- Markdown
        use {
            'iamcco/markdown-preview.nvim',
            run = function() vim.fn['mkdp#util#install']() end,
            cmd = 'MarkdownPreview',
            config = function()
                vim.cmd [[packadd markdown-preview.nvim]]
            end
        }

        -- Utils
        use {
            "windwp/nvim-autopairs",
            after = {"nvim-compe", "nvim-treesitter"},
            config = function()
                vim.cmd [[packadd nvim-autopairs]]
                require('nvim-autopairs').setup({
                    enable_check_bracket_line = false
                })

                require("nvim-autopairs.completion.compe").setup({
                    map_cr = true, --  map <CR> on insert mode
                    map_complete = true -- it will auto insert `(` after select function or method item
                })

                require"nvim-treesitter.configs".setup {
                    autopairs = {enable = true}
                }

                vim.api.nvim_set_keymap("i", "<CR>",
                                        "compe#confirm(luaeval(\"require 'nvim-autopairs'.autopairs_cr()\"))",
                                        {
                    noremap = true,
                    silent = true,
                    expr = true
                })
            end

        }
        use {"folke/which-key.nvim"}
        use {
            "terrortylor/nvim-comment",
            config = function()
                require('nvim_comment').setup({
                    marker_padding = true,
                    comment_empty = false,
                    create_mappings = false
                })

                Map("n", "++", [[:CommentToggle<CR>]], {})
                Map("v", "++", [[:'<,'>CommentToggle<CR>]], {})
            end
        }
        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}
        use {"zhou13/vim-easyescape"}

        use {
            "antoinemadec/FixCursorHold.nvim",
            config = function() G["cursorhold_updatetime"] = 100 end
        }
        use {"tpope/vim-surround"}
        use {
            "kyazdani42/nvim-tree.lua",
            config = function()
                -- vim.cmd [[packadd nvim-tree.lua]]
                require 'nvimTree'
            end
        }
        use {
            "Yggdroot/indentLine",
            config = function()
                G["indentLine_enabled"] = 1
                G["indentLine_char_list"] = {'|', '¦', '┆', '┊'}
            end
        }
    end,
    config = {display = {open_fn = require('packer.util').float}}
})

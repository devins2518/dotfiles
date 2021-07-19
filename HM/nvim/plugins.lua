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

return packer.startup(function()
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
            require'nvim-treesitter.configs'.setup {
                rainbow = {
                    enable = true,
                    extended_mode = true, -- Highlight also non-parentheses delimiters
                    max_file_lines = 1000,
                    colors = {
                        "#7aa2f7", "#7dcfff", "#2ac3de", "#3d59a1", "#73daca",
                        "#41a6b5", "#b4f9f8", "#1abc9c", "#737aa2", "#9d7cd8"
                    }
                }
            }
        end
    }
    use {
        "kyazdani42/nvim-web-devicons",
        after = "nvim-treesitter",
        config = function()
            vim.cmd [[packadd nvim-web-devicons]]
            require"nvim-web-devicons".setup {
                override = {
                    html = {icon = "", color = "#DE8C92", name = "html"},
                    css = {icon = "", color = "#61afef", name = "css"},
                    js = {icon = "", color = "#EBCB8B", name = "js"},
                    ts = {icon = "ﯤ", color = "#519ABA", name = "ts"},
                    kt = {icon = "󱈙", color = "#ffcb91", name = "kt"},
                    png = {icon = " ", color = "#BD77DC", name = "png"},
                    jpg = {icon = " ", color = "#BD77DC", name = "jpg"},
                    jpeg = {icon = " ", color = "#BD77DC", name = "jpeg"},
                    mp3 = {icon = "", color = "#C8CCD4", name = "mp3"},
                    mp4 = {icon = "", color = "#C8CCD4", name = "mp4"},
                    out = {icon = "", color = "#C8CCD4", name = "out"},
                    toml = {icon = "", color = "#61afef", name = "toml"},
                    lock = {icon = "", color = "#DE6B74", name = "lock"},
                    zip = {icon = "", color = "#EBCB8B", name = "zip"},
                    xz = {icon = "", color = "#EBCB8B", name = "xz"}
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
        after = {"lsp-status.nvim"},
        config = function()
            vim.cmd [[packadd nvim-lspconfig]]
            require 'plugins.nvim-lspconfig'
        end
    }
    use {
        "hrsh7th/nvim-compe",
        ft = common_ft,
        after = {"nvim-lspconfig"},
        config = function()
            vim.cmd [[packadd nvim-compe]]
            require 'plugins.nvim-compe'
        end
    }
    use {
        "glepnir/lspsaga.nvim",
        config = function()
            vim.cmd [[packadd lspsaga.nvim]]
            require('lspsaga').init_lsp_saga {
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
        "nvim-lua/lsp-status.nvim",
        ft = common_ft,
        config = function()
            vim.cmd [[packadd lsp-status.nvim]]
            local lsp_status = require('lsp-status')
            lsp_status.register_progress()

            lsp_status.config({
                current_function = false,
                diagnostics = false,
                indicator_errors = '',
                indicator_warnings = '',
                indicator_info = '',
                indicator_hint = '',
                indicator_ok = '﫠'
            })
        end
    }
    use {"nvim-lua/lsp_extensions.nvim", after = "nvim-compe"}
    use {"ray-x/lsp_signature.nvim", after = "nvim-compe"}

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
            vim.api.nvim_command([[
                    augroup zig
                        autocmd BufNewFile,BufRead gyro.zzz set filetype=yaml
                    augroup END 
                ]])
        end
    }
    use {
        "rust-lang/rust.vim",
        ft = {"rust"},
        comfig = function()
            vim.cmd [[packadd rust.vim]]
            vim.api.nvim_command([[
                   augroup rust
                       au!
                       autocmd FileType rust let g:rustfmt_autosave=0
                       autocmd Filetype rust let g:cargo_shell_command_runner="!"
                       autocmd FileType rust nmap <leader>cc :Ccheck<CR>
                       autocmd FileType rust nmap <leader>cb :Cbuild<CR>
                       autocmd FileType rust nmap <leader>cr :Crun<CR>
                       autocmd FileType rust nmap <leader>cl :Cclean<CR>
                       autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{
                        \ highlight = "NonText",
                        \ prefix = " » ",
                        \ enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
                        \ }
                    augroup END 
                ]])
        end
    }
    use {
        "plasticboy/vim-markdown",
        ft = {"markdown"},
        config = function()
            vim.cmd [[packadd vim-markdown]]
            G["vim_markdown_folding_disabled"] = 1
            vim.api.nvim_command([[
                 augroup markdown
                   au!
                   autocmd BufNewFile,BufRead *.md set filetype=markdown
                   autocmd FileType markdown set conceallevel=2
                   autocmd Filetype markdown set wrap
                   autocmd FileType markdown set colorcolumn=
                   autocmd FileType markdown set scrolloff=999
                   autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>
                   autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &
                   autocmd InsertCharPre *.md if search('\v(%^|[.!?#-]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
                 augroup END
                 ]])
        end
    }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require 'plugins.gitsigns' end
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
        config = function() require 'plugins.bufferline' end
    }
    use {
        "hoob3rt/lualine.nvim",
        after = {"lsp-status.nvim", "tokyonight.nvim"},
        config = function()
            vim.cmd [[packadd lualine.nvim]]
            require 'plugins.statusline'
        end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        config = function() require 'plugins.telescope-nvim' end
    }

    -- Formatting
    use {
        "mhartington/formatter.nvim",
        event = "BufWritePost",
        ft = common_ft,
        config = function()
            vim.cmd [[packadd formatter.nvim]]
            require 'plugins.format'
        end,
        cmd = "FormatWrite"
    }

    -- Markdown
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        cmd = 'MarkdownPreview'
    }

    -- Utils
    use {"folke/which-key.nvim"}
    use {"jiangmiao/auto-pairs"}
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
    use {"hrsh7th/vim-vsnip"}
    -- use {"windwp/nvim-autopairs"}
    use {
        "kyazdani42/nvim-tree.lua",
        config = function() require 'plugins.format' end
    }
    use {
        "Yggdroot/indentLine",
        config = function()
            G["indentLine_enabled"] = 1
            G["indentLine_char_list"] = {'|', '¦', '┆', '┊'}
        end
    }
end)

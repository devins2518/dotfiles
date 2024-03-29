vim.api.nvim_create_user_command('ToggleFormat', [[
    let b:format_run=!b:format_run
    let b:rustfmt_autosave=b:format_run
    ]], {})

require('formatter').setup({
    logging = false,
    filetype = {
        tex = {
            function()
                return { exe = 'latexindent', args = { '-' }, stdin = true }
            end
        },
        sh = {
            function()
                return {
                    exe = 'shfmt',
                    args = { '-w', '-s', '-i 4', '' .. vim.fn.expand('%:p') },
                    stdin = false
                }
            end
        },
        haskell = {
            function()
                return { exe = 'stylish-haskell' }
            end
        },
        ocaml = {
            function()
                return {
                    exe = 'ocamlformat',
                    args = {
                        '--exp-grouping=preserve',
                        '-',
                        '--name ' .. vim.fn.expand('%:p')
                    },
                    stdin = true
                }
            end
        },
        lua = {
            function()
                return {
                    exe = 'lua-format',
                    args = {
                        '-i',
                        '--break-after-operator',
                        '--break-after-table-lb',
                        '--break-before-table-rb',
                        '--chop-down-table',
                        '--double-quote-to-single-quote',
                        '--no-align-args',
                        '--no-align-parameter',
                        '--no-align-table-field',
                        '--no-keep-simple-control-block-one-line',
                        '--no-keep-simple-function-one-line',
                        '--spaces-inside-table-braces'
                    },
                    stdin = true
                }
            end
        },
        c = {
            function()
                return {
                    exe = 'clang-format',
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = 'clang-format',
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        nix = {
            function()
                return { exe = 'nixfmt', stdin = true }
            end
        },
        rust = { require('formatter.filetypes.rust').rustfmt },
        zig = {
            function()
                return
                    { exe = 'zig', args = { 'fmt', '--stdin' }, stdin = true }
            end
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require('formatter.filetypes.any').remove_trailing_whitespace
        }
    }
})

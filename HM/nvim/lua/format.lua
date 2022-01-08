G['format_run'] = 1
vim.api.nvim_add_user_command('FormatToggle', [[
    let g:format_run=!g:format_run
    let g:rustfmt_autosave=g:format_run
    ]], {})

require('formatter').setup({
    logging = false,
    filetype = {
        sh = {
            function()
                return {
                    exe = 'shfmt',
                    args = { '-w', '-s', '-i 4', '' .. vim.fn.expand('%:p') },
                    stdin = false
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
                    args = { '--style="{IndentWidth: 4}"' },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = 'clang-format',
                    args = { '--style="{IndentWidth: 4}"' },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        nix = {
            function()
                return { exe = 'nixfmt', stdin = true }
            end
        }
    }
})

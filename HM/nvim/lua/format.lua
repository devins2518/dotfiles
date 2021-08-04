require('formatter').setup({
    logging = false,
    filetype = {
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
        cpp = {
            function()
                return {
                    exe = 'clang-format',
                    args = {},
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
        haskell = {
            function()
                return
                    { exe = 'stylish-haskell', args = { '-i' }, stdin = false }
            end
        }
    }
})

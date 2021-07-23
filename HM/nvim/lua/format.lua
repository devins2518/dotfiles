require('formatter').setup({
    logging = false,
    filetype = {
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = { "--emit=stdout" },
                    stdin = true
                }
            end
        },
        lua = {
            function()
                return {
                    exe = "lua-format",
                    args = {
                        "-i",
                        "--no-align-args",
                        "--break-after-table-lb",
                        "--break-before-table-rb",
                        "--break-after-operator",
                        "--spaces-inside-table-braces",
                        "--no-keep-simple-control-block-one-line",
                        "--no-keep-simple-function-one-line",
                        "--chop-down-table"
                    },
                    stdin = true
                }
            end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        nix = {
            function()
                return { exe = "nixfmt", stdin = true }
            end
        },
        zig = {
            function()
                return { exe = "zig", args = { "fmt" }, stdin = true }
            end
        }
    }
})

vim.api.nvim_exec([[
augroup Format
  autocmd!
  autocmd BufWritePost *.zig,*.rs,*.lua,*.c,*.cpp,*.nix FormatWrite
augroup END
]], true)

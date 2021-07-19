require('formatter').setup({
    logging = false,
    filetype = {
        rust = {
            function()
                return {exe = "rustfmt", args = {"--emit=stdout"}, stdin = true}
            end
        },
        lua = {
            function()
                return {exe = "lua-format", args = {"-i"}, stdin = true}
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
        nix = {function() return {exe = "nixfmt", stdin = true} end},
        zig = {
            function()
                return {exe = "zig", args = {"fmt"}, stdin = true}
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

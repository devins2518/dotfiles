local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
    return
end
local rainbow_delimiters = require 'rainbow-delimiters'

local parser_dir = vim.fn.stdpath('config');
vim.opt.runtimepath:append(parser_dir)
treesitter.setup {
    parser_install_dir = parser_dir,
    highlight = {
        enable = true,
        use_languagetree = true,
        disable = {
            'cpp',
            'c',
            'latex',
            'nix',
            'zig' -- LSP Handles highlighting
        }
    }
}

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

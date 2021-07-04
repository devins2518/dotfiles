require("gitsigns").setup {
    signs = {
        add = {
            hl = 'String',
            text = '┃',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'Function',
            text = '┃',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    },

    numhl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {
            expr = true,
            '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''
        },
        ["n [c"] = {
            expr = true,
            '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''
        },
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_index = {interval = 100},
    sign_priority = 5,
    status_formatter = nil, -- Use default
    current_line_blame = true,
    current_line_blame_delay = 1000,
    current_line_blame_position = 'eol'
}

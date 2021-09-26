require('gitsigns').setup {
    signs = {
        add = {
            hl = 'String',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'Function',
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '│',
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
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    },
    numhl = false,
    watch_gitdir = { interval = 100 },
    sign_priority = 5,
    status_formatter = nil, -- Use default
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000
    }
}

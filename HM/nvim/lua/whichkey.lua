local wk = require 'which-key'

local gen_opt = { mode = 'n', noremap = true, silent = true }
local git_opt = { mode = 'n', noremap = true }
wk.setup({ notify = true })
wk.add({
    { '<leader>d', group = 'Debugging' },
    { '<leader>dR', '<cmd>lua require"dap".restart()<CR>', desc = 'Restart' },
    {
        '<leader>db',
        '<cmd>lua require"dap".toggle_breakpoint()<CR>',
        desc = 'Toggle breakpoint'
    },
    {
        '<leader>dc',
        '<cmd>lua require"dap".continue()<CR>',
        desc = 'Debug continue'
    },
    {
        '<leader>dr',
        '<cmd>lua require"dap".run_to_cursor()<CR>',
        desc = 'Run to cursor'
    },
    { '<leader>ds', group = 'Stepping' },
    { '<leader>dsb', '<cmd>lua require"dap".step_back()<CR>', desc = 'Step back' },
    { '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', desc = 'Step into' },
    { '<leader>dso', '<cmd>lua require"dap".step_over()<CR>', desc = 'Step over' },
    { '<leader>dst', '<cmd>lua require"dap".step_out()<CR>', desc = 'Step out' },
    { '<leader>g', group = 'Git Fugitive' },
    { '<leader>gf', ':diffget //2<CR>', desc = 'Use left diff' },
    { '<leader>gj', ':diffget //3<CR>', desc = 'Use right diff' },
    { '<leader>gs', ':G<CR>', desc = 'Show git status' },
    { '<leader>h', group = 'Git hunks' },
    {
        '<leader>hb',
        '<cmd>lua require"gitsigns".blame_line()<CR>',
        desc = 'Show blame'
    },
    {
        '<leader>hp',
        '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        desc = 'Preview hunk'
    },
    {
        '<leader>hr',
        '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        desc = 'Reset hunk'
    },
    {
        '<leader>hs',
        '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        desc = 'Stage hunk'
    },
    {
        '<leader>hu',
        '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        desc = 'Unstage hunk'
    },
    { '<leader>l', group = 'LSP' },
    {
        '<leader>lD',
        '<cmd>lua vim.lsp.buf.declaration()<CR>',
        desc = 'Show declaration'
    },
    { '<leader>lc', '<cmd>Lspsaga code_action<CR>', desc = 'Show code actions' },
    {
        '<leader>ld',
        '<cmd>lua vim.lsp.buf.definition()<CR>',
        desc = 'Show definition'
    },
    { '<leader>li', '<cmd>Lspsaga implement<CR>', desc = 'Show implementation' },
    { '<leader>ln', '<cmd>Lspsaga rename<CR>', desc = 'Show blame' },
    { '<leader>lr', '<cmd>Lspsaga references<CR>', desc = 'Show references' },
    { '<leader>t', group = 'Telescope' },
    { '<leader>tb', '<cmd>Telescope buffers<cr>', desc = 'Show buffers' },
    { '<leader>tf', '<cmd>Telescope find_files<cr>', desc = 'Show files' },
    { '<leader>tg', '<cmd>Telescope live_grep<cr>', desc = 'Grep files' },
    { '[d', ':Lspsaga diagnostic_jump_prev<CR>', desc = 'Previous diagnostic' },
    {
        '[h',
        '&diff ? \'[h\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\'',
        desc = 'Previous hunk',
        expr = true,
        replace_keycodes = false
    },
    { ']d', ':Lspsaga diagnostic_jump_next<CR>', desc = 'Next diagnostic' },
    {
        ']h',
        '&diff ? \']h\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\'',
        desc = 'Next hunk',
        expr = true,
        replace_keycodes = false
    }
})

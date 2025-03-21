local wk = require 'which-key'

local gen_opt = { mode = 'n', noremap = true, silent = true }
local git_opt = { mode = 'n', noremap = true }
wk.setup({ notify = true })
wk.register({
    ['<leader>'] = {
        g = {
            name = 'Git Fugitive',
            s = { ':G<CR>', 'Show git status' },
            j = { ':diffget //3<CR>', 'Use right diff' },
            f = { ':diffget //2<CR>', 'Use left diff' }
        },
        h = {
            name = 'Git hunks',
            s = {
                '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                'Stage hunk',
                unpack(git_opt)
            },
            u = {
                '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                'Unstage hunk',
                unpack(git_opt)
            },
            r = {
                '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                'Reset hunk',
                unpack(git_opt)
            },
            p = {
                '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                'Preview hunk',
                unpack(git_opt)
            },
            b = {
                '<cmd>lua require"gitsigns".blame_line()<CR>',
                'Show blame',
                unpack(git_opt)
            }
        },
        l = {
            name = 'LSP',
            d = {
                '<cmd>lua vim.lsp.buf.definition()<CR>',
                'Show definition',
                unpack(gen_opt)
            },
            D = {
                '<cmd>lua vim.lsp.buf.declaration()<CR>',
                'Show declaration',
                unpack(gen_opt)
            },
            r = {
                '<cmd>Lspsaga references<CR>',
                'Show references',
                unpack(gen_opt)
            },
            i = {
                '<cmd>Lspsaga implement<CR>',
                'Show implementation',
                unpack(gen_opt)
            },
            c = {
                '<cmd>Lspsaga code_action<CR>',
                'Show code actions',
                unpack(gen_opt)
            },
            n = { '<cmd>Lspsaga rename<CR>', 'Show blame', unpack(gen_opt) }
        },
        t = {
            name = 'Telescope',
            f = { '<cmd>Telescope find_files<cr>', 'Show files', unpack(gen_opt) },
            g = { '<cmd>Telescope live_grep<cr>', 'Grep files', unpack(gen_opt) },
            b = { '<cmd>Telescope buffers<cr>', 'Show buffers', unpack(gen_opt) }
        },
        d = {
            name = 'Debugging',
            b = {
                '<cmd>lua require"dap".toggle_breakpoint()<CR>',
                'Toggle breakpoint',
                unpack(gen_opt)
            },
            r = {
                '<cmd>lua require"dap".run_to_cursor()<CR>',
                'Run to cursor',
                unpack(gen_opt)
            },
            R = {
                '<cmd>lua require"dap".restart()<CR>',
                'Restart',
                unpack(gen_opt)
            },
            c = {
                '<cmd>lua require"dap".continue()<CR>',
                'Debug continue',
                unpack(gen_opt)
            },
            s = {
                name = 'Stepping',
                i = {
                    '<cmd>lua require"dap".step_into()<CR>',
                    'Step into',
                    unpack(gen_opt)
                },
                o = {
                    '<cmd>lua require"dap".step_over()<CR>',
                    'Step over',
                    unpack(gen_opt)
                },
                t = {
                    '<cmd>lua require"dap".step_out()<CR>',
                    'Step out',
                    unpack(gen_opt)
                },
                b = {
                    '<cmd>lua require"dap".step_back()<CR>',
                    'Step back',
                    unpack(gen_opt)
                }
            }
        }
    },
    ['['] = {
        h = {
            [[&diff ? '[h' : '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>']],
            'Previous hunk',
            expr = true,
            unpack(git_opt)
        },
        d = {
            [[:Lspsaga diagnostic_jump_prev<CR>]],
            'Previous diagnostic',
            unpack(gen_opt)
        }
    },
    [']'] = {
        h = {
            [[&diff ? ']h' : '<cmd>lua require"gitsigns.actions".next_hunk()<CR>']],
            'Next hunk',
            expr = true,
            unpack(git_opt)
        },
        d = {
            [[:Lspsaga diagnostic_jump_next<CR>]],
            'Next diagnostic',
            unpack(gen_opt)
        }
    }
})

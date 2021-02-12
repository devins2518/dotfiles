g['rustfmt_autosave'] = 1
g['cargo_shell_command_runner'] = "!"
map('n', '<Space>cc', '<Nop>')                                 -- Allow jk to escape cmd mode
map('n', '<Space>cl', '<Nop>')                                 -- Allow jk to escape cmd mode
map('n', '<Space>cb', '<Nop>')                                 -- Allow jk to escape cmd mode
map('n', '<Space>cr', '<Nop>')                                 -- Allow jk to escape cmd mode
map('n', '<leader>cc', ':Ccheck<CR>')                                 -- Allow jk to escape cmd mode
map('n', '<leader>cl', ':Cclean<CR>')                                 -- Allow jk to escape cmd mode
map('n', '<leader>cb', ':Cbuild<CR>')                                 -- Allow jk to escape cmd mode
map('n', '<leader>cr', ':Crun<CR>')                                 -- Allow jk to escape cmd mode

local present, tree = pcall(require, 'nvim-tree.config')
if not present then
    return
end

G['nvim_tree_add_trailing'] = 1
G['nvim_tree_allow_resize'] = 1
G['nvim_tree_auto_close'] = 1
G['nvim_tree_auto_open'] = 0
G['nvim_tree_disable_default_keybindings'] = 1
G['nvim_tree_follow'] = 1
G['nvim_tree_git_hl'] = 1
G['nvim_tree_group_empty'] = 1
G['nvim_tree_hide_dotfiles'] = 1
G['nvim_tree_ignore'] = {
    '.git',
    'target',
    'node_modules',
    '.cache',
    'Cargo.lock'
}
G['nvim_tree_indent_markers'] = 1
G['nvim_tree_quit_on_open'] = 0
G['nvim_tree_root_folder_modifier'] = ':~'
G['nvim_tree_show_icons'] = { git = 1, folders = 1, files = 1 }
G['nvim_tree_side'] = 'left'
G['nvim_tree_tab_open'] = 1
G['nvim_tree_update_cwd'] = 1
G['nvim_tree_width'] = 25
G['nvim_tree_width_allow_resize'] = 1
G['nvim_tree_icons'] = {
    default = ' ',
    symlink = ' ',
    git = {
        unstaged = '✗',
        staged = '✓',
        unmerged = '',
        renamed = '➜',
        untracked = '★'
    },
    folder = {
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
        symlink_open = ''
    }
}

local tree_cb = tree.nvim_tree_callback
G['nvim_tree_bindings'] = {
    { key = { '<CR>', 'o', '<2-LeftMouse>' }, cb = tree_cb('edit') },
    { key = { '<2-RightMouse>', 'c' }, cb = tree_cb('cd') },
    { key = 'vs', cb = tree_cb('vsplit') },
    { key = 'sp', cb = tree_cb('split') },
    { key = 'tn', cb = tree_cb('tabnew') },
    { key = { '<BS>', '<S-CR>' }, cb = tree_cb('close_node') },
    { key = '<Tab>', cb = tree_cb('preview') },
    { key = 'I', cb = tree_cb('toggle_ignored') },
    { key = 'H', cb = tree_cb('toggle_dotfiles') },
    { key = 'R', cb = tree_cb('refresh') },
    { key = 'n', cb = tree_cb('create') },
    { key = 'd', cb = tree_cb('remove') },
    { key = 'rn', cb = tree_cb('rename') },
    { key = '<C-r>', cb = tree_cb('full_rename') },
    { key = 'x', cb = tree_cb('cut') },
    { key = 'y', cb = tree_cb('copy') },
    { key = 'p', cb = tree_cb('paste') },
    { key = '[c', cb = tree_cb('prev_git_item') },
    { key = ']c', cb = tree_cb('next_git_item') },
    { key = '-', cb = tree_cb('dir_up') },
    { key = '?', cb = tree_cb('toggle_help') }
}
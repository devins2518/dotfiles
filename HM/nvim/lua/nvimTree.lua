local present, tree = pcall(require, 'nvim-tree')
if not present then
    return
end

G['nvim_tree_ignore'] = {
    '.git',
    'target',
    'node_modules',
    '.cache',
    'Cargo.lock'
}
G['nvim_tree_gitignore'] = 1
G['nvim_tree_quit_on_open'] = 0
G['nvim_tree_indent_markers'] = 1
G['nvim_tree_hide_dotfiles'] = 1
G['nvim_tree_git_hl'] = 1
G['nvim_tree_highlight_opened_files'] = 1
G['nvim_tree_root_folder_modifier'] = ':~'
G['nvim_tree_add_trailing'] = 1
G['nvim_tree_group_empty'] = 1
G['nvim_tree_disable_window_picker'] = 1
G['nvim_tree_icon_padding'] = ' '
G['nvim_tree_symlink_arrow'] = ' >> '
G['nvim_tree_respect_buf_cwd'] = 1
G['nvim_tree_create_in_closed_folder'] = 0
G['nvim_tree_refresh_wait'] = 500
G['nvim_tree_window_picker_exclude'] = {
    filetype = { 'notify', 'packer', 'qf' },
    buftype = { 'terminal' }
}
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
    },
    lsp = { hint = '', info = '', warning = '', error = '' }
}

tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = true,
    open_on_tab = false,
    update_to_buf_dir = { enable = true, auto_open = true },
    hijack_cursor = false,
    update_cwd = false,
    lsp_diagnostics = true,
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },

    view = {
        width = 25,
        height = 30,
        side = 'left',
        -- if true the tree will resize itself after opening a file
        auto_resize = true,
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            -- list of mappings to set on the tree manually
            list = {}
        }
    }
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
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

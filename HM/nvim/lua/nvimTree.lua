local present, tree = pcall(require, 'nvim-tree')
if not present then
    return
end

G['nvim_tree_quit_on_open'] = 0
G['nvim_tree_indent_markers'] = 1
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
    update_cwd = true,
    diagnostics = { enable = true },
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },

    git = { enable = true, ignore = true, timeout = 500 },
    filters = {
        dotfiles = true,
        custom = { '.git', 'target', 'node_modules', '.cache', 'Cargo.lock' }
    },

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
            list = {
                { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
                { key = { '<2-RightMouse>', 'c' }, action = 'cd' },
                { key = 'vs', action = 'vsplit' },
                { key = 'sp', action = 'split' },
                { key = 'tn', action = 'tabnew' },
                { key = { '<BS>', '<S-CR>' }, action = 'close_node' },
                { key = '<Tab>', action = 'preview' },
                { key = 'I', action = 'toggle_ignored' },
                { key = 'H', action = 'toggle_dotfiles' },
                { key = 'R', action = 'refresh' },
                { key = 'n', action = 'create' },
                { key = 'd', action = 'remove' },
                { key = 'rn', action = 'rename' },
                { key = '<C-r>', action = 'full_rename' },
                { key = 'x', action = 'cut' },
                { key = 'y', action = 'copy' },
                { key = 'p', action = 'paste' },
                { key = '[c', action = 'prev_git_item' },
                { key = ']c', action = 'next_git_item' },
                { key = '-', action = 'dir_up' },
                { key = '?', action = 'toggle_help' }
            }
        }
    }
}

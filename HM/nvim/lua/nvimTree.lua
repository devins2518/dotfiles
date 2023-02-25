local present, tree = pcall(require, 'nvim-tree')
if not present then
    return
end

G['nvim_tree_refresh_wait'] = 500

tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_directories = { enable = true, auto_open = true },
    hijack_cursor = false,
    update_cwd = false,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = '', info = '', warning = '', error = '' }
    },
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },
    respect_buf_cwd = true,
    create_in_closed_folder = false,

    git = { enable = true, ignore = true, timeout = 500 },
    filters = {
        dotfiles = true,
        custom = { '.git', 'target', 'node_modules', '.cache', 'Cargo.lock' }
    },
    actions = {
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                exclude = {
                    filetype = { 'notify', 'packer', 'qf' },
                    buftype = { 'terminal' }
                }
            }
        }
    },

    view = {
        width = 25,
        side = 'left',
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
    },

    renderer = {
        highlight_git = true,
        highlight_opened_files = 'icon',
        root_folder_modifier = ':~',
        add_trailing = true,
        group_empty = true,
        indent_markers = { enable = true },

        icons = {
            padding = ' ',
            symlink_arrow = ' >> ',
            glyphs = {
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
        }
    }
}

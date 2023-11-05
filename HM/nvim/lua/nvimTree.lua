local present, tree = pcall(require, 'nvim-tree')
if not present then
    return
end

G['nvim_tree_refresh_wait'] = 500

--
-- This function has been generated from your
--   view.mappings.list
--   view.mappings.custom_only
--   remove_keymaps
--
-- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
--
-- Although care was taken to ensure correctness and local completeness, your review is required.
--
-- Please check for the following issues in auto generated content:
--   "Mappings removed" is as you expect
--   "Mappings migrated" are correct
--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--

local function attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Default mappings. Feel free to modify or remove as you wish.
    --
    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical,
        opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal,
        opts('Open: Horizontal Split'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next,
        opts('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev,
        opts('Previous Sibling'))
    vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path,
        opts('Copy Absolute Path'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path,
        opts('Copy Relative Path'))
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node,
        opts('CD'))
    vim.keymap.set('n', 'c', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 'vs', api.node.open.vertical,
        opts('Open: Vertical Split'))
    vim.keymap.set('n', 'sp', api.node.open.horizontal,
        opts('Open: Horizontal Split'))
    vim.keymap.set('n', 'tn', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close,
        opts('Close Directory'))
    vim.keymap.set('n', '<S-CR>', api.node.navigate.parent_close,
        opts('Close Directory'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter,
        opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter,
        opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'rn', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub,
        opts('Rename: Omit Filename'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

tree.setup {
    on_attach = attach,

    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_directories = { enable = true, auto_open = true },
    hijack_cursor = false,
    update_cwd = false,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = '', info = '', warning = '', error = '' }
    },
    update_focused_file = { enable = true, update_cwd = false, ignore_list = {} },
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

    view = { width = 25, side = 'left' },

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

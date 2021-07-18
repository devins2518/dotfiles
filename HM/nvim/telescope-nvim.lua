require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg", "--color=always", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case"
        },
        prompt_prefix = "» ",
        selection_caret = "» ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {mirror = false, preview_width = 0.5},
            vertical = {mirror = false}
            -- prompt_position = "bottom",
            -- preview_cutoff = 120,
            -- results_height = 1,
            -- results_width = 0.8,
        },
        file_sorter = require"telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 15,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require"telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require"telescope.previewers".buffer_previewer_maker
    },
    pickers = {
        -- Your special builtin config goes in here
        buffers = {
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    ["<leader>tf"] = require('telescope.builtin').find_files(),
                    -- ["<Leader>tp"] = require('telescope').extensions.media_files
                    --     .media_files(),
                    ["<Leader>tb"] = require('telescope.builtin').buffers(),
                    ["<Leader>th"] = require('telescope.builtin').help_tags(),
                    ["<Leader>to"] = require('telescope.builtin').oldfiles()
                }
            }
        },
        find_files = {theme = "dropdown"}
    },
    extensions = {
        -- media_files = {
        --     filetypes = {"png", "webp", "jpg", "jpeg"},
        --     find_cmd = "rg" -- find command (defaults to `fd`)
        -- }
    }
}

-- require("telescope").load_extension("media_files")

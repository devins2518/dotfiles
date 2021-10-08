local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
    return
end

treesitter.setup {
    ensure_installed = { 'gomod' },
    highlight = {
        enable = true,
        use_languagetree = true,
        disable = { 'cpp', 'c' }
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters
        max_file_lines = 1000,
        colors = {
            '#7aa2f7',
            '#7dcfff',
            '#2ac3de',
            '#3d59a1',
            '#73daca',
            '#41a6b5',
            '#b4f9f8'
        },
        disable = { 'c', 'cpp' }
    }
}

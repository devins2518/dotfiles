require'nvim-treesitter.configs'.setup {
    ensure_installed = { "toml", "rust", "bash", "lua", "python" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
        enable = true,
    },
}

-- Extremely slow for some reason
--require'nvim-treesitter.configs'.setup {
--    rainbow = {
--        enable = true,
--        disable = {'bash'} -- please disable bash until I figure #1 out
--    }
--}

require'colorizer'.setup()

require "nvim-treesitter.highlight"
-- use below replace  local hlmap = vim.treesitter.TSHighlighter.hl_map 
local hlmap = vim.treesitter.highlighter.hl_map 

--Misc
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil

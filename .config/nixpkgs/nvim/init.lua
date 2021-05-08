cmd = vim.cmd
g = vim.g
home = os.getenv("HOME")

require("pluginList.lua")
cmd "colorscheme edge"
g.edge_style = "aura"

-- load plugins
require("web-devicons.lua")

require("nvimTree.lua")
require("bufferline.lua")
require("statusline.lua")
require("telescope-nvim.lua")

-- lsp
--require("nvim-lspconfig.lua")
--require("nvim-compe.lua")
vim.api.nvim_exec('source ' .. home .. '/.config/nvim/lua/coc.vim', false)

require("gitsigns.lua")

require "colorizer".setup()

g.indentLine_enabled = 1
g.indentLine_char_list = {"▏"}

g.mapleader = " "

--require("treesitter.lua")
require("mappings.lua")
require("rust.lua")

-- tree folder name , icon color
cmd("hi NvimTreeFolderIcon guifg = #5b8dc2")
cmd("hi NvimTreeFolderName guifg = #a57ec8")
cmd("hi NvimTreeIndentMarker guifg=#545862")

require("nvim-autopairs").setup()
require("utils.lua")

--require("lspkind").init(
--    {
--        File = " "
--    }
--)

vim.api.nvim_exec(
    [[
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
 ]],
    false
)

local home = os.getenv("HOME")
cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables

g.mapleader = " "

-- Option settings
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

cmd 'colorscheme ron'                                   -- Put your favorite colorscheme here

opt('o', 'errorbells', false)                           -- Disable annoying error bells
opt('b', 'tabstop', 4)                                  -- Number of spaces that tabs count for
opt('b', 'softtabstop', 4)                              -- Number of spaces that tabs count for inserting
opt('b', 'shiftwidth', 4)                               -- Number of spaces used for tabs
opt('b', 'expandtab', true)                             -- Number of spaces used for >
opt('b', 'smartindent', true)                           -- Automatically indent after brackets
opt('w', 'number', true)                                -- Show number on the left
opt('w', 'wrap', false)                                 -- Disable line wrapping
opt('o', 'ignorecase', true)                            -- Ignore case in search patterns
opt('o', 'smartcase', true)                             -- Override ignorecase if the search pattern has uppercase
opt('b', 'swapfile', false)                             -- Disable swap file creation
opt('o', 'backup', false)                               -- Disable backup file creation
opt('o', 'undodir', home .. '/.config/nvim/undodir')    -- Set undo directory
opt('b', 'undofile', true)                              -- Allow undo file creation
opt('o', 'incsearch', true)                             -- Continue searching as the pattern is typed
opt('o', 'ruler', true)                                 -- Show line and column in the bottom
opt('b', 'formatoptions', 'tcqrn1')                     -- Rules of how to do automatic formating
opt('b', 'expandtab', true)                             -- The number of spaces to use for tabs in insert mode
opt('o', 'shiftround', false)                           -- Round indent to multiple of shiftwidth
opt('o', 'scrolloff', 4)                                -- Number of lines to keep at the bottom or top of the screen
opt('o', 'backspace', 'indent,eol,start')               -- Allow backspacing over autindent, line breaks, and start of indent
opt('b', 'matchpairs', '(:),{:},[:],<:>')               -- Can use % to jump between pairs
opt('o', 'laststatus', 2)                               -- Will always show status line
opt('o', 'showmode', true)                              -- Show mode on command line
opt('o', 'showcmd', true)                               -- Show last command
opt('o', 'hlsearch', true)                              -- Highlight searches
opt('o', 'showmatch', true)                             -- When a bracket is inserted, switch to the other one
opt('o', 'splitbelow', true)                            -- Better split options
opt('o', 'splitright', true)                            -- Better split options
opt('w', 'signcolumn', 'yes:1')                         -- Always show two columns
-- Mappings
function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('c', 'jk', '<ESC>')              -- Allow jk to escape cmd mode
map('c', 'kj', '<ESC>')              -- Allow jk to escape cmd mode
map('n', '<C-n>', '<cmd>noh<CR>')    -- Clear highlights
map('n', '/', '/\\v')                -- Require explicit pattern escaping
map('v', '/', '/\\v')                -- Require explicit pattern escaping
map('n', '<C-j>', '<C-W><C-J>')      -- Easy window switching
map('n', '<C-k>', '<C-W><C-K>')      -- Easy window switching
map('n', '<C-l>', '<C-W><C-L>')      -- Easy window switching
map('n', '<C-h>', '<C-W><C-H>')      -- Easy window switching

require('plugins')
require('gitgutter')
require('deoplete')
--require('fzf')
--require('theme')
--require('rust')
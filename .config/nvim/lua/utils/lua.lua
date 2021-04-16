local home = os.getenv("HOME")
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

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
opt('o', 'mouse', 'nv')                                  -- Allow mouse usage in normal mode
opt('o', 'termguicolors', true)                         -- Allow mouse usage in normal mode
opt('w', 'colorcolumn', '100')                          -- Set colored column
opt("o", "numberwidth", 2)
opt("o", "cmdheight", 1)
opt("o", "updatetime", 250) -- update interval for gitsigns 
opt("o", "clipboard", "unnamedplus")
opt("o", "listchars", "tab:▸ ,eol:¬")
cmd 'set list'
cmd 'highlight CursorLine guibg=#69696'                 -- Change color of cursor line, nice

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

return M

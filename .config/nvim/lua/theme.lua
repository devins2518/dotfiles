opt('o', 'termguicolors', true)                         -- Enables 24bit color
opt('o', 'background', 'dark')                          -- Set dark background
opt('w', 'colorcolumn', '80')                           -- Set colored column
cmd 'highlight ColorColumn guibg=#696969'               -- Change color of column, nice
cmd 'colorscheme codedark'                              -- VSCode Dark Color scheme
opt('o', 'listchars', 'tab:▸ ,eol:¬')                   -- Set chars at end of lines and tabs
cmd 'set list'                                          -- Show chars
cmd 'highlight CursorLine guibg=#69696'                 -- Change color of cursor line, nice
cmd 'set cursorline'                                    -- Highlight the row the cursor is on
cmd 'syntax on'                                         -- Keep current color settings

Map('n', '<C-M>', ':noh<CR>', {})
Map('n', '/', '/\\v', {})
Map('v', '/', '/\\v', {})
Map('n', '<C-j>', '<C-W><C-J>', {})
Map('n', '<C-k>', '<C-W><C-K>', {})
Map('n', '<C-l>', '<C-W><C-L>', {})
Map('n', '<C-h>', '<C-W><C-H>', {})
Map('n', '<C-S-.>', '<C-W>>', {})
Map('n', 'gb', '<C-^>', { noremap = true, silent = true })

-- LSP
local lsp_opt = { noremap = true, silent = true }
Map('n', 'K', ':Lspsaga hover_doc<CR>', lsp_opt)

-- Compe
local compe_opts = { expr = true }
local compe_ext_opts = { noremap = true, silent = true, expr = true }
Map('i', '<Tab>', 'v:lua.tab_complete()', compe_opts)
Map('i', '<Tab>', 'v:lua.tab_complete()', compe_opts)
Map('s', '<Tab>', 'v:lua.tab_complete()', compe_opts)
Map('i', '<S-Tab>', 'v:lua.s_tab_complete()', compe_opts)
Map('s', '<S-Tab>', 'v:lua.s_tab_complete()', compe_opts)
Map('i', '<C-Space>', 'compe#complete()', compe_ext_opts)
Map('i', '<CR>', 'compe#confirm(\'<CR>\')', compe_ext_opts)

-- NvimTree
Map('n', '<C-n>', ':NvimTreeToggle<CR>', {})

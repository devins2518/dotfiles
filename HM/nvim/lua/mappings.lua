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

-- NvimTree
Map('n', '<C-n>', ':NvimTreeToggle<CR>', {})

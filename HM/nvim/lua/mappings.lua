Map('n', '<C-m>', ':noh<CR>', {})
Map('n', '/', '/\\v', {})
Map('v', '/', '/\\v', {})
Map('n', '<C-j>', '<C-W><C-J>', {})
Map('n', '<C-k>', '<C-W><C-K>', {})
Map('n', '<C-l>', '<C-W><C-L>', {})
Map('n', '<C-h>', '<C-W><C-H>', {})
Map('n', '<C-S-.>', '<C-W>>', {})
Map('v', 'd', '"_d', { noremap = true })
Map('n', 'd', '"_d', { noremap = true })
Map('n', 'gb', '<C-^>', { noremap = true, silent = true })

-- LSP
local lsp_opt = { noremap = true, silent = true }
Map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opt)

-- NvimTree
Map('n', '<C-n>', ':NvimTreeFocus<CR>', {})

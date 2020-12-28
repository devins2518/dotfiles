-- deoplete
g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup
opt('o', 'completeopt', 'menuone,noinsert,noselect')
g['deoplete#enable_at_startup'] = 1
fn['deoplete#custom#option']('ignore_case', false)
fn['deoplete#custom#option']('max_list', 10)

local nvim_lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

-- Support for automatic parens
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {'bashls', 'ghcide', 'hie', 'pyls', 'rust_analyzer', 'sumneko_lua', 'vimls'}
for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern('.git', fn.getcwd()),
}
end

local opts = { noremap=true, silent=true }
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<leaer>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
map('n', '<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gb','<C-^>', opts)

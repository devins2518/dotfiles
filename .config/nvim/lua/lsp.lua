local nvim_lsp = require('lspconfig')

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'deoplete'.on_attach()

    -- Mappings
    local opts = { noremap=true, silent=true }
    ma(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    ma(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    ma(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    ma(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    ma(bufnr, 'n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    ma(bufnr, 'n', '<leaer>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    ma(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    ma(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    ma(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
    ma(bufnr, 'n', '<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    ma(bufnr, 'n', 'gb','<C-^>', opts)
end

-- Support for automatic parens
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local servers = {'bashls', 'ghcide', 'hie', 'pyls', 'rust_analyzer', 'sumneko_lua', 'vimls'}
for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
end

-- Diagnostics settings
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = '--',
    },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = function(bufnr, client_id)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      -- No buffer local variable set, so just enable by default
      if not ok then
        return true
      end

      return result
    end,
    -- Disable a feature
    update_in_insert = true,
  }
)

vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings.
local opts = {noremap = true, silent = true}
buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- buf_set_keymap("n", "N", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
buf_set_keymap("n", "<space>wa",
               "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
buf_set_keymap("n", "<space>wr",
               "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
buf_set_keymap("n", "<space>wl",
               "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
               opts)
buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
buf_set_keymap("n", "<space>e",
               "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
               opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--  lsp for html , css and js/ts
require"lspconfig".tsserver.setup {}
require"lspconfig".cssls.setup {}
require"lspconfig".html.setup {}
require"lspconfig".rust_analyzer.setup {}
require"lspconfig".bashls.setup {}
require"lspconfig".clangd.setup {}
require"lspconfig".sqls.setup {}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = true,
        signs = {enable = true, priority = 20},
        -- Disable a feature
        update_in_insert = false
    })

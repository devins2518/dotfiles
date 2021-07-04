-- TODO figure out why this don't work
vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "",
    numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "",
    numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "",
    numhl = "LspDiagnosticsSignInformation"
})
local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config({
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '',
    indicator_hint = '',
    indicator_ok = '﫠',
  })

vim.cmd("nnoremap <silent> <leader>ld <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> <leader>lD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> <leader>li <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <leader>ln :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")
vim.cmd("nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>")
vim.cmd("nnoremap <silent> [d :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> ]d :Lspsaga diagnostic_jump_next<CR>")
-- vim.cmd(
-- 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ", "   (Method)", "   (Function)",
    "   (Constructor)", " ﴲ  (Field)", "[] (Variable)", "   (Class)",
    " ﰮ  (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)",
    "   (Value)", " 練 (Enum)", "   (Keyword)", "   (Snippet)",
    "   (Color)", "   (File)", "   (Reference)", "   (Folder)",
    "   (EnumMember)", " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)",
    "   (Operator)", "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
            hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end
local lsp_config = {}

-- function lsp_config.common_on_attach(client, bufnr)
-- documentHighlight(client, bufnr)
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = {"rust_analyzer", "gopls", "zls", "rnix"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = lsp_status.on_attach,
        capabilities = lsp_status.capabilities
    }
end

nvim_lsp.clangd.setup({
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = {clangdFileStatus = true},
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
})

-- 	https://github.com/golang/go/issues/41081
nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {gopls = {staticcheck = true, env = {GOFLAGS = "-tags=test"}}}
}

-- TODO: fix
-- nvim_lsp.zls.setup {
-- cmd = {"zls"},
-- settings = {
-- zls = {
-- enable_semantic_tokens = true,
-- enable_snippets = true,
-- operator_completions = true,
-- warn_style = true
-- }
-- }
-- }

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = true,
        signs = {enable = true, priority = 20},
        -- Disable a feature
        update_in_insert = false
    }, require('lsp_extensions.workspace.diagnostic').handler,
                 {signs = {severity_limit = "Error"}})

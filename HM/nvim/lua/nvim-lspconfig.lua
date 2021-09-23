local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- TODO figure out why this don't work
vim.fn.sign_define('LspDiagnosticsSignError', {
    texthl = 'LspDiagnosticsSignError',
    text = '',
    numhl = 'LspDiagnosticsSignError'
})
vim.fn.sign_define('LspDiagnosticsSignWarning', {
    texthl = 'LspDiagnosticsSignWarning',
    text = '',
    numhl = 'LspDiagnosticsSignWarning'
})
vim.fn.sign_define('LspDiagnosticsSignHint', {
    texthl = 'LspDiagnosticsSignHint',
    text = '',
    numhl = 'LspDiagnosticsSignHint'
})
vim.fn.sign_define('LspDiagnosticsSignInformation', {
    texthl = 'LspDiagnosticsSignInformation',
    text = '',
    numhl = 'LspDiagnosticsSignInformation'
})

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    '   (Text) ',
    '   (Method)',
    '   (Function)',
    '   (Constructor)',
    ' ﴲ  (Field)',
    '[] (Variable)',
    '   (Class)',
    ' ﰮ  (Interface)',
    '   (Module)',
    ' 襁 (Property)',
    '   (Unit)',
    '   (Value)',
    ' 練 (Enum)',
    '   (Keyword)',
    '   (Snippet)',
    '   (Color)',
    '   (File)',
    '   (Reference)',
    '   (Folder)',
    '   (EnumMember)',
    ' ﲀ  (Constant)',
    ' ﳤ  (Struct)',
    '   (Event)',
    '   (Operator)',
    '   (TypeParameter)'
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end
local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    documentHighlight(client, bufnr)
    require('lsp_signature').on_attach({
        bind = false,
        doc_lines = 2,
        floating_window = true,
        fix_pos = false,
        hint_enable = true,
        use_lspsaga = false,
        hi_parameter = 'Search',
        max_height = 5,
        max_width = 60,
        handler_opts = {
            border = 'double' -- double, single, shadow, none
        },
        extra_trigger_chars = {}
    })
    return lsp_status.on_attach
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp = vim.lsp
local handlers = lsp.handlers

-- Hover doc popup
local pop_opts = { border = 'rounded', max_width = 80 }
handlers['textDocument/hover'] = lsp.with(handlers.hover, pop_opts)

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
capabilities = vim.tbl_extend('keep', capabilities or {},
    lsp_status.capabilities)
local servers = {
    'clangd',
    'gopls',
    'rnix',
    'rust_analyzer',
    'sumneko_lua',
    'zls'
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = lsp_config.common_on_attach,
        capabilities = lsp_status.capabilities
    }
end

nvim_lsp.rust_analyzer.setup({
    cargo = { allFeatures = true },
    checkOnSave = { allTargets = true },
    experimental = { procAttrMacros = true }
})

nvim_lsp.clangd.setup({
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = { clangdFileStatus = true }
})

-- 	https://github.com/golang/go/issues/41081
nvim_lsp.gopls.setup {
    cmd = { 'gopls', 'serve' },
    settings = {
        gopls = { staticcheck = true, env = { GOFLAGS = '-tags=test' } }
    }
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

local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = 'lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
require'lspconfig'.sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT', path = runtime_path },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            telemetry = { enable = false }
        }
    }
}

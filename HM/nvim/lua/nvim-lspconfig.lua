local nvim_lsp = require('lspconfig')

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

local lsp_config = {}

function lsp_config.common_on_attach(_, _)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                                                                .make_client_capabilities())

local lsp = vim.lsp
local handlers = lsp.handlers

-- Hover doc popup
local pop_opts = { border = 'rounded', max_width = 80 }
handlers['textDocument/hover'] = lsp.with(handlers.hover, pop_opts)

local servers = {
    'clangd',
    'gopls',
    'hls',
    'lua_ls',
    'ocamllsp',
    'rnix',
    'rust_analyzer',
    'texlab',
    'zls'
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = lsp_config.common_on_attach,
        capabilities = capabilities
    }
end

nvim_lsp.rust_analyzer.setup({
    cargo = { allFeatures = true },
    checkOnSave = { allTargets = true },
    experimental = { procAttrMacros = true }
})

nvim_lsp.clangd.setup({ init_options = { clangdFileStatus = true } })

-- 	https://github.com/golang/go/issues/41081
nvim_lsp.gopls.setup {
    cmd = { 'gopls', 'serve' },
    settings = {
        gopls = { staticcheck = true, env = { GOFLAGS = '-tags=test' } }
    }
}

local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = 'lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
require'lspconfig'.lua_ls.setup {
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

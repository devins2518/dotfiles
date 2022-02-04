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
    local cfg = {
        log_path = vim.fn.stdpath('cache') .. '/lsp_signature.log',
        verbose = false,
        bind = true,
        doc_lines = 10,
        floating_window = true,
        floating_window_above_cur_line = true,
        floating_window_off_x = 1,
        floating_window_off_y = 1,
        fix_pos = true,
        hint_enable = true,
        hint_prefix = '➤',
        hint_scheme = 'String',
        hi_parameter = 'LspSignatureActiveParameter',
        max_height = 12,
        max_width = 80,
        handler_opts = {
            border = 'rounded' -- double, rounded, single, shadow, none
        },
        always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
        auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
        extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
        padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
        transparency = nil, -- disabled by default, allow floating win transparent value 1~100
        timer_interval = 100, -- default timer check interval set to lower value if you want to reduce latency
        toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }
    return require'lsp_signature'.setup(cfg)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
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
    'rnix',
    'rust_analyzer',
    'sumneko_lua',
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

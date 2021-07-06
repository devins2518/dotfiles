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
    text = "",
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
    indicator_hint = '',
    indicator_ok = '﫠'
})

vim.cmd("nnoremap <silent> <leader>ld <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> <leader>lD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> <leader>li <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <leader>ln :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")
vim.cmd("nnoremap <silent> <leader>rn :Lspsaga rename<CR>")
vim.cmd("nnoremap <silent> [d :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> ]d :Lspsaga diagnostic_jump_next<CR>")

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
        use_lspsaga = true,
        hi_parameter = "Search",
        max_height = 5,
        max_width = 60,
        handler_opts = {
            border = "double" -- double, single, shadow, none
        },
        extra_trigger_chars = {}
    })
    return lsp_status.on_attach
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = {"rust_analyzer", "gopls", "zls", "rnix", "sumneko_lua"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = lsp_config.common_on_attach,
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

local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = "lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = runtime_path},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {prefix = "", spacing = 2},
        signs = {enable = true, priority = 20},
        -- Disable a feature
        update_in_insert = false
    }, require('lsp_extensions.workspace.diagnostic').handler,
                 {signs = {severity_limit = "Error"}})

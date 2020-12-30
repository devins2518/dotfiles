-- Completion Settings
g['completion_trigger_keyword_length'] = 1                                      -- enable deoplete at startup
g['completion_trigger_on_delete'] = 1                                           -- enable deoplete at startup
g['completion_matching_strategy_list'] = { 'exact', 'substring' }               -- enable deoplete at startup
g['completion_enable_snippet'] = 'vim-vsnip'                                    -- enable deoplete at startup
g['completion_matching_smart_case'] = 1                                         -- enable deoplete at startup
g['completion_timer_cycle'] = 80                                                -- enable deoplete at startup
g['completion_confirm_key'] = ""                                                -- enable deoplete at startup
g['completion_enable_auto_hover'] = 1
g['completion_enable_auto_signature'] = 1
g['completion_auto_change_source'] = 1
g['completion_max_items'] = 10
g['completion_enable_auto_paren'] = 1
opt('b', 'complete', '.,w,b,u')
opt('o', 'shortmess', 'filnxtToOFc')
opt('o', 'completeopt', 'menu,menuone,noinsert,preview')                                -- Better autocomplete experience

map('i', '<c-Space>', '<cmd>lua require\'completion\'.triggerCompletion()<CR>',            -- 
    { silent=true })
map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"',
    { silent=true, expr=true })
map('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"',
    { silent=true, expr=true })
map('i', '<CR>', 'pumvisible() ? complete_info()["selected"] != "-1" ? "<cmd>call completion#wrap_completion()<CR>"  : "<c-e><CR>" :  "<CR>"',
    { silent=true, expr=true })
map('i', '<Tab>', 'pumvisible() ? complete_info()["selected"] != "-1" ? "<cmd>call completion#wrap_completion()<CR>"  : "<c-e><CR>" :  "<CR>"',
    { silent=true, expr=true })

-- Diagnostics settings
g['diagnostic_enable_virtual_text'] = 0
g['diagnostic_virtual_text_prefix'] = ' '
g['diagnostic_trimmed_virtual_text'] = 0
g['diagnostic_insert_delay'] = 1

local chain_complete_list = {
  comment = {},
  string = {
    {complete_items = {'path'}, triggered_only = {'/'}},
  },
  default = {
    {complete_items = {'lsp', 'vim-vsnip'}},
    {complete_items = {'path'}, triggered_only = {'/'}},
    {complete_items = {'buffers'}},
  },
}

local nvim_lsp = require 'lspconfig'

local servers = {'bashls', 'pyls', 'rust_analyzer', 'sumneko_lua', 'vimls'}

-- Support for automatic parens
local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach({
        matching_strategy_list = {'exact', 'fuzzy'},
        chain_complete_list = chain_complete_list,
    })

    -- Support for automatic parens
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local servers = {'bashls', 'pyls', 'rust_analyzer', 'sumneko_lua', 'vimls'}

    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end

    -- Mappings
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
local autocmds = {
    completion = {
        {"BufEnter",     "*",     "lua require'completion'.on_attach()"};
    };
}

create_augroups(autocmds)

cmd 'highlight LspDiagnosticsDefaultError guifg=#db4b35'             -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsDefaultWarning guifg=#f0ea4d'           -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsDefaultInformation guifg=#f7f6d7'       -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsDefaultHint guifg=#dbdbcc'              -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsVirtualTextError guifg=#db4b35'         -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsVirtualTextWarning guifg=#f0ea4d'       -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsVirtualTextInformation guifg=#f7f6d7'   -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsVirtualTextHint guifg=#dbdbcc'          -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsUnderlineError guifg=#db4b35'           -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsUnderlineWarning guifg=#f0ea4d'         -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsUnderlineInformation guifg=#f7f6d7'     -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsUnderlineHint guifg=#dbdbcc'            -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsFloatingError guifg=#db4b35'            -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsFloatingWarning guifg=#f0ea4d'          -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsFloatingInformation guifg=#f7f6d7'      -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsFloatingHint guifg=#dbdbcc'             -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsSignError guifg=#db4b35'                -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsSignWarning guifg=#f0ea4d'              -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsSignInformation guifg=#f7f6d7'          -- Change color of cursor line, nice
cmd 'highlight LspDiagnosticsSignHint guifg=#dbdbcc'                 -- Change color of cursor line, nice

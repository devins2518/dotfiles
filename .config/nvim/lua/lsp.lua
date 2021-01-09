-- Completion Settings
g['completion_trigger_keyword_length'] = 1                                      -- enable deoplete at startup
g['completion_trigger_on_delete'] = 1                                           -- enable deoplete at startup
g['completion_matching_strategy_list'] = {'exact', 'substring', 'fuzzy'}
g['completion_enable_snippet'] = 'vim-vsnip'                                    -- enable deoplete at startup
g['completion_confirm_key'] = ""                                                -- enable deoplete at startup
g['completion_enable_auto_hover'] = 1
g['completion_enable_auto_signature'] = 1
g['completion_auto_change_source'] = 1
g['completion_max_items'] = 5
g['completion_enable_auto_paren'] = 1
g['completion_trigger_character'] = { '.', '::' }
opt('b', 'complete', '.,w,b,u')
opt('o', 'shortmess', 'filnxtToOFc')
opt('o', 'completeopt', 'menuone,noinsert')                                -- Better autocomplete experience

vim.api.nvim_exec(
    [[
        imap <S-Tab> <Plug>(completion_smart_s_tab)
        imap <silent> <c-Space> <Plug>(completion_trigger)
    ]],
    true)
map('i', '<Tab>', 'pumvisible() ? complete_info()["selected"] != "-1" ?' ..
    '"<cmd>call completion#wrap_completion()<CR>" : "<c-e><CR>" : "<Tab>"',
    { silent=true, expr=true })
map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"',
    { silent=true, expr=true })
map('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"',
    { silent=true, expr=true })

-- Diagnostics settings
g['diagnostic_enable_virtual_text'] = 1
g['diagnostic_virtual_text_prefix'] = ' '
g['diagnostic_trimmed_virtual_text'] = 0


local lsp = require('lspconfig')
local lsp_completion = require('completion')
local lsp_status  = require('lsp-status')

local function on_attach(client)
    lsp_status.on_attach(client)
    lsp_completion.on_attach(client)
end

lsp_status.register_progress()

local default_lsp_config = {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- :LspInstall needed
local servers = {
    bashls = {},
    vimls = {},
    rust_analyzer = {},
}

for server, config in pairs(servers) do
    lsp[server].setup(vim.tbl_deep_extend("force", default_lsp_config, config))
end

-- Mappings.
local opts = { noremap=true, silent=true }
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leaer>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)

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
        signs = true,

        -- Disable a feature
        update_in_insert = false,
    }
)

--local autocmds = {
--    completion = {
--        {"BufEnter",     "*",     "lua require'completion'.on_attach()"};
--    };
--}
--
--create_augroups(autocmds)
--
--vim.cmd("highlight LspDiagnosticsLineNrWarning guifg=#E5C07B guibg=#4E4942 gui=bold")
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "🛈", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "!", texthl = "LspDiagnosticsSignHint"})

local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

if filetype == 'rust' then
    vim.cmd(
        [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
        .. [[aligned = true, prefix = " » " ]]
        .. [[} ]]
    )
end

--vim.cmd("sign define LspDiagnosticsSignWarning texthl=LspDiagnosticsSignWarning numhl=LspDiagnosticsLineNrWarning")
----cmd 'highlight LspDiagnosticsDefaultError guifg=\'BrightRed\''             -- 
----cmd 'highlight LspDiagnosticsDefaultWarning guifg=\'BrightRed\''           -- 
----cmd 'highlight LspDiagnosticsDefaultInformation guifg=\'BrightRed\''       -- 
----cmd 'highlight LspDiagnosticsDefaultHint guifg=\'BrightRed\''              -- 
----cmd 'highlight LspDiagnosticsVirtualTextError guifg=\'BrightRed\''         -- 
----cmd 'highlight LspDiagnosticsVirtualTextWarning guifg=\'BrightRed\''       -- 
----cmd 'highlight LspDiagnosticsVirtualTextInformation guifg=\'BrightRed\''   -- 
----cmd 'highlight LspDiagnosticsVirtualTextHint guifg=\'BrightRed\''          -- 
----cmd 'highlight LspDiagnosticsUnderlineError guifg=\'BrightRed\''           -- 
----cmd 'highlight LspDiagnosticsUnderlineWarning guifg=\'BrightRed\''         -- 
----cmd 'highlight LspDiagnosticsUnderlineInformation guifg=\'BrightRed\''     -- 
----cmd 'highlight LspDiagnosticsUnderlineHint guifg=\'BrightRed\''            -- 
----cmd 'highlight LspDiagnosticsFloatingError guifg=\'BrightRed\''            -- 
----cmd 'highlight LspDiagnosticsFloatingWarning guifg=\'BrightRed\''          -- 
----cmd 'highlight LspDiagnosticsFloatingInformation guifg=\'BrightRed\''      -- 
----cmd 'highlight LspDiagnosticsFloatingHint guifg=\'BrightRed\''             -- 
----cmd 'highlight LspDiagnosticsSignError guifg=\'BrightRed\''                -- 
----cmd 'highlight LspDiagnosticsSignWarning guifg=\'BrightRed\''              -- 
----cmd 'highlight LspDiagnosticsSignInformation guifg=\'BrightRed\''          -- 
----cmd 'highlight LspDiagnosticsSignHint guifg=\'BrightRed\''                 -- 
----cmd 'highlight LspDiagnosticsDefaultError guifg=#db4b35'             -- 
----cmd 'highlight LspDiagnosticsDefaultWarning guifg=#f0ea4d'           -- 
----cmd 'highlight LspDiagnosticsDefaultInformation guifg=#f7f6d7'       -- 
----cmd 'highlight LspDiagnosticsDefaultHint guifg=#dbdbcc'              -- 
----cmd 'highlight LspDiagnosticsVirtualTextError guifg=#db4b35'         -- 
----cmd 'highlight LspDiagnosticsVirtualTextWarning guifg=#f0ea4d'       -- 
----cmd 'highlight LspDiagnosticsVirtualTextInformation guifg=#f7f6d7'   -- 
----cmd 'highlight LspDiagnosticsVirtualTextHint guifg=#dbdbcc'          -- 
----cmd 'highlight LspDiagnosticsUnderlineError guifg=#db4b35'           -- 
----cmd 'highlight LspDiagnosticsUnderlineWarning guifg=#f0ea4d'         -- 
----cmd 'highlight LspDiagnosticsUnderlineInformation guifg=#f7f6d7'     -- 
----cmd 'highlight LspDiagnosticsUnderlineHint guifg=#dbdbcc'            -- 
----cmd 'highlight LspDiagnosticsFloatingError guifg=#db4b35'            -- 
----cmd 'highlight LspDiagnosticsFloatingWarning guifg=#f0ea4d'          -- 
----cmd 'highlight LspDiagnosticsFloatingInformation guifg=#f7f6d7'      -- 
----cmd 'highlight LspDiagnosticsFloatingHint guifg=#dbdbcc'             -- 
----cmd 'highlight LspDiagnosticsSignError guifg=#db4b35'                -- 
----cmd 'highlight LspDiagnosticsSignWarning guifg=#f0ea4d'              -- 
----cmd 'highlight LspDiagnosticsSignInformation guifg=#f7f6d7'          -- 
----cmd 'highlight LspDiagnosticsSignHint guifg=#dbdbcc'                 -- 

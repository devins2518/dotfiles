local present, cmp = pcall(require, 'cmp')
local compare = require('cmp.config.compare')

if not present then
    return
end

vim.opt.completeopt = 'menuone,noselect'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local kind_icons = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = ' ﴲ ',
    Variable = '[]',
    Class = '  ',
    Interface = ' ﰮ ',
    Module = '  ',
    Property = ' 襁',
    Unit = '  ',
    Value = '  ',
    Enum = ' 練',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = ' ﲀ ',
    Struct = ' ﳤ ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  '
}

-- nvim-cmp setup
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (kind_icons[vim_item.kind] or '') .. vim_item.kind
            return vim_item
        end
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                    '<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            elseif check_back_space() then
                vim.fn.feedkeys(t('<Tab>'), 'n')
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn.call('vsnip#available', { -1 }) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                    '<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            else
                fallback()
            end
        end, { 'i', 's' })
    },
    sorting = {
        priority_weight = 2.,
        comparators = { compare.score, compare.exact, compare.order }
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'nvim_lua' }
    }
}

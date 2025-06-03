local opt = vim.opt

opt.errorbells = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.config/nvim/undodir'
opt.undofile = true
opt.incsearch = true
opt.ruler = true
opt.formatoptions = 'tcqrn1'
opt.expandtab = true
opt.shiftround = false
opt.scrolloff = 4
opt.backspace = 'indent,eol,start'
opt.matchpairs:append('<:>')
opt.laststatus = 2
opt.showmode = true
opt.foldmethod = 'indent'
opt.foldlevel = 3
opt.showcmd = true
opt.hlsearch = false
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = 'yes:1'
opt.mouse = 'nv'
opt.numberwidth = 2
opt.cmdheight = 1
opt.updatetime = 250
opt.clipboard = 'unnamedplus'
opt.list = true
vim.cmd [[autocmd! VimEnter * highlight! link ColorColumn CursorLine]]
opt.listchars = 'tab:▸ ,eol:¬'
opt.colorcolumn = '100'
opt.cursorline = true
opt.termguicolors = true
vim.cmd [[let &fcs='eob: ']]
opt.whichwrap:append('<>hl')

G['mapleader'] = ' '
G['loaded_gzip'] = 1
G['loaded_tar'] = 1
G['loaded_tarPlugin'] = 1
G['loaded_zipPlugin'] = 1
G['loaded_2html_plugin'] = 1
G['loaded_netrw'] = 1
G['loaded_netrwPlugin'] = 1
G['loaded_matchit'] = 1
G['loaded_matchparen'] = 1
G['loaded_spec'] = 1
G['lsp_hover'] = true
vim.api.nvim_create_user_command('LSPHover',
    'lua vim.g.lsp_hover = not vim.g.lsp_hover', {})

Augroup('Folds', {
    { event = 'BufWinLeave', pattern = '?*', command = 'mkview 1' },
    { event = 'BufWinEnter', pattern = '?*', command = 'silent! loadview 1' }
})

Augroup('zig', {
    { event = 'FileType', pattern = 'gyro.zzz', command = 'set filetype=yaml' }
})

Augroup('rust', {
    {
        event = 'FileType',
        pattern = 'rust',
        command = 'nmap <leader>cc :Ccheck<CR>'
    },
    {
        event = 'FileType',
        pattern = 'rust',
        command = 'nmap <leader>cb :Cbuild<CR>'
    },
    {
        event = 'FileType',
        pattern = 'rust',
        command = 'nmap <leader>cr :Crun<CR>'
    },
    {
        event = 'FileType',
        pattern = 'rust',
        command = 'nmap <leader>cl :Cclean<CR>'
    }
})

Augroup('Markdown', {
    {
        event = 'FileType',
        pattern = 'markdown',
        command = 'set filetype=markdown'
    },
    {
        event = 'FileType',
        pattern = 'markdown',
        command = 'setlocal conceallevel=2'
    },
    { event = 'FileType', pattern = 'markdown', command = 'setlocal wrap' },
    {
        event = 'FileType',
        pattern = 'markdown',
        command = 'setlocal colorcolumn='
    },
    {
        event = 'FileType',
        pattern = 'markdown',
        command = 'setlocal scrolloff=999'
    },
    {
        event = 'FileType',
        pattern = 'markdown',
        command = 'nmap <leader>cp :!compilenote %<CR>'
    },
    {
        event = 'InsertLeave',
        pattern = '/home/devin/Repos/notes/*.md',
        command = 'silent! !compilenote % &'
    },
    {
        event = 'InsertCharPre',
        pattern = '*.md',
        command = 'if search(\'\v(%^|[.!?#-]_s)_s*%#\', \'bcnw\') != 0 | let v:char = toupper(v:char) | endif'
    }
})

Augroup('LaTex', {
    { event = 'FileType', pattern = 'tex', command = 'set filetype=tex' },
    { event = 'FileType', pattern = 'tex', command = 'setlocal linebreak' },
    { event = 'FileType', pattern = 'tex', command = 'setlocal textwidth=100' },
    { event = 'FileType', pattern = 'tex', command = 'setlocal colorcolumn=' },
    { event = 'FileType', pattern = 'tex', command = 'set conceallevel=0' },
    {
        event = 'InsertCharPre',
        pattern = '*.tex',
        command = 'if search(\'\v(%^|[.!?#-]_s)_s*%#\', \'bcnw\') != 0 | let v:char = toupper(v:char) | endif'
    }
})

Augroup('Format', {
    {
        event = 'BufEnter',
        pattern = '*',
        command = 'let b:format_run=get(b:, \'format_run\', "1")'
    },
    {
        event = 'BufWritePost',
        pattern = '*.lua,*.c,*.cc,*.cpp,*.nix,*.sh,*.h,*.hpp,*.ml,*.mli,*.zig,*.tex,*.rs',
        command = 'if b:format_run | silent! FormatWriteLock | endif'
    }
})

local function open_nvim_tree(data)
    require('nvim-tree.api').tree.toggle({ focus = false })
end
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
Augroup('NvimTreeClose', {
    {
        event = 'BufEnter',
        pattern = '*',
        command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
        nested = true
    }
})

Augroup('Systemverilog', {
    {
        event = 'FileType',
        pattern = '*.svh,*.vh',
        command = 'set filetype=systemverilog'
    },
    { event = 'FileType', pattern = '*.core', command = 'set filetype=yaml' }
})

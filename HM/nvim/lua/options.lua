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
opt.foldmethod = 'manual'
opt.showcmd = true
opt.hlsearch = true
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

Augroup('remember_folds', {
    [[autocmd BufWinLeave ?* mkview 1]],
    [[autocmd BufWinEnter ?* silent! loadview 1]]
})

Augroup('zig', { [[autocmd BufNewFile,BufRead gyro.zzz set filetype=yaml]] })

Augroup('rust', {
    [[autocmd FileType rust nmap <leader>cc :Ccheck<CR>]],
    [[autocmd FileType rust nmap <leader>cb :Cbuild<CR>]],
    [[autocmd FileType rust nmap <leader>cr :Crun<CR>]],
    [[autocmd FileType rust nmap <leader>cl :Cclean<CR>]],
    [[autocmd BufEnter,BufWinEnter,BufWritePost,InsertLeave, \
        TabEnterBufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs \
        :lua require'lsp_extensions'.inlay_hints{ highlight = "NonText", prefix = \
        " » " ,enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}]]
})

Augroup('Markdown', {
    [[autocmd BufNewFile,BufRead *.md set filetype=markdown]],
    [[autocmd FileType markdown set conceallevel=2]],
    [[autocmd Filetype markdown set wrap]],
    [[autocmd FileType markdown set colorcolumn=]],
    [[autocmd FileType markdown set scrolloff=999]],
    [[autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>]],
    [[autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &]],
    [[autocmd InsertCharPre *.md if search('\v(%^|[.!?#-]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif]]
})

Augroup('NvimTree', {
    [[autocmd VimEnter * NvimTreeOpen]],
    [[autocmd VimEnter * wincmd p]]
})

Augroup('Header', { [[autocmd BufEnter *.h :TSBufDisable highlight]] })

Augroup('Format', {
    [[autocmd BufWritePost *.lua,*.c,*.cpp,*.nix,*.sh,*.h,*.hpp,*.ml if g:format_run | silent! FormatWrite | endif]],
    [[autocmd FileType sh silent! FormatWrite]]
})

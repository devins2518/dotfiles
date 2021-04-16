local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- keybind list
map("", "<leader>c", '"+y')

-- open terminals  
map("n", "<C-b>" , [[<Cmd> vnew term://zsh<CR>]] , opt) -- split term vertically , over the right  
map("n", "<C-x>" , [[<Cmd> split term://zsh | resize 10 <CR>]] , opt) -- split term vertically , over the right  

map('n', '<C-m>', '<cmd>noh<CR>')                       -- Clear highlights
map('n', '/', '/\\v')                                   -- Require explicit pattern escaping
map('v', '/', '/\\v')                                   -- Require explicit pattern escaping
map('n', '<C-j>', '<C-W><C-J>')                         -- Easy window switching
map('n', '<C-k>', '<C-W><C-K>')                         -- Easy window switching
map('n', '<C-l>', '<C-W><C-L>')                         -- Easy window switching
map('n', '<C-h>', '<C-W><C-H>')                         -- Easy window switching
map("n", "++" , [[<Cmd> MultiCommenterToggle<CR>]] , opt) -- split term vertically , over the right  
map("v", "++" , [[<Cmd> MultiCommenterToggle<CR>]] , opt) -- split term vertically , over the right  
map('n', "<leader>gs", ":G<CR>")
map('n', "<leader>gj", ":diffget //3<CR>")
map('n', "<leader>gf", ":diffget //2<CR>")


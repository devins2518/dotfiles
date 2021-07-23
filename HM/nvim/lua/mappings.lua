Map("n", "<C-M>", ":noh<CR>", {})
Map("n", "/", "//\v", {})
Map("v", "/", "//\v", {})
Map("n", "<C-j>", "<C-W><C-J>", {})
Map("n", "<C-k>", "<C-W><C-K>", {})
Map("n", "<C-l>", "<C-W><C-L>", {})
Map("n", "<C-h>", "<C-W><C-H>", {})
Map("n", "<C-S-.>", "<C-W>>", {})
Map("n", "gb", "<C-^>", { noremap = true, silent = true })

-- Telescope
local tele_opt = { noremap = true, silent = true }
Map("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files()<CR>",
    tele_opt)
Map("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<CR>",
    tele_opt)
Map("n", "<leader>th", "<cmd>lua require('telescope.builtin').help_tags()<CR>",
    tele_opt)
Map("n", "<leader>to", "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
    tele_opt)

-- Git signs
local git_opt = { noremap = true }
local git_expr_opt = { noremap = true, expr = true }
Map("n", "]c",
    [[&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\']],
    git_expr_opt)
Map("n", "[c",
    [[&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\']],
    git_expr_opt)

Map("n", "<leader>hs", '<cmd>lua require"gitsigns".stage_hunk()<CR>', git_opt)
Map("n", "<leader>hu", '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    git_opt)
Map("n", "<leader>hr", '<cmd>lua require"gitsigns".reset_hunk()<CR>', git_opt)
Map("n", "<leader>hp", '<cmd>lua require"gitsigns".preview_hunk()<CR>', git_opt)
Map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line()<CR>', git_opt)

-- LSP
local lsp_opt = { noremap = true, silent = true }
Map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", lsp_opt)
Map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", lsp_opt)
Map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", lsp_opt)
Map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", lsp_opt)
Map("n", "<leader>lc", ":Lspsaga code_action<CR>", lsp_opt)
Map("n", "K", ":Lspsaga hover_doc<CR>", lsp_opt)
Map("n", "<leader>ln", ":Lspsaga rename<CR>", lsp_opt)
Map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", lsp_opt)
Map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", lsp_opt)

-- Compe
local compe_opts = { expr = true }
local compe_ext_opts = { noremap = true, silent = true, expr = true }
Map("i", "<Tab>", "v:lua.tab_complete()", compe_opts)
Map("i", "<Tab>", "v:lua.tab_complete()", compe_opts)
Map("s", "<Tab>", "v:lua.tab_complete()", compe_opts)
Map("i", "<S-Tab>", "v:lua.s_tab_complete()", compe_opts)
Map("s", "<S-Tab>", "v:lua.s_tab_complete()", compe_opts)
Map("i", "<C-Space>", "compe#complete()", compe_ext_opts)
Map("i", "<CR>",
    "compe#confirm(luaeval(\"require 'nvim-autopairs'.autopairs_cr()\"))",
    compe_ext_opts)

-- Fugitive
Map("n", "<leader>gs", [[:G<CR>]], {})
Map("n", "<leader>gj", [[:diffget //3<CR>]], {})
Map("n", "<leader>gf", [[:diffget //2<CR>]], {})

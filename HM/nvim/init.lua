G = vim.g
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function Augroup(name, commands)
    vim.api.nvim_create_augroup(name, { clear = true });
    for _, v in pairs(commands) do
        local a = {
            group = name,
            pattern = v.pattern,
            command = v.command,
            callback = v.callback,
            nested = v.nested or false
        }
        vim.api.nvim_create_autocmd(v.event, a)
    end
end

require 'mappings'
require 'options'
require 'statusline'
require 'plugins'

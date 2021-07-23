G = vim.g
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function Augroup(name, commands)
    vim.api.nvim_command([[augroup ]] .. name)
    vim.api.nvim_command([[au!]])
    for _, v in pairs(commands) do
        vim.api.nvim_command(v)
    end
    vim.api.nvim_command([[augroup END]])
end

require "options"
require "mappings"

local async
async = vim.loop.new_async(vim.schedule_wrap(function()
    require "plugins"
    async:close()
end))
async:send()

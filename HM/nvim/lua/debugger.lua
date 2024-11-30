local dap = require('dap')
local ui = require('dapui')

require('dapui').setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r'
    },
    sidebar = {
        elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
                id = 'scopes',
                size = 0.25 -- Can be float or integer > 1
            },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 00.25 }
        },
        size = 40,
        position = 'left' -- Can be "left", "right", "top", "bottom"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        mappings = { close = { 'q', '<Esc>' } }
    },
    windows = { indent = 1 }
})

-- Update this path
local extension_path = os.getenv('CODELLDB_PATH') .. '/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb'
local this_os = vim.uv.os_uname().sysname;

-- The liblldb extension is .so for Linux and .dylib for MacOS
liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')

local cfg = require('rustaceanvim.config')

dap.adapters.lldb = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)

dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
                'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'lldb',
        request = 'launch',
        MIMode = 'lldb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = 'lldb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
                'file')
        end
    }
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

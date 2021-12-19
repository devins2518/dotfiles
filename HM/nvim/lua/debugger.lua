local dap = require('dap')

require('telescope').load_extension('dap')

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

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode', -- adjust as needed
    name = 'lldb'
}

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

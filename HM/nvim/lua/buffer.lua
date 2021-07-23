-- colors for active , inactive buffer tabs
require"bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        enforce_regular_tabs = true,
        view = "multiwindow",
        show_buffer_close_icons = true,
        show_buffer_icons = true,
        always_show_bufferline = true,
        separator_style = "slant",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center"
            }
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " " or
                                (e == "warning" and " " or "")
                s = s .. n .. sym
            end
            return s
        end
    },
    custom_areas = {
        right = function()
            local result = {}
            local error = vim.lsp.diagnostic.get_count(0, [[Error]])
            local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
            local info = vim.lsp.diagnostic.get_count(0, [[Information]])
            local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

            if error ~= 0 then
                table.insert(result,
                    { text = "  " .. error, guifg = "#EC5241" })
            end

            if warning ~= 0 then
                table.insert(result,
                    { text = "  " .. warning, guifg = "#EFB839" })
            end

            if hint ~= 0 then
                table.insert(result,
                    { text = "  " .. hint, guifg = "#A3BA5E" })
            end

            if info ~= 0 then
                table.insert(result,
                    { text = "  " .. info, guifg = "#7EA9A7" })
            end
            return result
        end
    },
    extensions = { "nvim-tree" }
}

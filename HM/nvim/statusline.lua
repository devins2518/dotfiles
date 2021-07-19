local colors = {
    bg = "#1a1b26",
    line_bg = "#1f2335",
    fg = "#c5cdd9",
    fg_green = "#a0c980",
    yellow = "#deb974",
    cyan = "#44adb3",
    darkblue = "#5b8dc2",
    green = "#b2e08f",
    orange = "#FF8800",
    purple = "#a57ec8",
    magenta = "#d38aea",
    blue = "#6cb6eb",
    red = "#ec7279",
    lightbg = "#363a49",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}

local function dirname()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return "  " .. dir_name .. " "
end

-- TODO: Doesn't update
-- local function lsp_progress()
--     local messages = vim.lsp.util.get_progress_messages()
--     if #messages == 0 then return end
--     local status = {}
--     for _, msg in pairs(messages) do
--         local name = msg.name
--         local count = #status
--         for i = 0, count do status[i] = nil end
--         table.insert(status, name .. " " .. (msg.percentage or 0) .. "%%")
--     end
--     return table.concat(status)
-- end

require("lualine").setup({
    options = {
        theme = "tokyonight",
        section_separators = {"", ""},
        component_separators = {"", ""},
        icons_enabled = true
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"filetype", "filename"},
        lualine_c = {
            "branch", {
                "diff",
                color_added = colors.fg_green,
                color_modified = colors.yellow,
                color_removed = colors.red,
                symbols = {added = ' ', modified = ' ', removed = ' '}

            }
        },
        lualine_d = {dirname},
        lualine_x = {
            {"diagnostics", sources = {"nvim_lsp"}},
            require("lsp-status").status
        },
        lualine_y = {"progress"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {"nvim-tree"}
})

-- local gl = require("galaxyline")
-- local gls = gl.section
-- local condition = require("galaxyline.condition")
-- local fileinfo = require('galaxyline.provider_fileinfo')
-- gl.short_line_list = {}

-- gls.left[1] = {
--     FirstElement = {
--         provider = function() return "" end,
--         highlight = {colors.fg, colors.line_bg}
--     }
-- }

-- gls.left[2] = {
--     statusIcon = {
--         provider = function() return " " end,
--         highlight = {colors.line_bg, colors.fg},
--         separator = " ",
--         separator_highlight = {colors.fg, colors.line_bg}
--     }
-- }

-- gls.left[3] = {
--     FirstElement = {
--         provider = function() return "" end,
--         highlight = {colors.lightbg, colors.line_bg}
--     }
-- }
-- gls.left[4] = {
--     FileIcon = {
--         provider = function()
--             local str = fileinfo.get_file_icon():gsub("%s+", "")
--             return "  " .. str .. " "
--         end,
--         condition = condition.buffer_not_empty,
--         highlight = {
--             require("galaxyline.provider_fileinfo").get_file_icon_color,
--             colors.lightbg
--         }
--     }
-- }

-- gls.left[5] = {
--     FileName = {
--         provider = function()
--             return fileinfo.get_current_file_name():gsub("%s+", "") .. "  "
--         end,
--         condition = condition.buffer_not_empty,
--         highlight = {colors.white, colors.lightbg},
--         separator = "",
--         separator_highlight = {colors.lightbg, colors.line_bg}
--     }
-- }

-- gls.left[5] = {
--     current_dir = {
--         provider = function()
--             local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--             return "  " .. dir_name .. " "
--         end,
--         highlight = {colors.lightbg2, colors.statusline_bg},
--         separator = "",
--         separator_highlight = {colors.lightbg2, colors.statusline_bg}
--     }
-- }

-- local checkwidth = function()
--     local squeeze_width = vim.fn.winwidth(0) / 2
--     if squeeze_width > 30 then return true end
--     return false
-- end

-- gls.left[6] = {
--     DiffAdd = {
--         provider = "DiffAdd",
--         condition = checkwidth,
--         icon = "  ",
--         highlight = {colors.fg_green, colors.statusline_bg}
--     }
-- }

-- gls.left[7] = {
--     DiffModified = {
--         provider = "DiffModified",
--         condition = checkwidth,
--         icon = "   ",
--         highlight = {colors.yellow, colors.statusline_bg}
--     }
-- }

-- gls.left[8] = {
--     DiffRemove = {
--         provider = "DiffRemove",
--         condition = checkwidth,
--         icon = "  ",
--         highlight = {colors.red, colors.statusline_bg}
--     }
-- }

-- gls.left[9] = {
--     DiagnosticError = {
--         provider = "DiagnosticError",
--         icon = "  ",
--         highlight = {colors.red, colors.statusline_bg}
--     }
-- }

-- gls.left[10] = {
--     DiagnosticWarn = {
--         provider = "DiagnosticWarn",
--         icon = "  ",
--         highlight = {colors.yellow, colors.statusline_bg}
--     }
-- }

-- gls.right[1] = {
--     lsp_status = {
--         provider = function()
--             if #vim.lsp.get_active_clients() > 0 then
--                 return ' ' .. require("lsp-status").status()
--             else
--                 return ''
--             end
--         end,
--         condition = condition.check_active_lsp,
--         highlight = {
--             require("galaxyline.provider_fileinfo").get_file_icon_color,
--             colors.statusline_bg
--         }
--     }
-- }

-- gls.right[2] = {
--     GitIcon = {
--         provider = function() return " " end,
--         condition = require("galaxyline.condition").check_git_workspace,
--         highlight = {colors.grey_fg2, colors.statusline_bg},
--         separator = " ",
--         separator_highlight = {colors.statusline_bg, colors.statusline_bg}
--     }
-- }

-- gls.right[3] = {
--     GitBranch = {
--         provider = "GitBranch",
--         condition = require("galaxyline.condition").check_git_workspace,
--         highlight = {colors.grey_fg2, colors.statusline_bg}
--     }
-- }

-- gls.right[4] = {
--     viMode_icon = {
--         provider = function() return " " end,
--         highlight = {colors.statusline_bg, colors.red},
--         separator = " ",
--         separator_highlight = {colors.red, colors.statusline_bg}
--     }
-- }

-- gls.right[5] = {
--     ViMode = {
--         provider = function()
--             local alias = {
--                 n = "Normal",
--                 i = "Insert",
--                 c = "Command",
--                 V = "Visual",
--                 [""] = "Visual",
--                 v = "Visual",
--                 R = "Replace"
--             }
--             local current_Mode = alias[vim.fn.mode()]

--             if current_Mode == nil then
--                 return "  Terminal "
--             else
--                 return "  " .. current_Mode .. " "
--             end
--         end,
--         highlight = {colors.red, colors.lightbg}
--     }
-- }

-- gls.right[6] = {
--     some_icon = {
--         provider = function() return " " end,
--         separator = "",
--         separator_highlight = {colors.green, colors.lightbg},
--         highlight = {colors.lightbg, colors.green}
--     }
-- }

-- gls.right[7] = {
--     line_percentage = {
--         provider = function()
--             local current_line = vim.fn.line(".")
--             local total_line = vim.fn.line("$")

--             if current_line == 1 then
--                 return "  Top "
--             elseif current_line == vim.fn.line("$") then
--                 return "  Bot "
--             end
--             local result, _ = math.modf((current_line / total_line) * 100)
--             return "  " .. result .. "% "
--         end,
--         highlight = {colors.green, colors.lightbg}
--     }
-- }

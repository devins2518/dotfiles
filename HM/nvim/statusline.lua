local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {}

local colors = {
    bg = "#2b2d37",
    line_bg = "#282c34",
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

gls.left[1] = {
    leftRounded = {
        provider = function() return "█" end,
        highlight = {colors.nord, colors.bg}
    }
}

gls.left[2] = {
    ViMode = {
        provider = function() return "   " end,
        highlight = {colors.bg, colors.nord},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {
            require("galaxyline.provider_fileinfo").get_file_icon_color,
            colors.lightbg
        }
    }
}

gls.left[4] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.left[5] = {
    teech = {
        provider = function() return "█" end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[9] = {
    LeftEnd = {
        provider = function() return " " end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[10] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[11] = {
    Space = {
        provider = function() return " " end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[12] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.left[13] = {
    GetLspClient = {
        provider = function()
            -- if #vim.lsp.buf_get_clients() > 0 then
            if #vim.lsp.get_active_clients() > 0 then
                return ' ' .. require'lsp-status'.status()
            end
            return ''
        end,
        condition = check_active_lsp,
        highlight = {
            require("galaxyline.provider_fileinfo").get_file_icon_color,
            colors.lightbg
        }

    }
}

gls.right[1] = {
    GitIcon = {
        provider = function() return "   " end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[3] = {
    right_LeftRounded = {
        provider = function() return "█" end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.red, colors.bg}
    }
}

gls.right[4] = {
    SiMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                V = "VISUAL",
                [""] = "VISUAL",
                v = "VISUAL",
                R = "REPLACE"
            }
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.bg, colors.red}
    }
}

gls.right[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.red, colors.red},
        highlight = {colors.bg, colors.fg}
    }
}

gls.right[6] = {
    rightRounded = {
        provider = function() return "█" end,
        highlight = {colors.fg, colors.bg}
    }
}

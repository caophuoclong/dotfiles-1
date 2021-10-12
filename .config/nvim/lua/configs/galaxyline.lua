local ok, gl = pcall(require, "galaxyline")

if ok then
    local colors = require("utils").colors
    local gls = gl.section
    gl.short_line_list = {"NvimTree", "vista", "dbui"}
    local diagnostic = gl.provider_diagnostic
    local vcs = gl.provider_vcs
    local fileinfo = gl.provider_fileinfo
    local extension = gl.provider_extensions
    local buffer = gl.provider_buffer
    local whitespace = gl.provider_whitespace
    local lspclient = gl.provider_lsp

    local function lsp_status(status)
        shorter_stat = ""
        for match in string.gmatch(status, "[^%s]+") do
            err_warn = string.find(match, "^[WE]%d+", 0)
            if not err_warn then
                shorter_stat = shorter_stat .. " " .. match
            end
        end
        return shorter_stat
    end

    function get_diagnostic_info()
        if vim.fn.exists("*coc#rpc#start_server") == 1 then
            return get_coc_lsp()
        end
        return ""
    end

    local function trailing_whitespace()
        local trail = vim.fn.search("\\s$", "nw")
        if trail ~= 0 then
            return " "
        else
            return nil
        end
    end

    TrailingWhiteSpace = trailing_whitespace

    local buffer_not_empty = function()
        if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
            return true
        end
        return false
    end

    gls.left[1] = {
        RainbowRed = {
            provider = function()
                return " "
            end,
            highlight = {colors.white1, colors.white1}
        }
    }

    gls.left[2] = {
        RainbowBg = {
            provider = function()
                return "  "
            end,
            highlight = {colors.bg, colors.bg}
        }
    }

    gls.left[3] = {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local mode_color = {
                    n = colors.blue,
                    i = colors.green,
                    v = colors.magenta,
                    [""] = colors.blue,
                    v = colors.magenta,
                    c = colors.red,
                    no = colors.magenta,
                    s = colors.orange,
                    [""] = colors.orange,
                    ic = colors.yellow,
                    R = colors.magenta,
                    Rv = colors.magenta,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ["r?"] = colors.cyan,
                    ["!"] = colors.red,
                    t = colors.red
                }

                local alias = {
                    n = "NORMAL",
                    i = "INSERT",
                    c = "COMMAND",
                    V = "VISUAL",
                    [""] = "VISUAL",
                    v = "VISUAL",
                    R = "REPLACE",
                    no = "no",
                    s = "SELECT",
                    [""] = " ",
                    ic = "ic",
                    Rv = "Rv",
                    cv = "cv",
                    ce = "ce",
                    r = "R",
                    rm = "RM",
                    ["r?"] = "r?",
                    ["!"] = "!",
                    t = "TERMINAL"
                }
                vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
                return alias[vim.fn.mode()] .. "   "
            end,
            highlight = {colors.red, colors.bg, "bold"}
        }
    }
    gls.left[4] = {
        FileSize = {
            provider = "FileSize",
            condition = buffer_not_empty,
            highlight = {colors.fg, colors.bg}
        }
    }
    gls.left[5] = {
        FileIcon = {
            provider = "FileIcon",
            condition = buffer_not_empty,
            highlight = {
                require("galaxyline.provider_fileinfo").get_file_icon_color,
                colors.bg
            }
        }
    }

    gls.left[6] = {
        FileName = {
            provider = {"FileName"},
            condition = buffer_not_empty,
            highlight = {colors.green, colors.bg, "bold"}
        }
    }

    gls.left[7] = {
        LineInfo = {
            provider = "LineColumn",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.left[8] = {
        PerCent = {
            provider = "LinePercent",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.fg, colors.bg, "bold"}
        }
    }

    gls.left[9] = {
        DiagnosticError = {
            provider = "DiagnosticError",
            icon = " ",
            highlight = {colors.red, colors.bg}
        }
    }
    gls.left[10] = {
        DiagnosticWarn = {
            provider = "DiagnosticWarn",
            icon = " ",
            highlight = {colors.yellow, colors.bg}
        }
    }

    gls.left[11] = {
        DiagnosticHint = {
            provider = "DiagnosticHint",
            icon = " ",
            highlight = {colors.cyan, colors.bg}
        }
    }

    gls.left[12] = {
        DiagnosticInfo = {
            provider = "DiagnosticInfo",
            icon = " ",
            highlight = {colors.blue, colors.bg}
        }
    }

    gls.left[13] = {
        GetLspClient = {
            provider = "GetLspClient",
            icon = "   ",
            highlight = {colors.yellow, colors.bg}
        }
    }

    gls.right[1] = {
        FileEncode = {
            provider = "FileEncode",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.cyan, colors.bg, "bold"}
        }
    }

    gls.right[2] = {
        FileFormat = {
            provider = "FileFormat",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.cyan, colors.bg, "bold"}
        }
    }

    gls.right[3] = {
        GitIcon = {
            provider = function()
                return "  "
            end,
            condition = require("galaxyline.provider_vcs").check_git_workspace,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.magenta, colors.bg, "bold"}
        }
    }

    gls.right[4] = {
        GitBranch = {
            provider = "GitBranch",
            condition = require("galaxyline.provider_vcs").check_git_workspace,
            highlight = {colors.magenta, colors.bg, "bold"}
        }
    }

    local checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
            return true
        end
        return false
    end

    gls.right[5] = {
        DiffAdd = {
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            provider = "DiffAdd",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.green, colors.bg}
        }
    }
    gls.right[6] = {
        DiffModified = {
            provider = "DiffModified",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.orange, colors.bg}
        }
    }
    gls.right[7] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.red, colors.bg}
        }
    }

    gls.right[8] = {
        RainbowBg = {
            provider = function()
                return "  "
            end,
            highlight = {colors.bg, colors.bg}
        }
    }

    gls.right[9] = {
        RainbowBlue = {
            provider = function()
                return " "
            end,
            highlight = {colors.white1, colors.white1}
        }
    }

    gls.short_line_left[1] = {
        BufferType = {
            provider = "FileTypeName",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.blue, colors.bg, "bold"}
        }
    }

    gls.short_line_left[2] = {
        SFileName = {
            provider = function()
                local fileinfo = require("galaxyline.provider_fileinfo")
                local fname = fileinfo.get_current_file_name()
                for _, v in ipairs(gl.short_line_list) do
                    if v == vim.bo.filetype then
                        return ""
                    end
                end
                return fname
            end,
            condition = buffer_not_empty,
            highlight = {colors.white, colors.bg, "bold"}
        }
    }

    gls.short_line_right[1] = {
        BufferIcon = {provider = "BufferIcon", highlight = {colors.fg, colors.bg}}
    }
end

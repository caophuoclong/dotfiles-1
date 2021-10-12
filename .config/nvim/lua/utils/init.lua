local utils = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

function utils.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

utils.colors = {
    red = "#ffffff",
    orange = "#ffffff",
    bg = "#ffffff",
    fg = "#ffffff",
    yellow = "#ffffff",
    blue = "#ffffff",
    green = "#ffffff",
    cyan = "#ffffff",
    magenta = "#ffffff"
}

local ok, nightfox = pcall(require, "nightfox.colors")
if ok then
    utils.colors = nightfox.load("nordfox")
    utils.colors.bg = "#252933"
    utils.colors.bg1 = "#2E3440"
    utils.colors.white1 = "#D8DEE9"
end

utils.signs = {Error = "", Warn = "", Hint = "", Info = ""}

return utils

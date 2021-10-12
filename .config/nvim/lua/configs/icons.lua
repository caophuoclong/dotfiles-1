local ok, icons = pcall(require, "nvim-web-devicons")
if ok then
    local colors = require("utils").colors
    icons.setup {
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {
            html = {
                icon = "",
                color = colors.orange,
                name = "html"
            },
            css = {
                icon = "",
                color = colors.blue,
                name = "css"
            },
            js = {
                icon = "",
                color = colors.yellow,
                name = "js"
            },
            ts = {
                icon = "ﯤ",
                color = colors.blue,
                name = "ts"
            },
            kt = {
                icon = "󱈙",
                color = colors.orange,
                name = "kt"
            },
            png = {
                icon = "",
                color = colors.magenta,
                name = "png"
            },
            jpg = {
                icon = "",
                color = colors.cyan,
                name = "jpg"
            },
            jpeg = {
                icon = "",
                color = colors.cyan,
                name = "jpeg"
            },
            mp3 = {
                icon = "",
                color = colors.green,
                name = "mp3"
            },
            mp4 = {
                icon = "",
                color = colors.green,
                name = "mp4"
            },
            out = {
                icon = "",
                color = colors.blue,
                name = "out"
            },
            Dockerfile = {
                icon = "",
                color = colors.blue,
                name = "Dockerfile"
            },
            rb = {
                icon = "",
                color = colors.red,
                name = "rb"
            },
            vue = {
                icon = "﵂",
                color = colors.green,
                name = "vue"
            },
            py = {
                icon = "",
                color = colors.orange,
                name = "py"
            },
            toml = {
                icon = "",
                color = colors.blue,
                name = "toml"
            },
            lock = {
                icon = "",
                color = colors.red,
                name = "lock"
            },
            zip = {
                icon = "",
                color = colors.cyan,
                name = "zip"
            },
            xz = {
                icon = "",
                color = colors.cyan,
                name = "xz"
            },
            deb = {
                icon = "",
                color = colors.red,
                name = "deb"
            },
            rpm = {
                icon = "",
                color = colors.red,
                name = "rpm"
            },
            lua = {
                icon = "",
                color = colors.blue,
                name = "lua"
            },
            txt = {
                icon = "",
                color = colors.blue,
                name = "txt"
            },
            md = {
                icon = "",
                color = colors.magenta,
                name = "markdown"
            },
            [".prettierrc"] = {
                icon = "",
                color = colors.cyan,
                name = "prettier"
            },
            [".prettierrc.json"] = {
                icon = "",
                color = colors.cyan,
                name = "prettierjson"
            },
            [".prettierrc.js"] = {
                icon = "",
                color = colors.cyan,
                name = "prettierrcjs"
            },
            ["prettier.config.js"] = {
                icon = "",
                color = colors.cyan,
                name = "prettierjsconfig"
            },
            [".prettier.yaml"] = {
                icon = "",
                color = colors.cyan,
                name = "prettieryaml"
            },
            ["test.js"] = {
                icon = "",
                color = colors.yellow,
                name = "javascripttest"
            },
            ["test.jsx"] = {
                icon = "",
                color = colors.yellow,
                name = "reactrest"
            },
            ["test.ts"] = {
                icon = "",
                color = colors.blue,
                name = "typescripttest"
            },
            ["test.tsx"] = {
                icon = "",
                color = colors.blue,
                name = "reacttypescripttest"
            },
            ["spec.js"] = {
                icon = "",
                color = colors.yellow,
                name = "javascriptspectest"
            },
            ["spec.jsx"] = {
                icon = "",
                color = colors.yellow,
                name = "reactspectest"
            },
            ["spec.ts"] = {
                icon = "",
                color = colors.blue,
                name = "typescriptspectest"
            },
            ["spec.tsx"] = {
                icon = "",
                color = colors.blue,
                name = "reacttypescriptspectest"
            },
            ["yarn.lock"] = {
                icon = "",
                color = colors.blue,
                name = "yarnlock"
            }
        },
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true
    }
end

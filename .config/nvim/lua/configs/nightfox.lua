local ok, nightfox = pcall(require, "nightfox")

if ok then
    nightfox.setup(
        {
            fox = "nordfox", -- change the colorscheme to use nordfox
            transparent = true,
            styles = {
                comments = "italic", -- change style of comments to be italic
                keywords = "bold", -- change style of keywords to be bold
                functions = "bold" -- styles can be a comma separated list
            },
            colors = {
                red = "#FF000", -- Override the red color for MAX POWER
                bg_alt = "#000000"
            },
            hlgroups = {
                TSPunctDelimiter = {fg = "${red}"}, -- Override a highlight group with the color red
                LspCodeLens = {bg = "#000000", style = "italic"}
            }
        }
    )

    nightfox.load()
end

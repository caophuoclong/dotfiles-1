local ok, cmp = pcall(require, "cmp")

if ok then
    local lspkind = require("lspkind")

    -- Color highlight cmp menu items
    vim.api.nvim_command [[
        highlight CmpItemAbbr guifg=#A3BE8C
        highlight CmpItemKind guifg=#B48EAD
        highlight CmpItemMenu guifg=#D08770
    ]]

    require("luasnip/loaders/from_vscode").lazy_load(
        {
            paths = {
                "~/.config/nvim/snippets/vscode-es7-javascript-react-snippets",
                "~/.config/nvim/snippets/friendly-snippets"
            }
        }
    )

    local icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
    }

    cmp.setup(
        {
            -- Disable default behavior confirmation LSP
            confirmation = {
                get_commit_characters = function()
                    return {}
                end
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
                keyword_length = 1
            },
            formatting = {
                format = function(entry, vim_item)
                    -- Set Icons for completion menu
                    -- vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
                    vim_item.kind = string.format("%s", icons[vim_item.kind])

                    vim_item.menu =
                        ({
                        buffer = "[BUFFER]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[LUA]",
                        cmp_tabnine = "[TABNINE]",
                        path = "[PATH]",
                        luasnip = "[SNIPPET]"
                    })[entry.source.name]

                    return vim_item
                end
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ["<Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                            ""
                        )
                    else
                        fallback()
                    end
                end,
                ["<S-Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require("luasnip").jumpable(-1) then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                    else
                        fallback()
                    end
                end
            },
            sources = {
                {name = "nvim_lsp"},
                {name = "luasnip"},
                {name = "buffer"},
                {name = "cmp_tabnine"}
            }
        }
    )
end

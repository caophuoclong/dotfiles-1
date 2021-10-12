local ok, lsp_config = pcall(require, "lspconfig")

if ok then
    local utils = require("utils")

    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- LSP Keymaps
        local opts = {noremap = true, silent = true}
        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        -- Disable default formatter from LSP
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        -- Signature (hint) show up when using function/method
        require "lsp_signature".on_attach()
    end

    local servers = {
        pyright = {},
        gopls = {
            cmd = {"gopls", "--remote=auto"},
            filetypes = {"go", "gomod"},
            capabilties = {
                textDocuemnt = {
                    completion = {
                        completionItem = {
                            snippetSupport = true
                        }
                    }
                }
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true
            }
        },
        sqlls = {
            cmd = {"sql-language-server", "up", "--method", "stdio"}
        },
        clangd = {},
        tsserver = {},
        html = {},
        bashls = {},
        cssls = {},
        graphql = {},
        dockerls = {},
        sumneko_lua = {
            cmd = {"lua-language-server", "-E"}
        },
        yamlls = {},
        prismals = {}
    }

    local lsp_default_config = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 0
        },
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }

    for server, config in pairs(servers) do
        lsp_config[server].setup(vim.tbl_deep_extend("force", lsp_default_config, config))
    end

    -- Gutter sign icons
    for type, icon in pairs(utils.signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
    end

    -- Diagnostics icons right side of code
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = {
                spacing = 6,
                prefix = "▊"
            },
            signs = true,
            underline = false,
            update_in_insert = true
        }
    )
end

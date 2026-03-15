return {
    "neovim/nvim-lspconfig",

    config = function()
        local nvim_lsp = vim.lsp
        local servers = {
            "clangd", "ruff", "rust_analyzer", "ts_ls", "ty",
        }

        local opts = { noremap = true, silent = true }

        vim.diagnostic.config({ virtual_text = true })
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

        local on_attach = function(_, bufnr) -- (client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format { async = true }
            end, bufopts)
        end

        local lsp_flags = { debounce_text_changes = 150, }

        nvim_lsp.config("lua_ls", {
            on_attach = on_attach,
            flags = lsp_flags,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT", },
                    diagnostics = { globals = { "vim" }, },
                    -- TOOD: Not working...
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                    telemetry = { enable = false, },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library"
                        },
                    },
                },
            },
        })
        nvim_lsp.enable("lua_ls")

        nvim_lsp.config("tailwindcss", {
            on_atach = on_attach,
            flags = lsp_flags,
            filetypes = {
                "htmldjango", "html", "css", "less", "sass", "scss",
                "javascript", "javascriptreact", "typescript",
                "typescriptreact", "vue", "svelte",
            },
        })
        nvim_lsp.enable("tailwindcss")

        for _, lsp in ipairs(servers) do
            nvim_lsp.config(lsp, {
                on_attach = on_attach,
                flags = lsp_flags,
            })
            nvim_lsp.enable(lsp)
        end
    end
}


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {}, },
        "mason-org/mason-lspconfig.nvim",

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        -- Set up lspconfig.
        local nvim_lsp = vim.lsp
        local servers = {
            "clangd", "ruff", "rust_analyzer", "ts_ls", "ty",
        }

        local capabilities = cmp_lsp.default_capabilities()
        local opts = { noremap = true, silent = true }

        vim.diagnostic.config({ virtual_text = true })
        vim.keymap.set('n', "<space>e", vim.diagnostic.open_float, opts)
        vim.keymap.set('n', "<space>q", vim.diagnostic.setloclist, opts)

        local on_attach = function(_, bufnr) -- (client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set('n', "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', "<C-k>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', "<space>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', "<space>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', "<space>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', "gr", vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', "<space>f", function()
                vim.lsp.buf.format { async = true }
            end, bufopts)
        end

        local lsp_flags = { debounce_text_changes = 150, }

        nvim_lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT", },
                    diagnostics = { globals = { "vim" }, },
                    -- TOOD: Not working...
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = '2',
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

        nvim_lsp.config("tailwindcss", {
            filetypes = {
                "htmldjango", "html", "css", "less", "sass", "scss",
                "javascript", "javascriptreact", "typescript",
                "typescriptreact", "vue", "svelte",
            },
        })

        for _, new_server in ipairs({ "lua_ls", "tailwindcss" }) do
            table.insert(servers, new_server)
        end

        for _, lsp in ipairs(servers) do
            nvim_lsp.config(lsp, {
                on_attach = on_attach,
                flags = lsp_flags,
                capabilities = capabilities,
            })
        end

        require("mason-lspconfig").setup({
            ensure_installed = servers,
        })
    end
}


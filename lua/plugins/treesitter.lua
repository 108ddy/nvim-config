local languages = {
    "asm", "bash", 'c', "cmake", "cpp", "css",
    "desktop", "dockerfile", "gitignore", "graphql",
    "html", "htmldjango", "http", "java", "javascript", "json",
    "lua", "markdown", "markdown_inline", "python", "query",
    "rust", "scss", "sql", "tmux", "tsx", "typescript", "vim",
    "vue", "xml", "yaml", "zig",
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("nvim-treesitter.setup", {}),
            callback = function(args)
                local buf = args.buf
                local filetype = args.match

                local language = vim.treesitter.language.get_lang(filetype) or filetype
                if not vim.treesitter.language.add(language) then
                    return
                end

                -- replicate `indent = { enable = true }`
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- replicate `highlight = { enable = true }`
                vim.treesitter.start(buf, language)
            end
    }) end,
}

